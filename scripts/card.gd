extends Node2D

signal hovered
signal hovered_off

var in_slot

# Card information
var cost # energy cost to play card
var dmg # ammount of damage it will do
var quickplay # determines if it is a QuickPlay card or not
# i can't think of others right now


func _ready():
	get_parent().connect_card_signals(self)


func _on_area_2d_mouse_entered() -> void:
	hovered.emit(self)

func _on_area_2d_mouse_exited() -> void:
	hovered_off.emit(self)
