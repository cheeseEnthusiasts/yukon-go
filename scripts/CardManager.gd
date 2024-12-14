extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_SLOT = 2

var screen_size
var card_dragged
var is_hovering_on_card


func _ready() -> void:
	screen_size = get_viewport_rect().size


func _process(_delta: float) -> void:
	if card_dragged:
		var mouse_pos = get_global_mouse_position()
		card_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x), clamp(mouse_pos.y, 0, screen_size.y))

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check_for_card()
			if card:
				start_drag(card)
		else:
			if card_dragged:
				finish_drag()

	if event.is_action_pressed('ENTER'):
		var path = load("res://scenes/card.tscn")
		var c = path.instantiate()
		c.name = "Card"
		add_child(c)

func start_drag(card):
	card_dragged = card
	card.scale = Vector2(1, 1)

func finish_drag():
	card_dragged.scale = Vector2(1.05, 1.05)
	var spot = raycast_check_for_card_slot()
	if spot and not spot.card_in_slot:
		card_dragged.position = spot.position
		card_dragged.get_node("Area2D/CollisionShape2D").disabled = true
		spot.card_in_slot = true
	card_dragged = null

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

func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off)

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
	if hovered:
		card.scale = Vector2(1.05, 1.05)
		card.z_index = 2
	else:
		card.scale = Vector2(1, 1)
		card.z_index = 1
