$ ->
	canvas = $("#experiment")

	renderer = new THREE.WebGLRenderer()

	camera = new THREE.OrthographicCamera( -1, 1, 1, -1, -1, 1 )
	scene = new THREE.Scene()

	renderer.setSize(canvas.width(), $(window).height())
	canvas.append(renderer.domElement)

	vshader = "void main() {gl_Position = projectionMatrix * modelViewMatrix * vec4(position,1.0); }"
	fshader = "uniform float time; uniform vec2 resolution; uniform vec3 color; void main( void ) {vec2 pixel = ( gl_FragCoord.xy / resolution.xy ); gl_FragColor = vec4(color, 1.0 ); }"

	uniforms =
		time:
			type: "f"
			value: 0.5
		resolution:
			type: "v2"
			value: new THREE.Vector2(canvas.width(), canvas.height());			
		color:
			type: "v3"
			value: new THREE.Vector3( 0, 0.5, 1)

	material = new THREE.ShaderMaterial(
		uniforms:		uniforms
		vertexShader: 	vshader
		fragmentShader: fshader 
		)

	quad = new THREE.PlaneGeometry(2, 2) #$(window).width(), $(window).height());
	mesh = new THREE.Mesh(quad, material);

	scene.add(camera)
	scene.add(mesh)

	# GUI elements
	gui = new YAGS.GUI()
	gui.addWidget("color", "Ambient", "#ff00ff", "Light")
	gui.addWidget("color", "Diffuse", "#00ff00", "Light")
	gui.addWidget("color", "Specular", "#0000ff", "Light")
	gui.addWidget("button", "Show code", -> alert("show code"))

	ShaderInputs =
		speed: 0.5
		color: [255, 255, 255]

	gui.showStats()
	render = ->
			window.requestAnimationFrame(render, canvas)
			gui.beginStats()
			data = gui.getWidget("background")
			renderer.render(scene, camera)
			# sphere.position.x = Math.sin(angle) * 2 * box.speed
			# uniforms.time.value = Math.sin(angle / 10)

			ambient = YAGS.ColorUtils.hexToRGB(gui.getWidget("Ambient"))
			uniforms.color.value.set(ambient[0] / 255, ambient[1] / 255, ambient[2] / 255)
			gui.endStats()

	render()
