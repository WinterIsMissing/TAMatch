/*global $*/
$(function(){
   $('li[id^="email"]').mouseup(function(e){
       //in order to let the course update so we can compare later
       e.preventDefault();
       setTimeout(updateCourse, 0, $(this));
   });
   $('span.mm-delete-btn').mousedown(deleteBtn);
   
   $('#payload-form').submit(function() {  
        var payload = $(this).serialize();
        $.ajax({
            type: "POST",
            url: $(this).attr('action'),
            data: payload,
            dataType: "JSON"
        });
        return false;
    });
});

function deleteBtn(e){
    e.preventDefault();
    let container = $(this).parent().parent().parent().parent();
    if (!container.hasClass("class-search")){
        let email = $(this).parent().attr("id").match(/emails_(.*)/)[1];
        $(this).parent().prependTo("#non-matched ul");
        updateCourse(null, "", email);
        return;
    }
    
    $(this).parent().remove();
}

function updateCourse(el, newCourse=null, email=null){
    let oldCourse;
    if (newCourse === ""){
        oldCourse = " ";
    }
    else{
        let newRow = el.parent().parent().parent();
        newCourse = newRow.find('[type="course"]')[0]
        newCourse = newCourse ? newCourse.innerHTML : "";
        oldCourse = el.attr("course");
        email = el.attr("id").match(/emails_(.*)/)[1];
    }
    //Update!
    
    if(newCourse !== oldCourse){
        $(".mm-score tt").toggleClass("mm-score", true);
        if (el) el.attr("course", newCourse);
        document.getElementById("preference_email").value = email;
        document.getElementById("preference_course").value = newCourse;
        
        $("#payload-form").submit();
        //$("#payload-form").trigger('submit.rails')
    }
}