<?php

function fn_payfort_fort_process_request($order_id, $order_info, $payment_method)
{
    $payfort_order_id = ($order_info['repaid']) ? ($order_id . '_' . $order_info['repaid']) : $order_id;
    $pfOrder          = new Payfort_Fort_Order($payfort_order_id);
    $pfOrder->setOrder($order_info);

    $pfPayment = Payfort_Fort_Payment::getInstance();

    $integration_type = PAYFORT_FORT_INTEGRATION_TYPE_REDIRECTION;
    if ($payment_method == PAYFORT_FORT_PAYMENT_METHOD_CC || $payment_method == PAYFORT_FORT_PAYMENT_METHOD_INSTALLMENTS) {
        $integration_type = $pfOrder->getIntegrationType();
    }
//    if ($order_info['status'] == STATUS_INCOMPLETED_ORDER) {
//        fn_change_order_status($order_id, 'O', '', false);
//    }
//    if (fn_allowed_for('MULTIVENDOR')) {
//        if ($order_info['status'] == STATUS_PARENT_ORDER) {
//            $child_orders = db_get_hash_single_array("SELECT order_id, status FROM ?:orders WHERE parent_order_id = ?i", array('order_id', 'status'), $order_id);
//
//            foreach ($child_orders as $order_id => $order_status) {
//                if ($order_status == STATUS_INCOMPLETED_ORDER) {
//                    fn_change_order_status($order_id, 'O', '', false);
//                }
//            }
//        }
//    }

    $gatewayParams = $pfPayment->getPaymentRequestParams($order_id, $order_info, $payment_method, $integration_type);
    if ($integration_type == PAYFORT_FORT_INTEGRATION_TYPE_MERCAHNT_PAGE || $integration_type == PAYFORT_FORT_INTEGRATION_TYPE_MERCAHNT_PAGE2) {
        $html = ob_get_clean();
        if (function_exists('ob_clean')) {
            @ob_clean();
        }
        error_reporting(0);
        $result = fn_to_json($gatewayParams);
        echo $result;
        exit;
        
    }
    else {
        fn_payfort_fort_submit_form($gatewayParams['url'], $gatewayParams['params']);
    }
}

function fn_payfort_fort_submit_form($url, $data, $action = 'POST')
{
    $form = '<form style="display:none" name="payfort_payment_form" id="payfort_payment_form" method="' . $action . '" action="' . $url . '">';
    foreach ($data as $k => $v) {
        $form .= "<input type='hidden' name='" . htmlentities($k, ENT_QUOTES, 'UTF-8') . "' value='" . htmlentities($v, ENT_QUOTES, 'UTF-8') . "'/>";
    }
    $form .= '<input type="submit" value="" id="payfort_payment_form_submit">';
    $form .= "</form>";
    $form .= "<script type='text/javascript'>"
            . "window.onload = function(){"
            . "document.payfort_payment_form.submit();"
            . "}"
            . "</script>";
    echo $form;
}

function fn_payfort_fort_process_response($payment_method, $response_mode = 'online', $integration_type = PAYFORT_FORT_INTEGRATION_TYPE_REDIRECTION)
{
    $response_params = array_merge($_GET, $_POST); //never use $_REQUEST, it might include PUT .. etc
    $order_id        = isset($response_params['merchant_reference']) ? $response_params['merchant_reference'] : '';
    if (fn_check_payment_script($payment_method . '.php', $order_id)) {
        $pfPayment  = Payfort_Fort_Payment::getInstance();
        $success    = $pfPayment->handleFortResponse($response_params, $response_mode, $payment_method, $integration_type);
        $return_url = fn_url("payment_notification.notify?payment={$payment_method}&order_id={$order_id}", AREA, 'current');
        if ($integration_type == PAYFORT_FORT_INTEGRATION_TYPE_MERCAHNT_PAGE) {
            echo "<html><body onLoad=\"javascript: window.top.location.href='" . $return_url . "'\"></body></html>";
        }
        else {
            echo "<html><body onLoad=\"javascript: self.location='" . $return_url . "'\"></body></html>";
        }
    }
}

function fn_payfort_fort_get_host_to_host_url()
{
    $url = fn_url("payment_notification.return?payment=payfort_fort", 'C', 'current', '&');
    return $url;
}