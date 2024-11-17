extends Node
#most of this is pretty self explanatory. if you can't figure it out, you got this i believe in you
#note - the rpc_id 1 is the host of the server

func _on_join_button_down() -> void:
	MultiplayerManager.becomeJoin()
	print("become join button pressed")

#when the ip textbox is changed
func _on_text_edit_text_changed() -> void:
	#okay it looks intimidating but "get_tree().root.get_node("Node2D/ipInput")" is the only freaking way it'll work
	MultiplayerManager.serverIP = get_tree().root.get_node("Node2D/multiplayerManager/misc/ipInput").text

#on draw card button pressed
func _on_button_3_pressed() -> void:
	print("drawded card")
	MultiplayerManager.drawCard.rpc_id(1)

#on reset deck button
func _on_button_4_pressed() -> void:
	print("reset deck")
	MultiplayerManager.regenDeck.rpc_id(1)
