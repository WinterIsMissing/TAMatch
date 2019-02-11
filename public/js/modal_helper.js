/*global $*/
$(function(){
    $('#close-form-modal').click(function(e){
        $('.modal-container').css('display', 'none');
        e.preventDefault();
    });
    $('#open-form-modal').click(function(e){
        $('.modal-container').css('display', 'flex');
        e.preventDefault();
    })
});