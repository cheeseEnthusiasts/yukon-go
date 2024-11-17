extends Node



func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		$"../cards/card".position = $"../cardspots/cardspot1".position
		print("cardspot 1 clicked")
		print(str($"../cards/card".position) + ", " + str($"../cardspots/cardspot1".position))
