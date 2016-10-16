<?php

class Payfort_Fort_Language
{

    public static function __($input, $args = array(), $domain = 'payment/payfort_fort')
    {
        $langCode = '';
        if (isset($args['lang_code'])) {
            $langCode = $args['lang_code'];
            unset($args['lang_code']);
        }
        if (!empty($langCode)) {
            return fn_get_lang_var($input, $langCode);
        }
        return fn_get_lang_var($input);
    }

    public static function getCurrentLanguageCode()
    {
        return CART_LANGUAGE;
    }

}

?>