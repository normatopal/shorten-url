$(document).ready(function() {
    $("#btn-copy-link").bind( "click", function() {
        $("#short-url-link").select();
    });

    $($("#short-url-link")).blur(function() {
        this.setSelection({"start":0, "end":0});
    });

    $('[data-toggle="tooltip"]').tooltip();
});