extends Control

@onready var player: Player = $"../.."


@onready var player_interact: Button = $PlayerInteract/PlayerInteract

@onready var bait_rod_menu: PanelContainer = $"ButtonsMarginContainer/Bait&RodCorner/BaitRodMenu"


@onready var menu_button: Button = $ButtonsMarginContainer/MenuButton
@onready var menu_button_travel: Button = $ButtonsMarginContainer/GridContainer/MenuButtonTravel



#region Debug menu : Queue of the next fish

@onready var queuedfish_name: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_name
@onready var queuedfish_weight: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_weight
@onready var queuedfish_value: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_value
@onready var queuedfish_sprite: TextureRect = $DebugQueuePanel/MarginContainer/VBoxContainer/MarginContainer/Panel/queuedfish_sprite
@onready var queuedfish_rarity: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_rarity


#endregion



func _ready() -> void:
	pass

func disable_button(button):
	button.disabled = true
func enable_button(button):
	button.disabled = false
