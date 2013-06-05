# Utils that I've been needing from time to time, no particular order

class YAGS.ColorUtils
	hexToRGB: (hex) ->
		rgb = parseInt(hex.substring(1), 16)
		[(rgb >> 16) & 0xff, (rgb >> 8) & 0xff, (rgb) & 0xff] if rgb != NaN

# Initializing all utils as default behavior

YAGS.ColorUtils = new YAGS.ColorUtils;