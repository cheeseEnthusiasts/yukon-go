extends Node

# This script can contain functions and variables that can be accessed in any other script.
# To do that, you define it here and then in the other scripts you do Global.[thing]
# you can pretty much put anything here that might be useful in other scripts


# quits the game
func _input(event):
	if event.is_action_pressed('EXIT'):
		get_tree().quit()
