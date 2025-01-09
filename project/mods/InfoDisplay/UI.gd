#UI.gd
extends MarginContainer

#onready var InfoDisplay := $"/root/InfoDisplay"

func _ready():
	print("display Ready")

# Method to update the money display
func _updateCash(money: String):
	$Panel/MoneyText/Money.bbcode_text = money

# Method to update the fish display
func _updateFish(fish: String):
	$Panel/FishText/Fish.bbcode_text = fish
