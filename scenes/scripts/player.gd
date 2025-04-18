extends CharacterBody3D

const SENSITIVEITY = 0.001
const SPEED = 6
const JUMP_VELOCITY = 6

#bob varibales
const BOB_FREQ = 2.4 # how often our footsteps happen
const BOB_AMP = 0.08 #how far up and down our cam goes
var t_bob = 0.0 #sine wave how far?
var initial_camera_pos: Vector3
#if there is spring make headbob speed_scale = 1.5
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var headbob = $Head/headbob
@onready var player = $"."

var player_in_range = false

var npc1 =  false

func  _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	initial_camera_pos = camera.transform.origin
	Dialogic.signal_event.connect(DialogicSignal)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVEITY)
		camera.rotate_x(-event.relative.y * SENSITIVEITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(50))
		
func _physics_process(delta):
	if player_in_range:
		if Input.is_action_just_pressed("dialogue"):
			run_dialogue("npc-1")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:	
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED	
		#headbob.play("headbob_walk")
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		#headbob.pause()
		
	move_and_slide()

func _on_area_3d_body_entered(body):
	print("body entered")
	if body.has_method("player1"):
		player_in_range = true

func _on_area_3d_body_exited(body):
	print("body exited")
	if body.has_method("player1"):
		player_in_range = false
		print("WIN")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string) #dialogue_string

func DialogicSignal(node):
	if node.name == "player":  # Change this to match your player node's name
		print("SCORE")
		stop_dialogue()

func stop_dialogue():
	if Dialogic:  
		Dialogic.stop()  # ✅ Stops the dialogue safely

func player1():
	pass
