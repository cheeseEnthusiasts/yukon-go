extends Node

func _on_host_button_down() -> void:
	print("become host button pressed")
	MultiplayerManager.becomeHost()


func _on_join_button_down() -> void:
	print("become join button pressed")
	MultiplayerManager.becomeJoin()


func _on_text_edit_text_changed() -> void:
	MultiplayerManager.serverIP = get_tree().root.get_node("Node2D/TextEdit").text
