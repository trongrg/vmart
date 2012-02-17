$(document).ready ->
  $("#nav_bar .nav_item a").click (e) ->
    e.preventDefault()
    url = $(this).attr("href")
    #do nothing if the link is already active
    if $(this).is(".active")
      return
    #change active link
    $("#nav_bar .active").removeClass("active")
    $(this).addClass("active")
    #content div is not visible
    if !$("#content").is(":visible")
      #load content by ajax
      $.ajax(
        url: url
        success: (response) ->
          $("#content .ajax_content").html(response)
      )
      width = $(this).width()
      height = $(this).height()
      $("#content").width(width).height(height)
      $("#content").show()
      $("#content").offset($(this).offset())
      top = "+=" + ($("#content_surrogate").offset().top - $(this).offset().top - 25).toString() + "px"
      left = "+=" + ($("#content_surrogate").offset().left - $(this).offset().left - 25).toString() + "px"
      #content fly and scale to 1.1 size of real content
      $("#content").animate(
        {
          top: top
          left: left
          width: $("#content_surrogate").width() + 50
          height: $("#content_surrogate").height() + 50
        }
        {
          duration: 200
          complete: () ->
            #content scale back to 1 size
            $("#content").animate(
              top: "+=25px"
              left: "+=25px"
              width: $("#content_surrogate").width()
              height: $("#content_surrogate").height()
            )
        }
      )
    else
      #show truck div
      $("#content_surrogate .truck").show()
      #ajax content go to the right
      $("#content .ajax_content").animate(
        {left: 1000}
        {
          duration: 500
          complete: () ->
            #reset ajax content position to the left of visible content
            $("#content .ajax_content").css("left", "-960px")
        }
      )
      #truck fly from left to right
      $("#content_surrogate .truck").animate(
        {left: 0}
        {
          duration: 500
          complete: () ->
            #load ajax content when the truck is being displayed
            $.ajax(
              url: url
              success: (response) ->
                $("#content .ajax_content").html(response)
                #after successfully load ajax content, the truck flys to the right and go out
                $("#content_surrogate .truck").animate(
                  {left: "+=1000px"}
                  {
                    duration: 500
                    complete: () ->
                      #reset position of the truck
                      $("#content_surrogate .truck").css("left", "-960px")
                  }
                )
                #ajax content fly from left to center
                $("#content .ajax_content").animate(
                  {left: 20}
                  {duration: 500}
                )
            )
        }
      )
  $("#content .close_btn").click (e) ->
    $target = $("#nav_bar .nav_item .active")
    top = "-=" + ($("#content_surrogate").offset().top - $target.offset().top - 25).toString() + "px"
    left = "-=" + ($("#content_surrogate").offset().left - $target.offset().left - 25).toString() + "px"
    #content scale up to 1.1 size
    $("#content").animate(
      {
        top: "-=25px"
        left: "-=25px"
        width: $("#content_surrogate").width() + 50
        height: $("#content_surrogate").height() + 50
      }
      complete: () ->
        #then fly and scale back to the target menu
        $("#content").animate(
          {
            top: top
            left: left
            width: $target.width()
            height: $target.height()
          }
          {
            duration: 200
            complete: () ->
              $("#content").hide()
              $target.removeClass("active")
          }
        )
    )
  $("#nav_bar .nav_item a.item").mouseover (e) ->
    $target = $(e.currentTarget)
    $target.offset($target.offset())
    $target.animate(
      {top: "-=10px"}
      {duration: 200}
    )
    $sub_menu = $(".sub_menu[item='"+$target.text()+"']")
    $sub_menu.show()
    $sub_menu.offset($target.offset())
    $sub_menu.animate(top: -6)

  $("#nav_bar .nav_item a.item").mouseleave (e) ->
    $target = $(e.currentTarget)
    $target.offset($target.offset())
    $target.animate(
      {top: "+=10px"}
      {duration: 200}
    )

  $("#nav_bar .nav_item a.item").mouseout (e) ->
    $target = $(e.currentTarget)
    $sub_menu = $(".sub_menu[item='"+$target.text()+"']")
    if (e.pageX < $sub_menu.offset().left || e.pageY < $sub_menu.offset().top ||
      e.pageX > $sub_menu.offset().left + $sub_menu.width() ||
      e.pageY > $sub_menu.offset().top + $sub_menu.height()
    )
      $sub_menu.animate(
        {top: "+="+($sub_menu.height()+10)+"px"}
        complete: () ->
          $sub_menu.hide()
      )

  $("#nav_bar .sub_menu").mouseleave (e) ->
    $sub_menu = $(e.currentTarget)
    $sub_menu.animate(
      {top: "+="+($sub_menu.height()+10)+"px"}
      complete: () ->
        $sub_menu.hide()
    )
