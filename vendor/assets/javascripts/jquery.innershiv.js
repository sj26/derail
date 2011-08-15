/*
 * jquery.innershiv: Fixes HTML5 compatibility for jQuery's ajax calls.
 * It seamlessly combines the innershiv script with jQuery ajax methods.
 * No changes need to be made to your jQuery calls.
 * 
 * Credit goes to the original idea here: http://tomcoote.co.uk/javascript/ajax-html5-in-ie/
 * 
 * From: https://gist.github.com/1043892
 * 
 * Wrapped in conditional comments to be IE-only. --sj26
 */
/*@cc_on
//= require innershiv
jQuery.ajaxSetup({
	dataFilter: function(data, dataType) {
	    return (dataType === 'html')
	        ? innerShiv(data, false, false)
	        : data;
	}
});
@*/
