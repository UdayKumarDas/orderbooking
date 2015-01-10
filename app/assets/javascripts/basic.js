

function initialize() {


var defaultBounds = new google.maps.LatLngBounds(
	new google.maps.LatLng(21.0000, 78.0000)
	);

var origin_input = document.getElementById('search');

var options = {
	bounds: defaultBounds,
	componentRestrictions: {country: 'ind'}
};


var autocomplete_origin = new google.maps.places.Autocomplete(origin_input, options);    

}

google.maps.event.addDomListener(window, 'load', initialize);


