class YAGS.GUI
	constructor: ->
		@render = new dat.GUI()
		@components = {}
		@folders = {}

	showStats: (element) ->
		@stats = new Stats()
		@stats.domElement.style.position = 'absolute'
		@stats.domElement.style.left = '0px'
		@stats.domElement.style.top = '0px'

		element = if element then element else $(document.body)
		element.append(@stats.domElement)

	beginStats: ->
		@stats.begin() if @stats

	endStats: ->
		@stats.end() if @stats

	addWidget: (type, name, value, folder) ->
		if folder
			@folders[name] = @render.addFolder(name) if not @folders.hasOwnProperty(name)
			target = @folders[name]
		else 
			target = @render

		@components[name] = value
		switch type
			when "color" then target.addColor(@components, name)
			when "button" then target.add(@components, name)

	getWidget: (name) ->
		@components[name]