extends Area3D

@export var dialogue_resource: DialogueResource  # Assign the dialogue file in the Inspector

#func _ready():
	#body_entered.connect(_on_body_entered)
#
#func _on_body_entered(body):
	#if body.name == "player":  # Change to your actual player node name
		#start_dialogue()
#
#func start_dialogue():
	#DialogueManager.play(dialogue_resource)
