jQuery.fn.serializeObject = ->
  arrayData = @serializeArray()
  objectData = {}

  $.each arrayData, ->
    if @value?
      value = @value
    else
      value = ''

    if objectData[@name]?
      unless objectData[@name].push
        objectData[@name] = [objectData[@name]]

      objectData[@name].push value
    else
      objectData[@name] = value

  return objectData

$(document).ready ->
  $("ul.nav_bar_container").superfish(
    delay: 1000
    animation: {opacity: 'show', height: 'show'}
    autoArrows: false
    dropShadows: true
    disableHI: true
  )

  $("#nav_bar .nav_item a, #nav_bar .sub_menu_item a").click (e) ->
    if ($(e.target).parents("a").attr("href") == "/")
      return true
    e.preventDefault()
    if ($("#carousel").is(":visible"))
      $("#carousel").hide()
    url = $(this).attr("href")
    #do nothing if the link is already active
    #if $(this).is(".active")
      #return false
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
      $("#content").offset($(this).offset())
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
      #show cargo ship div
      $("#content_surrogate .cargo_ship").show()
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
      #cargo ship fly from left to right
      $("#content_surrogate .cargo_ship").css("z-index", "2000")
      $("#content_surrogate .cargo_ship").animate(
        {left: 0}
        {
          duration: 500
          complete: () ->
            #load ajax content when the cargo_ship is being displayed
            $.ajax(
              url: url
              success: (response) ->
                $("#content .ajax_content").html(response)
                #after successfully load ajax content, the cargo_ship flys to the right and go out
                $("#content_surrogate .cargo_ship").animate(
                  {left: "+=1000px"}
                  {
                    duration: 500
                    complete: () ->
                      #reset position of the cargo ship
                      $("#content_surrogate .cargo_ship").css("left", "-960px")
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
  $("#content_surrogate .close_btn").click (e) ->
    $("#carousel").slideUp()

  $("#content .close_btn").click (e) ->
    $target = $("#nav_bar .nav_item>.active")
    if ($target.length == 0)
      $target = $("#nav_bar .nav_item a:first")
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
              if (!$("#carousel").is(":visible"))
                $("#carousel").show()
          }
        )
    )

  $("#contact_form").submit (e) ->
    alert("submit")
    e.preventDefault()
    $.ajax(
      url: $(this).attr("action")
      type: $(this).attr("method")
      data: $(this).serializeObject()
      success: (data)->
        alert("Thank you")
    )
    return false
  $("input[type='submit']").click (e) ->
    alert("submit")
