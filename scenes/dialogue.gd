extends Area3D

@export var dialogue: DialogueResource;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	DialogueManager.show_dialogue_balloon(dialogue,"main")


func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
