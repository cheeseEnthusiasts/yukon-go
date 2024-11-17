extends Node

#create vars
var rng = RandomNumberGenerator.new()

const port = 8080
var serverIP = "35.161.170.19"

var clicks = 0

@onready var infoLabel = get_tree().root.get_node("Node2D/multiplayerManager/labels/informationLabel")
@onready var cardsLeftLabel = get_tree().root.get_node("Node2D/multiplayerManager/labels/deckCardsLabel")
@onready var cardButtonLabel = get_tree().root.get_node("Node2D/multiplayerManager/buttons/cardButton")
@onready var clickButtonLabel = get_tree().root.get_node("Node2D/multiplayerManager/buttons/mainButton")


#functions

#sets up a client
func becomeJoin():
	var clientPeer = ENetMultiplayerPeer.new()
	
	clientPeer.create_client(serverIP, port)
	
	multiplayer.multiplayer_peer = clientPeer
	
	infoLabel.set_text("if you're seeing this something went wrong, make sure the ip address has no spaces or anything")
	
	print("joining")



#rpc functions

#syncs clicks (data) with the server when this is recieved
@rpc("any_peer", "call_remote", "reliable")
func sync(data, cards):
	print("client recieved data " + str(data))
	print(str(cards) + "cards left in deck")
	
	#you'll typically only disconnect forcefully if you are a DIRTY CHEATER
	if(str(data) == "disconnect"):
		infoLabel.set_text("you were disconnected")
	else:
		infoLabel.set_text("you recieved data " + str(data))
		clickButtonLabel.set_text(str(data))
		cardsLeftLabel.set_text("cards in deck: " + str(cards))
		
		clickButtonLabel.clicks = data

#allows the client to recieve the card data from the server
@rpc("any_peer", "call_remote", "reliable")
func getCard(card):
	#currently, if the deck is empty, the server will send "error"
	if(card == "error"):
		infoLabel.set_text("there was an error drawing a card, the deck is likely empty")
	else:
		cardButtonLabel.set_text(card)




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
