<?php
/**
 * @var array $processor_data
 * @var array $order_info
 * @var string $mode
 */
if ( !defined('AREA') ) { die('Access denied'); }

// Return from payfort website
if (defined('PAYMENT_NOTIFICATION')) {
    
    if ($mode == 'return') {
        fn_payfort_fort_process_response('payfort_fort_sadad');        
    }
    elseif ($mode == 'notify') {
        fn_order_placement_routines($_REQUEST['order_id']);
    }
    
} else {
    fn_payfort_fort_process_request($order_id, $order_info, 'payfort_fort_sadad');
}
exit;
