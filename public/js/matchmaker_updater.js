/*global $*/
$(function(){
   console.log("ready");
   $('li[id^="email"]').mouseup(function(){
       //in order to let the course update so we can compare later
       setTimeout(updateCourse, 0, $(this));
   });
   $('span.mm-delete-btn').mousedown(function(e){
        let container = $(this).parent().parent().parent().parent();
        if (!container.hasClass("class-search")){
            let email = $(this).parent().attr("id").match(/emails_(.*)/)[1];
            updateCourse(null, "", email);
        }
        //setTimeout(()=>$(this).parent().remove(), 0);
        $(this).parent().remove();
   });
});

function updateCourse(el, newCourse=null, email=null){
    console.log(el);
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
    console.log(oldCourse);
    console.log(newCourse);
    
    //Update!
    if(newCourse !== oldCourse){
        if (el) el.attr("course", newCourse);
        document.getElementById("preference_email").value = email;
        document.getElementById("preference_course").value = newCourse;
        
        $("#payload-form").trigger('submit.rails');
    }
}