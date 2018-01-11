<?php
if ( !defined('AREA') ) { die('Access denied'); }

if ($mode == 'processor') {
    $processor_data = fn_get_processor_data($_REQUEST['payment_id']);
    if (!empty($_REQUEST['processor_id']) && (empty($processor_data['processor_id']) || $processor_data['processor_id'] != $_REQUEST['processor_id'])) {
        $processor_data = db_get_row("SELECT * FROM ?:payment_processors WHERE processor_id = ?i", $_REQUEST['processor_id']);
    }
    if(in_array($processor_data['processor_script'], array('payfort_fort_cc.php', 'payfort_fort_installments.php','payfort_fort_sadad.php', 'payfort_fort_naps.php'))) {
        $processor_data['admin_template'] = '../../../../addons/payfort_fort/views/payments/components/cc_processors/'.$processor_data['admin_template'];
        $view->assign('processor_template', $processor_data['admin_template']);
    }
}
