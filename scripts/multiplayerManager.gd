extends Node

#create vars
var rng = RandomNumberGenerator.new()

const port = 8080
var serverIP = "35.161.170.19"

var clicks = 0




#functions

#sets up a client
func becomeJoin():
	var clientPeer = ENetMultiplayerPeer.new()
	var labal = get_tree().root.get_node("Node2D/informationLabel")
	
	clientPeer.create_client(serverIP, port)
	
	multiplayer.multiplayer_peer = clientPeer
	
	labal.set_text("if you're seeing this something went wrong, make sure the ip address has no spaces or anything")
	
	print("joining")

#function that gets called when you are hosting and a player joins
func _add_player(id: int):
	var labal = get_tree().root.get_node("Node2D/informationLabel")
	
	labal.set_text("player " + str(id) + " joined")
	
	print("add player %s" % id)

#function that gets called when you are hosting and a player leaves
func _del_player(id: int):
	var labal = get_tree().root.get_node("Node2D/informationLabel")
	
	labal.set_text("player " + str(id) + " left")
	
	print("add player %s" % id)




#rpc functions

#syncs clicks (data) with the server when this is recieved
@rpc("any_peer", "call_remote", "reliable")
func sync(data):
	var button = get_tree().root.get_node("Node2D/mainButton")
	var labal = get_tree().root.get_node("Node2D/informationLabel")
	
	print("client recieved data " + str(data))
	
	#you'll typically only disconnect forcefully if you are a DIRTY CHEATER
	if(str(data) == "disconnect"):
		labal.set_text("you were disconnected")
	else:
		labal.set_text("you recieved data " + str(data))
		button.set_text(str(data))
		
		button.clicks = data

#allows the client to recieve the card data from the server
@rpc("any_peer", "call_remote", "reliable")
func getCard(card):
	var labal = get_tree().root.get_node("Node2D/cardButton")
	
	#currently, if the deck is empty, the server will send "error"
	if(card == "error"):
		labal = get_tree().root.get_node("Node2D/informationLabel")
		labal.set_text("there was an error drawing a card, the deck is likely empty")
	else:
		labal.set_text(card)




#unused rpc funtions
#these are functions that the server uses, but the client doesn't
#if i don't have these, godot will yell at me and i don't like it

@rpc("any_peer", "call_remote", "reliable")
func regenDeck():
	pass

@rpc("any_peer", "call_remote", "reliable")
func drawCard():
	pass

@rpc("any_peer", "call_local", "reliable")
func sendAndSync(_data):
	pass
