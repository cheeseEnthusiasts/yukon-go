extends Node2D

var health = 100
var energy = 50


func _process(_delta):
	get_node('Health').value = health
	get_node("Energy").value = energy


func construct_card(cost, dmg, qp: bool):
	var path = load("res://scenes/card.tscn")
	var c = path.instantiate()
	var hand = $'../Hand'
	var card_manager = $'../CardManager'
	card_manager.add_child(c)
	c.position = Vector2(get_viewport().size.x / 2, 1080)
	c.name = "Card"
	hand.add_card(c)
	

	c.cost = cost
	c.dmg = dmg
	c.quickplay = qp
	return c