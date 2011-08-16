unless Modernizr.input.placeholder
  jQuery('input[placeholder], textarea[placeholder]')
    .live
      blur: ->
        input = jQuery this
        unless input.val()
          input.val(input.attr('placeholder')).addClass('placeholder')
      focus: ->
        input = jQuery this
        placeholder = input.removeClass('placeholder').attr('placeholder')
        if input.val() == placeholder
          input.val("")
  jQuery ->
    jQuery('input[placeholder], textarea[placeholder]').blur()

# TODO: Add a jQuery ajax dataFilter to process new HTML?
