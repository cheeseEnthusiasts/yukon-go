extends Node2D

signal hovered
signal hovered_off

var in_slot


func _ready():
	get_parent().connect_card_signals(self)


func _on_area_2d_mouse_entered() -> void:
	hovered.emit(self)

func _on_area_2d_mouse_exited() -> void:
	hovered_off.emit(self)
