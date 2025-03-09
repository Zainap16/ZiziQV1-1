extends CharacterBody3D

var player_in_range = false
@onready var chuck = $"."

func _ready():
	Dialogic.signal_event.connect(DialogicSIgnal)

func _on_chat_detection_body_entered(body):
	if body.has_method("player"):
		player_in_range = true
		print("eneter")

func _on_chat_detection_body_exited(body):
	if body.has_method("player"):
		player_in_range = false
		
func _process(delta):
	if player_in_range:
		if Input.is_action_just_pressed("dialogue"):
			run_dialogue("npc-1")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func DialogicSIgnal(body):
	if body.name == "chuck":  # Change this to match your player node's name
		print("Player exited the range")
		stop_dialogue()

func stop_dialogue():
	if Dialogic:  
		Dialogic.stop()  # ✅ Stops the dialogue safely
