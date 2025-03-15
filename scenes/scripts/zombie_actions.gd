extends CharacterBody3D

var player = null
const SPEED = 4.0
@export var player_path : NodePath

@onready var navigation_agent = $NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector3.ZERO
	navigation_agent.set_target_position(player.global_transform.origin)
	var next_nav_agent = navigation_agent.get_next_path_position()
	velocity = (next_nav_agent - global_transform.origin).normalized() * SPEED
	move_and_slide()
