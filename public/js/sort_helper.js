/*global $*/
$(function(){
    $("th[id^=sort]").click(function(){
        let mode = $(this).attr("mode");
        $(".sort-header").removeClass("sort-acc");
        $(".sort-header").removeClass("sort-dec");
        if(!mode || mode == "dec"){
            $(this).attr("mode", "acc");
            $(this).addClass("sort-acc");
            mode = "acc";
        }
        else{
            $(this).attr("mode", "dec");
            $(this).addClass("sort-dec");
            mode = "dec";
        }
        let id = $(this).attr('id');
        let group = id.match(/sort-(.*)/)[1];
        let elements = $(".applicant");
        elements.sort(function(a, b){
            if(group === "stars"){
                //console.log($(a).find('form')[0]);
                let aContent = $(a).find('form')[0].getAttribute(group);
                let bContent = $(b).find('form')[0].getAttribute(group);
                console.log(`${aContent}, ${bContent}`);
                if(mode === "acc")
                    return (aContent - bContent)
                else
                    return (bContent - aContent)
            }
            else{
                let aContent = $(a).find(`[type="${group}"]`)[0].innerHTML;
                let bContent = $(b).find(`[type="${group}"]`)[0].innerHTML;
                if(mode === "acc")
                    return aContent.toUpperCase().localeCompare(bContent.toUpperCase());
                else
                    return bContent.toUpperCase().localeCompare(aContent.toUpperCase());    
            }
        });
        $.each(elements, function(index, item) {
           $("#applicant-list").append(item); 
        });
    });
    console.log("Loaded!");
});

function sorter(id){
    
}