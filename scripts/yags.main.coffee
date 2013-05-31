window.requestAnimationFrame ||= 
	window.webkitRequestAnimationFrame || 
	window.mozRequestAnimationFrame    || 
	window.oRequestAnimationFrame      || 
	window.msRequestAnimationFrame     || 
	(callback, element) -> 
		window.setTimeout( 
			-> callback(+new Date()), 
			1000 / 60 )

$ ->
	canvas = $("#experiment")

	renderer = new THREE.WebGLRenderer()

	camera = new THREE.OrthographicCamera( -1, 1, 1, -1, -1, 1 )
	scene = new THREE.Scene()

	renderer.setSize(canvas.width(), $(window).height())
	canvas.append(renderer.domElement)

	vshader = "
		void main() {
			gl_Position = projectionMatrix *
				modelViewMatrix *
				vec4(position,1.0);
		}"

	fshader = "
		uniform float time;
		uniform vec2 resolution;
		uniform vec3 color;

		void main( void ) {

			vec2 pixel = ( gl_FragCoord.xy / resolution.xy );
			
			gl_FragColor = vec4(vec3(pixel.xy, 0.0) * color, 1.0 );
		}"

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
	# sphere = new THREE.Mesh(new THREE.SphereGeometry( 1, 16, 16),  material)

	scene.add(camera)
	scene.add(mesh)

	# DAT/gui
	gui = new YAGS.GUI()
	token = -> gui.addWidget("color", "background", "#ff00ff", "something")
	gui.addWidget("button", "func", -> token())

	ShaderInputs =
		speed: 0.5
		color: [255, 255, 255]

	# box = new ShaderInputs
	angle = 0.0

	gui.showStats($("#experiment"))
	render = ->
			window.requestAnimationFrame(render, canvas)
			gui.beginStats()
			renderer.render(scene, camera)
			# sphere.position.x = Math.sin(angle) * 2 * box.speed
			angle += 0.1
			uniforms.time.value = Math.sin(angle / 10)
			uniforms.color.value.x = ShaderInputs.color[0] / 255
			uniforms.color.value.y = ShaderInputs.color[1] / 255
			uniforms.color.value.z = ShaderInputs.color[2] / 255
			gui.endStats()

	render()
