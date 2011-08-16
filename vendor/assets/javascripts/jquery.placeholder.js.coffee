unless Modernizr.input.placeholder
  $('input[placeholder], textarea[placeholder]')
    .live(
      blur: ->
        input = $ this
        unless input.val()
          input.val(input.attr('placeholder')).addClass('placeholder')
      focus: ->
        input = $ this
        placeholder = input.removeClass('placeholder').attr('placeholder')
        if input.val() == placeholder
          input.val("")
    ).blur()

# TODO: Add a jQuery ajax dataFilter to process new HTML?
