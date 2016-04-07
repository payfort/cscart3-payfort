<?php
if ( !defined('AREA') ) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if ($mode == 'update' && $_REQUEST['addon'] == 'payfort_fort' && (!empty($_REQUEST['payfort_fort_settings']))) {
        $payfort_fort_settings = isset($_REQUEST['payfort_fort_settings']) ? $_REQUEST['payfort_fort_settings'] : array();
        fn_update_payfort_fort_settings($payfort_fort_settings);
    }
}

if ($mode == 'update') {
    if ($_REQUEST['addon'] == 'payfort_fort') {
        $view->assign('payfort_fort_settings', fn_get_payfort_fort_settings());
    }
}
