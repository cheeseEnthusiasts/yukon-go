extends Node

#create vars

const port = 8080
var serverIP = "127.0.0.1"

@onready var card_manager = $'/root/Game/CardManager'
@onready var opponent_slots = $'/root/Game/OpponentSlots'
@onready var player = $'/root/Game/Player'
@onready var hand = $'/root/Game/Hand'
var slots = {}
var client_id

#functions

func _ready():
	for child in opponent_slots.get_children():
		var id = child.id
		slots.get_or_add(id, child)

#sets up a client
func join():
	var clientPeer = ENetMultiplayerPeer.new()
	clientPeer.create_client(serverIP, port)
	multiplayer.multiplayer_peer = clientPeer
	client_id = clientPeer.get_unique_id()
		


#rpc functions

#syncs clicks (data) with the server when this is recieved
@rpc("any_peer", "call_remote", "reliable")
func refresh_cards(id, card, spot):
	if id != client_id:
		print("client recieved data " + str(card, spot))
		var new_card = player.construct_card(card[0], card[1], false)
		card_manager.place_card_in_opponent_spot(slots[spot], new_card)
		print("done")

	




#unused rpc funtions
#these are functions that the server uses, but the client doesn't
#if i don't have these, godot will yell at me and i don't like it
@rpc("any_peer", "call_remote", "reliable")
func update_cards(_data):
	pass
