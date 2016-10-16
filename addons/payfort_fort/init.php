<?php
if ( !defined('AREA') ) { die('Access denied'); }

fn_register_hooks(
//      'pre_place_order',
        'get_payment_methods'
//        'order_placement_routines'
);

require_once dirname(__FILE__) . '/lib/payfortFort/init.php';