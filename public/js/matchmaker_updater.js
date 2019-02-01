/*global $*/
$(function(){
   console.log("ready");
   $('li[id^="email"]').mouseup(function(){
       //in order to let the course update so we can compare later
       setTimeout(updateCourse, 0, $(this));
   });
});

function updateCourse(el){
    let oldCourse = el.attr("course");
    let newRow = el.parent().parent().parent();
    let newCourse = newRow.find('[type="course"]')[0].innerHTML;
    console.log(oldCourse);
    console.log(newCourse);
    
    //Update!
    if(newCourse !== oldCourse){
        el.attr("course", newCourse);
        document.getElementById("preference_email").value = el.text().trim();
        document.getElementById("preference_course").value = newCourse;
        
        $("#payload-form").trigger('submit.rails');
    }
}