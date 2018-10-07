{script src="addons/payfort_fort/js/payfort_fort.js"}

{if $card_id}
	{assign var="id_suffix" value="_`$card_id`"}
{else}
	{assign var="id_suffix" value=""}
{/if}
{assign var="card_item" value=$card_data|default:$cart.payment_info}

<table cellpadding="0" cellspacing="0" border="0" class="credit-card">
<tr valign="top">
	<td>
		<div class="form-field">
			<label for="cc_type{$id_suffix}" class="cm-required cm-cc-type">{$lang.select_card}</label>
			<select id="cc_type{$id_suffix}" name="payment_info[card]" onchange="fn_check_cc_type(this.value, '{$id_suffix}');">
				{foreach from=$credit_cards item="c"}
                                        {if $c.param eq 'vis' or $c.param eq 'mcd'}
					<option value="{$c.param}" {if $card_item.card == $c.param}selected="selected"{/if}>{$c.descr}</option>
                                        {/if}
				{/foreach}
			</select>
		</div>
		
		<div class="form-field">
			<label for="payfort_fort_card_number{$id_suffix}" class="cm-required cm-custom (validate_cc)">{$lang.card_number}</label>
			<input id="payfort_fort_card_number{$id_suffix}" size="35" maxlength="19" type="text" name="payment_info[card_number]" value="" class="input-text cm-autocomplete-off" />
		</div>

		<div class="form-field">
			<label for="cc_name{$id_suffix}" class="cm-required">{$lang.cardholder_name}</label>
			<input id="cc_name{$id_suffix}" size="35" maxlength="50" type="text" name="payment_info[cardholder_name]" value="" class="input-text cm-autocomplete-off" />
		</div>

		<div class="form-field hidden" id="display_start_date{$id_suffix}">
			<label class="cm-required">{$lang.start_date}</label>
			<label for="cc_start_month{$id_suffix}" class="hidden cm-required cm-custom (check_cc_date)">{$lang.month}</label><label for="cc_start_year{$id_suffix}" class="hidden cm-required cm-custom (check_cc_date)">{$lang.year}</label>
			<input type="text" id="cc_start_month{$id_suffix}" name="payment_info[start_month]" value="" size="2" maxlength="2" class="input-text-short" />&nbsp;/&nbsp;<input type="text" id="cc_start_year{$id_suffix}" name="payment_info[start_year]" value="" size="2" maxlength="2" class="input-text-short" />&nbsp;({$lang.expiry_date_format})
		</div>

		<div class="form-field">
			<label class="cm-required">{$lang.expiry_date}</label>
			<label for="payfort_fort_expiry_month{$id_suffix}" class="hidden cm-required cm-custom (check_cc_date)">{$lang.month}:</label><label for="payfort_fort_expiry_year{$id_suffix}" class="hidden cm-required cm-custom (check_cc_date)">{$lang.year}</label>
			<input type="text" id="payfort_fort_expiry_month{$id_suffix}" name="payment_info[expiry_month]" value="" size="2" maxlength="2" class="input-text-short cm-autocomplete-off" />&nbsp;/&nbsp;<input type="text" id="payfort_fort_expiry_year{$id_suffix}" name="payment_info[expiry_year]" value="" size="2" maxlength="2" class="input-text-short cm-autocomplete-off" />&nbsp;({$lang.expiry_date_format})
		</div>

		<div class="form-field" id="display_cvv2{$id_suffix}">
			<label for="payfort_fort_card_security_code{$id_suffix}" class="cm-required cm-integer cm-autocomplete-off">{$lang.cvv2}</label>
			<input id="payfort_fort_card_security_code{$id_suffix}" type="text" name="payment_info[cvv2]" value="" size="4" maxlength="4" class="input-text-short cm-autocomplete-off" disabled="disabled" />

			{if $smarty.const.AREA == "C"}
			<div class="cvv2">{$lang.what_is_cvv2}
				<div class="cvv2-note">
					{include file="views/orders/components/payments/cvv2_info.tpl"}
				</div>
			</div>
			{/if}
		</div>

		<div class="form-field hidden" id="display_issue_number{$id_suffix}">
			<label for="cc_issue_number{$id_suffix}" class="cm-integer">{$lang.issue_number}</label>
			<input id="cc_issue_number{$id_suffix}" type="text" name="payment_info[issue_number]" value="" size="2" maxlength="2" class="input-text-short cm-autocomplete-off" disabled="disabled" />&nbsp;{$lang.if_printed_on_your_card}
		</div>
	</td>
	<td>
		<div id="cc_images{$id_suffix}">
		{foreach from=$credit_cards item="c" name="credit_card"}
			{if $c.icon}
				{if $smarty.foreach.credit_card.first}
					{assign var="img_class" value="cm-cc-item"}
				{else}
					{assign var="img_class" value="cm-cc-item hidden"}
				{/if}
				{include file="common_templates/image.tpl" images=$c.icon class=$img_class obj_id="`$c.param``$id_suffix`" object_type="credit_card" max_width="50" max_height="50" make_box=true proportional=true show_thumbnail="Y"}
			{/if}
		{/foreach}
		</div>
	</td>
</tr>
</table>

<script type="text/javascript" class="cm-ajax-force">
//<![CDATA[
	{if $smarty.capture.cc_script != 'Y'}
	lang.error_card_number_not_valid = '{$lang.error_card_number_not_valid|escape:javascript}';

	var cvv2_required = new Array();
	var start_date_required = new Array();
	var issue_number_required = new Array();
	{foreach from=$credit_cards item="c"}
		cvv2_required['{$c.param}'] = '{$c.param_2}';
		start_date_required['{$c.param}'] = '{$c.param_3}';
		issue_number_required['{$c.param}'] = '{$c.param_4}';
	{/foreach}

	{literal}
	function fn_check_cc_type(card, suffix)
	{
		if (cvv2_required[card] == 'Y') {
			$('#display_cvv2' + suffix).switchAvailability(false);
		} else {
			$('#display_cvv2' + suffix).switchAvailability(true);
		}

		if (start_date_required[card] == 'Y') {
			$('#display_start_date' + suffix).switchAvailability(false);
		} else {
			$('#display_start_date' + suffix).switchAvailability(true);
		}

		if (issue_number_required[card] == 'Y') {
			$('#display_issue_number' + suffix).switchAvailability(false);
		} else {
			$('#display_issue_number' + suffix).switchAvailability(true);
		}

		$('div#cc_images' + suffix).find('.cm-cc-item').hide();
		$('#det_img_' + card + suffix).show();
	}

	function fn_check_cc_date(id)
	{
		var elm = $('#' + id);

		if (!$.is.integer(elm.val())) {
			return lang.error_validator_integer;
		} else {
			if (elm.val().length == 1) {
				elm.val('0' + elm.val());
			}
		}

		return true;
	}
	{/literal}
	
	{capture name="cc_script"}Y{/capture}
	{/if}

	fn_check_cc_type($('#cc_type{$id_suffix}').val(), '{$id_suffix}');
        
        {literal}
        $(function(){
            $('#place_order_{/literal}{$tab_id}{literal}').click(function(e) {
                e.preventDefault();
                var jelm = $(this),
                form = jelm.parents('form');
                var f = new form_handler(form);
                if (!f.check()) {
                    return false;
                }
                var card_security_code = $("#payfort_fort_card_security_code{/literal}{$id_suffix}{literal}").val();
                var card_number = $("#payfort_fort_card_number{/literal}{$id_suffix}{literal}").val();
                var expiry_month = $("#payfort_fort_expiry_month{/literal}{$id_suffix}{literal}").val();
                var expiry_year = $("#payfort_fort_expiry_year{/literal}{$id_suffix}{literal}").val();
                var card_holder_name = $("#payfort_fort_card_holder_name{/literal}{$id_suffix}{literal}").val();
                var expiry_date = expiry_year+''+expiry_month;

                data = form.serialize() + '&integration_type=merchantPage2';
                $.ajaxRequest("{/literal}{'checkout.place_order'|fn_url}{literal}", {
                    method: "post",
                    caching: false,
                    force_exec: true,
                    data: data,
                    callback: function(response) {
                        var data = JSON.parse(response.text);
                        if (data.params) {
                            $('#payfort_payment_form').remove();
                            $('<form name="payfort_payment_form" id="payfort_payment_form" style="display:none" method="post"></form>').appendTo('body');
                            data.params.card_number = card_number.replace(/\s+/g, '');
                            data.params.card_holder_name = card_holder_name;
                            data.params.card_security_code = card_security_code;
                            data.params.expiry_date = expiry_date;
                            $.each(data.params, function(k, v){
                                $('<input>').attr({
                                    type: 'hidden',
                                    id: k,
                                    name: k,
                                    value: v
                                }).appendTo('#payfort_payment_form'); 
                            });
                            $('#payfort_payment_form').attr('action', data.url);
                            $('#payfort_payment_form').submit();
                        }
                        else {
                            location.reload();
                        }
                    }
                });
                return false;
            });
        });
        {/literal}
//]]>
</script>
