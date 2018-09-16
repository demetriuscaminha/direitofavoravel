(function ($) {
    window.callPlayer = function (iframe, func, args) {
        var iframe = document.getElementById(iframe);
        var src = iframe.getAttribute('src');

        if (src && src.indexOf('youtube.com/embed') !== -1) {
            iframe.contentWindow.postMessage(JSON.stringify({
                'event': 'command',
                'func': func,
                'args': args || []
            }), '*');
        }
    };

    Drupal.behaviors.youtubeVideos = {
        attach: function () {

            var tag = document.createElement('script');
            tag.src = "//www.youtube.com/player_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

            //Player do youtube usando como thumbnail customizável
            $('.youtube-image-thumbnail').each(function () {
                var image = $(this);
                var video = $(this).siblings('.youtube-video');

                if (video.length !== 0) {
                    $(image).click(function (ev) {
                        $(image).addClass('hidden');
                        video.removeClass('hidden');

                        var iframe_id = video.find('iframe').attr('id');
                        callPlayer(iframe_id, 'playVideo');
                        ev.preventDefault();
                    });
                }
            });
        }
    };
        
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

