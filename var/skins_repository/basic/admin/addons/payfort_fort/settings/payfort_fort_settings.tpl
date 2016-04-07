<div class="form-field">
    <label class="left description" for="payfort_fort_language">{$lang.language}:</label>
    <select name="payfort_fort_settings[payment_settings][language]" id="payfort_fort_language">
        <option value="store"{if $payfort_fort_settings.payment_settings.language eq "store"} selected="selected"{/if}>{$lang.payfort_fort_store_language}</option>
        <option value="en"{if $payfort_fort_settings.payment_settings.language eq "en"} selected="selected"{/if}>{$lang.payfort_fort_english}</option>
        <option value="ar"{if $payfort_fort_settings.payment_settings.language eq "ar"} selected="selected"{/if}>{$lang.payfort_fort_arabic}</option>
    </select>
</div>

<div class="form-field">
    <label class="left description" for="payfort_fort_merchant_identifier">{$lang.payfort_fort_merchant_identifier}:</label>
    <input type="text" name="payfort_fort_settings[payment_settings][merchant_identifier]" id="payfort_fort_merchant_identifier" size="60" value="{$payfort_fort_settings.payment_settings.merchant_identifier}" class="input-text" />
</div>

<div class="form-field">
    <label class="left description" for="payfort_fort_access_code">{$lang.payfort_fort_access_code}:</label>
    <input type="text" name="payfort_fort_settings[payment_settings][access_code]" id="payfort_fort_access_code" size="60" value="{$payfort_fort_settings.payment_settings.access_code}" class="input-text" />
</div>

<div class="form-field">
    <label class="left description" for="payfort_fort_command">{$lang.payfort_fort_command}:</label>
    <select name="payfort_fort_settings[payment_settings][command]" id="payfort_fort_command">
        <option value="PURCHASE"{if $payfort_fort_settings.payment_settings.command eq "PURCHASE"} selected="selected"{/if}>{$lang.payfort_fort_purchase}</option>
        <option value="AUTHORIZATION"{if $payfort_fort_settings.payment_settings.command eq "AUTHORIZATION"} selected="selected"{/if}>{$lang.payfort_fort_authorization}</option>
    </select>
</div>

<div class="form-field">
    <label class="left description" for="payfort_fort_hash_algorithm">{$lang.payfort_fort_hash_algorithm}:</label>
    <select name="payfort_fort_settings[payment_settings][hash_algorithm]" id="payfort_fort_hash_algorithm">
        <option value="sha1"{if $payfort_fort_settings.payment_settings.hash_algorithm eq "sha1"} selected="selected"{/if}>sha-1</option>
        <option value="sha256"{if $payfort_fort_settings.payment_settings.hash_algorithm eq "sha256"} selected="selected"{/if}>sha-256</option>
        <option value="sha512"{if $payfort_fort_settings.payment_settings.hash_algorithm eq "sha512"} selected="selected"{/if}>sha-512</option>
    </select>
</div>

<div class="form-field">
    <label class="left description" for="payfort_fort_sha_in_pass_phrase">{$lang.payfort_fort_request_sah_phrase}:</label>
    <input type="text" name="payfort_fort_settings[payment_settings][sha_in_pass_phrase]" id="payfort_fort_sha_in_pass_phrase" size="60" value="{$payfort_fort_settings.payment_settings.sha_in_pass_phrase}" class="input-text" />
</div>

<div class="form-field">
    <label class="left description" for="payfort_fort_sha_out_pass_phrase">{$lang.payfort_fort_response_sah_phrase}:</label>
    <input type="text" name="payfort_fort_settings[payment_settings][sha_out_pass_phrase]" id="payfort_fort_order_sha_out_pass_phrase" size="60" value="{$payfort_fort_settings.payment_settings.sha_out_pass_phrase}" class="input-text" />
</div>

<div class="form-field">
    <label class="left description" for="payfort_fort_mode">{$lang.payfort_fort_mode}:</label>
    <select name="payfort_fort_settings[payment_settings][mode]" id="payfort_fort_mode">
        <option value="sandbox"{if $payfort_fort_settings.payment_settings.mode eq "sandbox"} selected="selected"{/if}>{$lang.payfort_fort_sandbox}</option>
        <option value="live"{if $payfort_fort_settings.payment_settings.mode eq "live"} selected="selected"{/if}>{$lang.payfort_fort_live}</option>
    </select>
</div>
{assign var="payfort_fort_host_url" value=''|fn_payfort_fort_get_host_to_host_url}
<div class="form-field">
    <label class="left description" for="payfort_fort_mode"><strong>{$lang.payfort_fort_host_to_host_url}:</strong></label>
    <strong style="float: left; padding-top: 5px;">{$payfort_fort_host_url}</strong>
</div>