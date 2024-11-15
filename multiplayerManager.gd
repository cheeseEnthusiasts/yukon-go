extends Node

const port = 8080
const serverIP = "127.0.0.1"

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

@rpc("any_peer", "call_local", "reliable")
func sendAndSync(data):
	print("server got signal")
	print("server recieved data " + str(data))
	sync.rpc(data)

@rpc("any_peer", "call_local", "reliable")
func sync(data):
	var button = get_tree().root.get_node("Node2D/Node/Button3")
	print("client recieved data " + str(data))
	button.set_text(str(data))
	button.clicks = data

func _add_player(id: int):
	print("add player %s" % id)

func _del_player(id: int):
	print("%s player left" % id)
