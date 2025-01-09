#main.gd
extends Node

# Preload the UI scene
const menu := preload("res://mods/InfoDisplay/UI.tscn")
var cash_lerp = 0
var addpanel
var ui_instance  # Store a reference to the UI instance

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("node_added", self, "check_node")

func check_node(node: Node) -> void:
	if node.name == "main_menu":
		ui_instance = node
		var button := menu.instance()
		ui_instance.add_child(button)


func _process(delta):
	update_money()
	update_fish()

func update_money():
	if ui_instance:
		cash_lerp = lerp(cash_lerp, PlayerData.money, 0.2)
		var rounded_cash = round(cash_lerp)
		#ui_instance._updateCash("$" + str(rounded_cash))

func update_fish():
	if ui_instance:
		var valid_items = []
		var total_cost = 0
		
		for item in PlayerData.inventory:
			var file = Globals.item_data[item["id"]]["file"]
			if file.unselectable or not file.can_be_sold or PlayerData.locked_refs.has(item["ref"]): continue
			
			valid_items.append(item["ref"])

		#ui_instance._updateFish(" " + str(valid_items.size()))