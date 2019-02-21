/*global $*/
$(function(){
    $(document).on("click", "#indiff-btn", function(){
        $(this).parent().parent().find("#indiff-list").toggleClass("inactive");
    })
});