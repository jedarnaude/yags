# Global initializations required

window.YAGS = {}

window.requestAnimationFrame ||= 
	window.webkitRequestAnimationFrame || 
	window.mozRequestAnimationFrame    || 
	window.oRequestAnimationFrame      || 
	window.msRequestAnimationFrame     || 
	(callback, element) -> 
		window.setTimeout( 
			-> callback(+new Date()), 
			1000 / 60 )