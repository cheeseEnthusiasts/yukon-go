extends Node



func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
    if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
        $card.position = $cardspot.position