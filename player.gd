extends CharacterBody3D

const SPEED = 6.0
const JUMP_VELOCITY = 5.5
const MOUSE_SENSITIVITY = 0.1  # Adjust sensitivity as needed

var yaw := 0.0  # Horizontal rotation
var pitch := 0.0  # Vertical rotation (if needed for a camera)

func _ready() -> void:
	# Capture the mouse for FPS-style control
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_click_event() -> void:
	print("Click event triggered!")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_on_click_event()
		
	elif event is InputEventMouseMotion:
		# Adjust yaw and pitch based on mouse motion
		yaw -= event.relative.x * MOUSE_SENSITIVITY
		pitch -= event.relative.y * MOUSE_SENSITIVITY
		pitch = clamp(pitch, -30.0, 30.0)  # Limit vertical rotation to avoid flipping

		# Apply rotation to the player
		self.rotation_degrees.y = yaw

		# If you have a camera as a child node, rotate it for pitch
		var head = $Head
		if head:
			head.rotation_degrees.x = pitch

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
