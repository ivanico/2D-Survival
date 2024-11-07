extends CanvasLayer

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer

func _ready():
	get_tree().paused = true

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade) #the function from ability_upgrade_card
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade)) #here we have selected in ability_upg_card as signal and we call it here
																		  #and when it's emited we bind the upgrade that we clicked on so we get the values (name and description)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
