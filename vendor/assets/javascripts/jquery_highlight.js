jQuery.fn.highlight = function (text, o) {
    return this.each( function(){
        var replace = o || '<span class="highlight">$1</span>';
        $(this).html( html.replace( new 
RegExp('('+text+'(?![\\w\\s?&.\\/;#~%"=-]*>))', "ig"), replace) );
    });
};
