extends Node

func _on_host_button_down() -> void:
	print("become host button pressed")
	MultiplayerManager.becomeHost()


func _on_join_button_down() -> void:
	print("become join button pressed")
	MultiplayerManager.becomeJoin()
