{include file="addons/payfort_fort/views/payments/components/payment_method_header_note.tpl"}
<hr />

<div class="form-field">
	<label for="integration_type">{$lang.payfort_fort_integration_type}:</label>
	<select name="payment_data[processor_params][integration_type]" id="payfort_fort_integration_type">
		<option value="redirection"{if $processor_params.integration_type eq "redirection"} selected="selected"{/if}>{$lang.payfort_fort_redirection}</option>
		<option value="merchantPage"{if $processor_params.integration_type eq "merchantPage"} selected="selected"{/if}>{$lang.payfort_fort_merchant_page}</option>
		<option value="merchantPage2"{if $processor_params.integration_type eq "merchantPage2"} selected="selected"{/if}>{$lang.payfort_fort_merchant_page2}</option>
	</select>
</div>