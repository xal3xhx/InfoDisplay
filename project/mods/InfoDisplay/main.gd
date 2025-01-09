extends Node

# Preload the UI scene
const menu := preload("res://mods/InfoDisplay/UI.tscn")
var cash_lerp = 0
var addpanel
var ui_instance  # Store a reference to the UI instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().connect("node_added", self, "check_node")
	get_tree().connect("node_removed", self, "on_node_removed")  # Connect to node removal signal

func check_node(node: Node) -> void:
	if node.name == "playerhud":
		ui_instance = node
		var button := menu.instance()
		if ui_instance.has_node("main"):
			ui_instance.get_node("main").add_child(button)

func on_node_removed(node: Node) -> void:
	if node == ui_instance:  # Check if the removed node is the UI instance
		ui_instance = null  # Reset the reference to prevent errors

func _process(delta):
	if ui_instance and ui_instance.has_node("main") and ui_instance.get_node("main").visible:
		update_money()
		update_fish()

func update_money():
	if ui_instance and ui_instance.has_node("main"):
		cash_lerp = lerp(cash_lerp, PlayerData.money, 0.2)
		var rounded_cash = round(cash_lerp)
		var margin_container = ui_instance.get_node("main").get_node("MarginContainer")
		if margin_container:
			margin_container._updateCash("$" + str(rounded_cash))

func update_fish():
	if ui_instance and ui_instance.has_node("main"):
		var valid_items = []
		var total_cost = 0
		
		for item in PlayerData.inventory:
			var file = Globals.item_data[item["id"]]["file"]
			if file.unselectable or not file.can_be_sold or PlayerData.locked_refs.has(item["ref"]):
				continue
			
			valid_items.append(item["ref"])

		var margin_container = ui_instance.get_node("main").get_node("MarginContainer")
		if margin_container:
			margin_container._updateFish(" " + str(valid_items.size()))
