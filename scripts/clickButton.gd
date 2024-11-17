extends Button
#when the button is pressed, do some stuff... about all there is to say about this script

#create the singular var
var clicks = 0


func _on_pressed() -> void:
	clicks += 1
	
	set_text(str(clicks))
	
	MultiplayerManager.sendAndSync.rpc_id(1, clicks)
