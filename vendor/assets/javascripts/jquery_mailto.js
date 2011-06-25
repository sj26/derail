jQuery.fn.mailto = function () {
    return this.each( function() {
        var re = 
/(([a-z0-9*._+]){1,}\@(([a-z0-9]+[-]?){1,}[a-z0-9]+\.){1,}([a-z]{2,4}|museum)(?![\w\s?&.\/;#~%"=-]*>))/g
        $(this).html( $(this).html().replace( re, '<a href="mailto:$1">$1</a>' 
) );
    });
};
