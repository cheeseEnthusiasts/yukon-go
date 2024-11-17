extends Node

var canMoveCard = false
@onready var card = $"../cards/card"
var cardSpot
var lastCardSpot = "<null>"

func _on_cardspot_1_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot1"
	moveCard(event, card, cardSpot)

func _on_cardspot_2_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot2"
	moveCard(event, card, cardSpot)

func _on_cardspot_3_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot3"
	moveCard(event, card, cardSpot)

func _on_cardspot_4_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot4"
	moveCard(event, card, cardSpot)

func _on_cardspot_5_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot5"
	moveCard(event, card, cardSpot)

func _on_cardspot_6_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot6"
	moveCard(event, card, cardSpot)

func _on_cardspot_7_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot7"
	moveCard(event, card, cardSpot)

func _on_cardspot_8_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot8"
	moveCard(event, card, cardSpot)

func _on_cardspot_9_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	cardSpot = $"../cardspots/cardspot9"
	moveCard(event, card, cardSpot)


func _on_card_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		canMoveCard = true


func moveCard(event, cardF, cardSpotF):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true and canMoveCard:
		cardF.position = cardSpotF.position
		cardSpot.input_pickable = false
		if str(lastCardSpot) != "<null>":
			lastCardSpot.input_pickable = true
		canMoveCard = false;
		lastCardSpot = cardSpotF
