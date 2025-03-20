extends CharacterBody3D
#
#var player = null
#const SPEED = 4.0
#const ATTACK_RANGE = 2.5
#
#
#@export var player_path : NodePath
#@onready var animation_tree = $AnimationTree
#
#@onready var navigation_agent = $NavigationAgent3D
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#player = get_node(player_path)
	#
#
 #
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#velocity = Vector3.ZERO
	#navigation_agent.set_target_position(player.global_transform.origin)
	#var next_nav_agent = navigation_agent.get_next_path_position()
	#velocity = (next_nav_agent - global_transform.origin).normalized() * SPEED
	#look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP, true)
	#
##	condition
	#animation_tree.set("parameters/conditions/attack",_target_in_range())
	#animation_tree.set("parameters/conditions/run", !_target_in_range())
	#
	##animation_tree.get("parameters/playback")
	#
	#move_and_slide()
#
#func  _target_in_range():
	#return global_position.distance_to(player.global_position) < ATTACK_RANGE
