var BUNNYLAB = (function () {
	var my = {},
		privateVariable = 1;
	
	function privateMethod() {
		// ...
	}
	
	// public section
	my.init = function() {
		window.setInterval(function() {
			var a = new Ajax.Request('/api/status', {
				method: 'get',
				onSuccess: function(transport) {
				}
			});
		}, 1000);
	}
	
	return my;
}());
