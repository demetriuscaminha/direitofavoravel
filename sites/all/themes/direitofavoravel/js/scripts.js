(function ($) {
    Drupal.behaviors.mask = {
        attach: function () {
            var tel = $('.mascara-telefone-9digitos');
            if (tel.length != 0) {
                $('.mascara-telefone-9digitos').focusout(function () {
                    var phone, element;
                    element = $(this);
                    element.unsetMask();
                    phone = element.val().replace(/\D/g, '');
                    if (phone.length > 10) {
                        element.setMask("99 99999-9999");
                    } else {
                        element.setMask("99 9999-99999");
                    }
                }).trigger('focusout');
            }
        }
    };

    Drupal.behaviors.geralConf = {
        attach: function () {
 
        }
    };    
})(jQuery);

