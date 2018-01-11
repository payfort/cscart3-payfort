{if isset($payment_method.params.integration_type) and $payment_method.params.integration_type eq 'merchantPage'}
<link href="{$config.skin_path}/addons/payfort_fort/checkout.css" rel="stylesheet" type="text/css" />
{script src="addons/payfort_fort/js/payfort_fort.js"}
<div class="form-payment clearfix">
    {if $payments|count == 1}
            {if $payment.image}
                    <span class="payment-image">
                            <label for="payment_{$payment.payment_id}"><img src="{$payment.image.icon.image_path}" border="0" alt="" class="valign" /></label>
                    </span>
            {/if}
            <label for="payment_{$payment.payment_id}"><strong>{$payment.payment}</strong></label>
            
            <div class="form-payment-field">
                {if $cart.payment_id == $payment.payment_id}
                        {capture name="group_payment"}N{/capture}
                {/if}
                {if $payment.description}
                        <p class="description">{$payment.description}</p>
                {/if}
            </div>
    {/if}

    <div class="pf-iframe-background" id="div-pf-iframe" style="display:none">
        <div class="pf-iframe-container">
            <span class="pf-close-container">
            <i class="pf-iframe-close" onclick="payfortFortMerchantPage.closePopup()"></i>
            </span>
            <!--<i class="fa fa-spinner fa-spin pf-iframe-spin"></i>-->
            <div class="pf-iframe-spin"></div>
            <div class="pf-iframe" id="pf_iframe_content">
            </div>
        </div>
    </div>
</div>
{literal}
<script type="text/javascript">
    $(function(){
        $('#place_order_{/literal}{$tab_id}{literal}').click(function(e) {
            e.preventDefault();
            var jelm = $(this),
            form = jelm.parents('form');
            
            data = form.serialize() + '&integration_type=merchantPage';
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
                        $.each(data.params, function(k, v){
                            $('<input>').attr({
                                type: 'hidden',
                                id: k,
                                name: k,
                                value: v
                            }).appendTo('#payfort_payment_form'); 
                        });
                        payfortFortMerchantPage.showMerchantPage(data.url);
                    }
                    else {
                        location.reload();
                    }
                }
            });
            return false;
        });
    });
</script>
{/literal}
{elseif isset($payment_method.params.integration_type) and $payment_method.params.integration_type eq 'merchantPage2'}
    {include file="addons/payfort_fort/views/orders/components/payments/merchant_page2.tpl"}
{/if}