extends Node

var canMoveCard = false

func _on_cardspot_1_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot1".position

		

func _on_cardspot_2_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot2".position


func _on_cardspot_9_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot9".position


func _on_cardspot_8_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot8".position


func _on_cardspot_7_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot7".position


func _on_cardspot_6_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot6".position


func _on_cardspot_5_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot5".position


func _on_cardspot_4_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot4".position


func _on_cardspot_3_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		$"../cards/card".position = $"../cardspots/cardspot3".position



func _on_card_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		canMoveCard = true

