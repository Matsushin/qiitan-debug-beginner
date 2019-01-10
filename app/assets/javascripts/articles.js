$(document).on('turbolinks:load', function() {
    var $form = $('.js-article-body');
    if ($form.length > 0) {
        $form.keyup(checkChange($form));
        url = $('#js-article-preview').data('previewUrl');
        updatePreview($form.val(), url);

        function checkChange($form) {
            var oldBody = newBody = $form.val();
            return function () {
                newBody = $form.val();
                if (oldBody != newBody) {
                    oldBody = newBody;
                    updatePreview(oldBody, url);
                }
            }
        }
    }

    function updatePreview(body, url) {
        $.ajax({
            type: 'POST',
            url: url,
            dataType: 'script',
            data: {body: body}
        })
    }

    $('.js-comment-edit-link').click(function(e) {
        var $wrapper = $(this).parents('.js-comment-wrapper')
        $wrapper.find('.js-comment-content').addClass('d-none');
        $wrapper.find('.js-comment-edit-form').removeClass('d-none');
        e.preventDefault();
    });

    $('.js-comment-cancel-btn').click(function(e) {
        var $wrapper = $(this).parents('.js-comment-wrapper')
        $wrapper.find('.js-comment-content').removeClass('d-none');
        $wrapper.find('.js-comment-edit-form').addClass('d-none');
        e.preventDefault();
    });
});