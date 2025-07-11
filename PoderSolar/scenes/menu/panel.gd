extends Panel
@onready var energy_slider: HSlider = $MarginContainer/HBoxContainer/VBoxContainer/EnergyHB/EnergySlider
@onready var pollution_slider: HSlider = $MarginContainer/HBoxContainer/VBoxContainer/PollutionHB/PollutionSlider
@onready var label: Label = $MarginContainer/HBoxContainer/VBoxContainer/MoneyHB/Label
@onready var buy_tree: Button = $MarginContainer/HBoxContainer/BuyTree
@onready var buy_coal: Button = $MarginContainer/HBoxContainer/BuyCoal
@onready var buy_areo: Button = $MarginContainer/HBoxContainer/BuyAreo
@onready var pollution_value: Label = $MarginContainer/HBoxContainer/VBoxContainer/PollutionHB/PollutionValue
@onready var energy_value: Label = $MarginContainer/HBoxContainer/VBoxContainer/EnergyHB/EnergyValue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PSGamemanager.money_change.connect(on_money_change)
	PSGamemanager.energy_change.connect(on_energy_change)
	PSGamemanager.pollution_change.connect(on_pollution_change)
	on_money_change()
	on_energy_change()
	on_pollution_change()
	
func on_money_change() -> void:
	label.text = str(PSGamemanager.money)
	
func on_energy_change() -> void:
	energy_slider.value = PSGamemanager.energy
	energy_value.text = str(PSGamemanager.energy)
func on_pollution_change() -> void:
	pollution_slider.value = PSGamemanager.pollution
	pollution_value.text = str(PSGamemanager.pollution)
