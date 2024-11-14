extends Area2D
var mouseOver = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouseOver and Input.is_action_just_pressed("CLICK"):
		print('clicked')

func _on_mouse_entered() -> void:
	mouseOver = true

func _on_mouse_exited() -> void:
	mouseOver = false
