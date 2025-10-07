class_name Player
extends CharacterBody3D

var QueuedFish = []

@export var cast_audio : AudioStreamWAV
@export var detect_audio : AudioStreamWAV

@onready var sub_viewport: SubViewport = $CamPivot/CamLocation/BaseCamera/SubViewportContainer/SubViewport
@onready var cam_pivot: Node3D = $CamPivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#region Fish Caught labels
@onready var fc_panel: PanelContainer = $CanvasLayer/FishingHud/FCPanel
@onready var caughtfish_name: Label = $CanvasLayer/FishingHud/FCPanel/FCVbox/FCMain/MarginContainer/VBoxContainer/caughtfish_name
@onready var caughtfish_sprite: TextureRect = $CanvasLayer/FishingHud/FCPanel/FCVbox/FCMain/MarginContainer/VBoxContainer/caughtfish_sprite
@onready var caughtfish_value: Label = $CanvasLayer/FishingHud/FCPanel/FCVbox/FCMain/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/caughtfish_value
@onready var caughtfish_weight: Label = $CanvasLayer/FishingHud/FCPanel/FCVbox/FCMain/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/caughtfish_weight
@onready var caughtfish_rarity: Label = $CanvasLayer/FishingHud/FCPanel/FCVbox/FCMain/MarginContainer/VBoxContainer/caughtfish_rarity
#endregion

#region Debug labels
@onready var debug_queue_panel: Panel = $CanvasLayer/FishingHud/DebugQueuePanel
@onready var queuedfish_name: Label = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_name
@onready var queuedfish_sprite: TextureRect = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/MarginContainer/Panel/queuedfish_sprite
@onready var queuedfish_weight: Label = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_weight
@onready var queuedfish_value: Label = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_value
@onready var queuedfish_rarity: Label = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_rarity
#endregion

#region buttons
@onready var player_interact: Button = $CanvasLayer/FishingHud/PlayerInteract/PlayerInteract
#endregion

#region Menu Buttons
@onready var btn_shop: Button = $CanvasLayer/FishingHud/ButtonsMarginContainer/GridContainer/btn_shop
@onready var btn_fishlist: Button = $CanvasLayer/FishingHud/ButtonsMarginContainer/GridContainer/btn_fishlist
@onready var menu_button: Button = $CanvasLayer/FishingHud/ButtonsMarginContainer/MenuButton

#endregion

#region timers for fishing logic
@onready var fish_lurk_timer: Timer = $FishLurkTimer
@onready var fish_lurk_timer_preventive: Timer = $FishLurkTimerPreventive
@onready var fish_catch_timer: Timer = $FishCatchTimer
#endregion

#region sprites
@onready var sprite_surprise: Sprite3D = $Sprites/SurpriseSprite
@onready var sprite_saddened: Sprite3D = $Sprites/SaddenedSprite
#endregion


#region Money & Rod+Bait durability
@onready var money_count: Label = $CanvasLayer/FishingHud/VBoxContainer/MoneyCount

@onready var rod_durability: Label = $"CanvasLayer/FishingHud/ButtonsMarginContainer/Bait&RodCorner/Bait&RodData/RodDurabilityCounter/RodDurability"
@onready var rod_durability_max: Label = $"CanvasLayer/FishingHud/ButtonsMarginContainer/Bait&RodCorner/Bait&RodData/RodDurabilityCounter/RodDurabilityMax"
@onready var rod_durability_bar: ProgressBar = $"CanvasLayer/FishingHud/ButtonsMarginContainer/Bait&RodCorner/Bait&RodData/RodDurabilityBar"

@onready var bait_and_rod_btn: Button = $"CanvasLayer/FishingHud/ButtonsMarginContainer/Bait&RodCorner/Bait&RodData/BaitAndRodBtn"
@onready var bait_rod_menu: PanelContainer = $"CanvasLayer/FishingHud/ButtonsMarginContainer/Bait&RodCorner/BaitRodMenu"
@onready var repair_rod_btn: Button = $"CanvasLayer/FishingHud/ButtonsMarginContainer/Bait&RodCorner/BaitRodMenu/Margins/VBox/RepairRodBtn"
@onready var repair_cost: Label = $"CanvasLayer/FishingHud/ButtonsMarginContainer/Bait&RodCorner/BaitRodMenu/Margins/VBox/PanelContainer/RepairCost"

#endregion


@onready var state_machine: StateMachine = $StateMachine

@onready var fishing_hud: Control = $CanvasLayer/FishingHud

func resize():
	if sub_viewport != null:
		sub_viewport.size = DisplayServer.window_get_size()

func _ready() -> void:
	update_money()
	update_roddurability()
	if Playerinfo.debug_mode == true :
		debug_queue_panel.visible = true
	debug_change_data("none", "", "", "")
	resize()
	match Playerinfo.playerLocation:
		"DEVMAP":
			pass
		"RIVER":
			pass

func _process(delta: float) -> void:
	resize()
	repair_cost.text = str(Playerinfo.RepairCost)
	if Playerinfo.can_repair_rod == true:
		repair_rod_btn.disabled = false
	else:
		repair_rod_btn.disabled = true


#region HUD and UI element related Functions
func enable_ui_element(ui_element : Control):
	ui_element.visible = true
func disable_ui_element(ui_element : Control):
	ui_element.visible = false
	
func disable_all_menus():
	pass


func disable_button(button : Control):
	button.disabled = true
	button.visible = false
func enable_button(button : Control):
	button.disabled = false
	button.visible = true

#endregion

func enable_sprite(sprite : Sprite3D):
	sprite.visible = true
func disable_sprite(sprite : Sprite3D):
	sprite.visible = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass


func update_roddurability():
	rod_durability.text = str(Playerinfo.rod_durability)
	rod_durability_bar.value = (Playerinfo.rod_durability / Playerinfo.max_rod_durability) * 100
	rod_durability_max.text = "/ " + str(Playerinfo.max_rod_durability)

func update_money():
	money_count.text = str(Playerinfo.money)

func update_fish_caught_celebration_hud(newname : String, newweight: String,newvalue: String, newrarity : String, newsprite = 1):
	caughtfish_name.text = newname
	caughtfish_value.text = newvalue
	caughtfish_weight.text = newweight
	caughtfish_rarity.text = newrarity
	match newrarity:
		"COMMON":
			caughtfish_rarity.add_theme_color_override("font_color",Color(0.282, 0.604, 0.604, 1.0))
		"UNCOMMON":
			caughtfish_rarity.add_theme_color_override("font_color",Color.LIME_GREEN)
		"RARE":
			caughtfish_rarity.add_theme_color_override("font_color",Color.ROYAL_BLUE)
		"UNUSUAL":
			caughtfish_rarity.add_theme_color_override("font_color",Color.PURPLE)
		"LEGENDARY":
			caughtfish_rarity.add_theme_color_override("font_color",Color.ORANGE)
		_:
			caughtfish_rarity.add_theme_color_override("font_color",Color.WHITE)
			print("No correct rarity given in the queued fish.")
	
	switch_ui_fish_sprite(caughtfish_sprite, newsprite)

func debug_change_data(newname : String, newweight: String,newvalue: String, newrarity : String, newsprite = 1):
	queuedfish_name.text = newname
	queuedfish_weight.text = newweight
	queuedfish_value.text = newvalue
	queuedfish_rarity.text = newrarity
	switch_ui_fish_sprite(queuedfish_sprite, newsprite)


func switch_ui_fish_sprite(SpriteRect, spritenumber):
	match spritenumber:
		1.0:
			SpriteRect.texture = FishFinder.devsprite1
		2.0:
			SpriteRect.texture = FishFinder.devsprite2
		3.0:
			SpriteRect.texture = FishFinder.devsprite3
		4.0:
			SpriteRect.texture = FishFinder.devsprite4
		## FRESHWATER FISHES - COMMON
		111.0:
			SpriteRect.texture = FishFinder.spr_fresh_1_1
		112.0:
			SpriteRect.texture = FishFinder.spr_fresh_1_2
		113.0:
			SpriteRect.texture = FishFinder.spr_fresh_1_3
		114.0:
			SpriteRect.texture = FishFinder.spr_fresh_1_4
		115.0:
			SpriteRect.texture = FishFinder.spr_fresh_1_5
		## FRESHWATER FISHES - UNCOMMON
		121.0:
			SpriteRect.texture = FishFinder.spr_fresh_2_1
		122.0:
			SpriteRect.texture = FishFinder.spr_fresh_2_2
		123.0:
			SpriteRect.texture = FishFinder.spr_fresh_2_3
		## FRESHWATER FISHES - RARE
		131.0:
			SpriteRect.texture = FishFinder.spr_fresh_3_1
		132.0:
			SpriteRect.texture = FishFinder.spr_fresh_3_2
		## FRESHWATER FISHES - UNUSUAL
		141.0:
			SpriteRect.texture = FishFinder.spr_fresh_4_1
		142.0:
			SpriteRect.texture = FishFinder.spr_fresh_4_2
		## FRESHWATER FISHES - LEGENDARY
		151.0:
			SpriteRect.texture = FishFinder.spr_fresh_5_1

func _on_stop_fishing_pressed() -> void:
	pass # Replace with function body.


func _on_repair_rod_btn_pressed() -> void:
	Playerinfo.refill_rod_durability()
	update_roddurability()
	update_money()

#region Menu buttons pressed
func _on_btn_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://maps/shop_screen.tscn")

func _on_menu_button_pressed() -> void:
	#TODO : pause the game, hide all other menues and show the menu and its choices
	pass # Replace with function body.

#endregion
