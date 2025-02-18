extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_SLOT = 2

var screen_size
var card_being_dragged
var is_hovering_on_card
var card_preview

var player


func _ready() -> void:
	screen_size = get_viewport_rect().size
	card_preview = $"../CardPreview"
	player = $'../Player'
	MultiplayerManager.join()


func _process(_delta: float) -> void:
	# If there is a card that is being dragged, then this will set its position to the current mouse position
	# the "clamp" function takes in three values: the value you want to set it to, the minimum value it can be, and the maximum value it can be
	# if the value given is greater or less than the min/max, it will clamp it to those values so it cannot move farther
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		var tween = get_tree().create_tween()
		tween.tween_property(card_being_dragged, "position", Vector2(clamp(mouse_pos.x, 0, screen_size.x), clamp(mouse_pos.y, 0, screen_size.y)), 0.02)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check_for_card()
			if card:
				start_drag(card)
		else:
			if card_being_dragged:
				finish_drag()

	if event.is_action_pressed('ENTER'):
		player.construct_card(5, 0, false)


# Card dragging functions
func start_drag(card):
	if not card.in_slot:
		card_preview.texture = null
		card_being_dragged = card
		var tween = get_tree().create_tween()
		tween.tween_property(card, "scale", Vector2(1, 1), 0.05)

func finish_drag():
	var p_hand = $"../Hand"
	var tween = get_tree().create_tween()
	tween.tween_property(card_being_dragged, "scale", Vector2(1.05, 1.05), 0.05)
	card_being_dragged.z_index = 1

	# the following functions check if you let go of a card, and then move directly onto another card and start dragging it
	# this is mostly just to prevent visual errors
	var spot = raycast_check_for_card_slot()
	if spot and not spot.card_in_slot and not spot.get_parent().name == "OpponentSlots":
		place_card_in_spot(spot, p_hand, card_being_dragged)
		
	else:
		p_hand.update_hand_position()
		
	card_being_dragged = null

func place_card_in_spot(spot, p_hand, card):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", spot.position, 0.05)
	card.in_slot = true
	spot.card_in_slot = true
	p_hand.hand.erase(card)
	p_hand.update_hand_position()
	player.energy -= card.cost
	MultiplayerManager.update_cards.rpc_id(1, MultiplayerManager.client_id, [card.cost, card.dmg], spot.id)

func place_card_in_opponent_spot(spot, card):
	var p_hand = $"../Hand"
	p_hand.hand.erase(card)
	print('received ' + str(card, spot))
	card.position = spot.position
	print('placed card at ', spot.position, ". card is now at ", card.position)
	card.in_slot = true
	spot.card_in_slot = true
	

# Card hover effect functions
func on_hovered_over_card(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(card, true)

func on_hovered_off(card):
	highlight_card(card, false)
	var new_card = raycast_check_for_card()
	if new_card:
		highlight_card(new_card, true)
	else:
		is_hovering_on_card = false

func highlight_card(card, hovered):
	if hovered and not card_being_dragged:
		card_preview.texture = card.get_node('CardImage').texture
		var tween = get_tree().create_tween()
		tween.tween_property(card, "scale", Vector2(1.05, 1.05), 0.05)
		card.z_index = 2
	else:
		card_preview.texture = null
		var tween = get_tree().create_tween()
		tween.tween_property(card, "scale", Vector2(1, 1), 0.05)
		card.z_index = 1


# Checks if the mouse is over a Card (or any element with a collision mask equal to COLLISION_MASK_CARD), and returns if it if there is
# this would be used as a variable, for example "var card = raycast_check_for_card()" and it will be null if did not find anything
func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var perameters = PhysicsPointQueryParameters2D.new()
	perameters.position = get_global_mouse_position()
	perameters.collide_with_areas = true
	perameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(perameters)

	if result.size() > 0:
		return result[0].collider.get_parent()
	return null


# Checks if the mouse is over a CardSlot (or any element with a collision mask equal to COLLISION_MASK_SLOT), and returns if it if there is
# this would be used as a variable, for example "var card_slot = raycast_check_for_card_slot()" and it will be null if did not find anything
func raycast_check_for_card_slot():
	var space_state = get_world_2d().direct_space_state
	var perameters = PhysicsPointQueryParameters2D.new()
	perameters.position = get_global_mouse_position()
	perameters.collide_with_areas = true
	perameters.collision_mask = COLLISION_MASK_SLOT
	var result = space_state.intersect_point(perameters)

	if result.size() > 0:
		return result[0].collider.get_parent()
	return null


# Connects the signals from the Area2D in the cards, so that they can be used in this script
func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off)
