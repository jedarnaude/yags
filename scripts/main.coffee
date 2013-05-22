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
	renderer = new THREE.WebGLRenderer()
	camera = new THREE.PerspectiveCamera( 45, 400/300, 0.1, 100 )
	scene = new THREE.Scene()

	camera.position.z = 10

	renderer.setSize(400, 300)

	$(".container").append(renderer.domElement)

	vshader = "void main() {
		gl_Position = projectionMatrix *
			modelViewMatrix *
			vec4(position,1.0);
		}"

	fshader = "void main() {
			gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
		}"

	material = new THREE.ShaderMaterial(
		vertexShader: 	vshader
		fragmentShader: fshader 
		)
	sphere = new THREE.Mesh(new THREE.SphereGeometry( 1, 16, 16),  material)

	scene.add(camera)
	scene.add(sphere)

	angle = 0.0

	render = ->
			window.requestAnimationFrame(render, $(".container"))
			renderer.render(scene, camera)
			sphere.position.x = Math.sin(angle) * 2
			angle += 0.1

	render()
