var BunnylabType = Class.create();
BunnylabType.addMethods({
	init: function() {
		window.setTimeout(function() {
			var a = new Ajax.Request('/api/events', {
				method: 'get',
				onSuccess: function(transport) {
				}
			});
		}, 1000);
	}
});

$bunnylab = new BunnylabType();
