extends Node

const port = 8080
var serverIP = "127.0.0.1"

var deck = newDeck()

var rng = RandomNumberGenerator.new()
var clicks = 0

func becomeHost():
	print("hosting")
	var serverPeer = ENetMultiplayerPeer.new()
	serverPeer.create_server(port)
	
	multiplayer.multiplayer_peer = serverPeer
	
	multiplayer.peer_connected.connect(_add_player)
	multiplayer.peer_disconnected.connect(_del_player)


func becomeJoin():
	print("joining")
	var clientPeer = ENetMultiplayerPeer.new()
	clientPeer.create_client(serverIP, port)
	
	multiplayer.multiplayer_peer = clientPeer
	
	var labal = get_tree().root.get_node("Node2D/Label")
	labal.set_text("joined server probably")
	

@rpc("any_peer", "call_local", "reliable")
func sendAndSync(data):
	print("server got signal")
	print("server recieved data " + str(data))
	sync.rpc(data)

@rpc("any_peer", "call_local", "reliable")
func sync(data):
	var button = get_tree().root.get_node("Node2D/Node/Button3")
	print("client recieved data " + str(data))
	var labal = get_tree().root.get_node("Node2D/Label")
	
	if(str(data) == "disconnect"):
		labal.set_text("you were disconnected")
	else:
		labal.set_text("you recieved data " + str(data))
		button.set_text(str(data))
		button.clicks = data

@rpc("any_peer", "call_remote", "reliable")
func drawCard():
	pass

@rpc("any_peer", "call_remote", "reliable")
func getCard(card):
	var labal = get_tree().root.get_node("Node2D/Button3")
	if(card == "error"):
		labal = get_tree().root.get_node("Node2D/Label")
		labal.set_text("there was an error drawing a card, the deck is likely empty")
	else:
		labal.set_text(card)

func _add_player(id: int):
	var labal = get_tree().root.get_node("Node2D/Label")
	labal.set_text("player " + str(id) + " joined")
	print("add player %s" % id)

func _del_player(id: int):
	var labal = get_tree().root.get_node("Node2D/Label")
	labal.set_text("player " + str(id) + " left")
	print("add player %s" % id)

@rpc("any_peer", "call_remote", "reliable")
func regenDeck():
	pass

func newDeck():
	var tempDeck = []
	var r = 1
	var s = 1
	while r <= 4:
		while s <= 13:
			tempDeck.append("suit " + str(s) + " of rank " + str(r))
			s += 1
		s = 1
		r += 1
	return tempDeck
