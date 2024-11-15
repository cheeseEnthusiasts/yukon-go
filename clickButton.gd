extends Button


var clicks = 0

func _on_pressed() -> void:
	clicks += 1
	print("bnalls")
	set_text(str(clicks))
	MultiplayerManager.sendAndSync.rpc_id(1, clicks)
