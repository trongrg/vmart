$(document).ready ->
  $("#nav_bar .nav_item a").click (e) ->
    url = $(this).attr("href")
    e.preventDefault()
    if $(this).is(".active")
      return
    $("#nav_bar .active").removeClass("active")
    $(this).addClass("active")
    if !$("#content").is(":visible")
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
            $("#content").animate(
              top: "+=25px"
              left: "+=25px"
              width: $("#content_surrogate").width()
              height: $("#content_surrogate").height()
            )
        }
      )
    else
      $("#content_surrogate .truck").show()
      $("#content .ajax_content").animate(
        {left: 1000}
        {
          duration: 500
          complete: () ->
            $("#content .ajax_content").css("left", "-960px")
        }
      )
      $("#content_surrogate .truck").animate(
        {left: 0}
        {
          duration: 500
          complete: () ->
            $.ajax(
              url: url
              success: (response) ->
                $("#content .ajax_content").html(response)
                $("#content_surrogate .truck").animate(
                  {left: "+=1000px"}
                  {
                    duration: 500
                    complete: () ->
                      $("#content_surrogate .truck").css("left", "-960px")
                  }
                )
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
    $("#content").animate(
      {
        top: "-=25px"
        left: "-=25px"
        width: $("#content_surrogate").width() + 50
        height: $("#content_surrogate").height() + 50
      }
      complete: () ->
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
