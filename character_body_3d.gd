extends CharacterBody3D

const SENSITIVEITY = 0.003
const SPEED = 10
const JUMP_VELOCITY = 6

#bob varibales
const BOB_FREQ = 2.4 # how often our footsteps happen
const BOB_AMP = 0.08 #how far up and down our cam goes
var t_bob = 0.0 #sine wave how far?
var initial_camera_pos: Vector3

@onready var head = $Head
@onready var camera = $Head/Camera3D

func  _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	initial_camera_pos = camera.transform.origin

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVEITY)
		camera.rotate_x(-event.relative.y * SENSITIVEITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(50))
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED	
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		# head bob
		t_bob += delta * velocity.length() * float(is_on_floor())
		camera.transform.origin = _headbob(t_bob)

	move_and_slide()
	
func _headbob(time:float) -> Vector3:
	var pos = initial_camera_pos
	pos.y += sin(time * BOB_FREQ) * BOB_AMP
	return pos
