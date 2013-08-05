function updateCountdown() {
    // 140 is the max message length
    var remaining = 140 - jQuery('.dossier_content').val().length;
    jQuery('.countdown').text(remaining + ' characters remaining');
}

jQuery(document).ready(function($) {
    updateCountdown();
    $('.dossier_content').change(updateCountdown);
    $('.dossier_content').keyup(updateCountdown);
});