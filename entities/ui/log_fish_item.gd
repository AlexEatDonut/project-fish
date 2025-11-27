extends PanelContainer

signal log_fish_pressed(id)
signal log_fish_hovered(id)


@onready var item_icon: TextureRect = $MaxSizeContainer/PanelContainer/MarginContainer/TextureRect

@onready var log_fish_btn: Button = $LogFishBtn


@onready var greyed_out: Panel = $GreyedOut

var item_type : String = "Fish"

var item_name : String
var item_desc : String

var item_sprite : Texture2D

var item_id : String


var fish_weight : float
var fish_value : float
var fish_environement : String
var fish_rarity : String




var id : int

func setup(data: String, p_id : int) -> void:
	#item_icon.texture = load(data.get("icon_path"))
	#item_icon.texture = load(data.get("res://materials/ui/menu_buttons/bait-icon.svg"))
	item_name = Gamedata.fish_dict[data]["name"]
	item_desc = Gamedata.fish_dict[data]["description"]
	item_id = data
	id = p_id

#func _process(delta: float) -> void:
	#pass


func get_category(data: String):
	return (Gamedata.fish_dict[data]["fish_env"])

func get_icon_id(data: String):
	return int(Gamedata.fish_dict[data]["sprite"])
	

func _on_log_fish_btn_pressed() -> void:
	emit_signal("log_fish_pressed", item_id)

func _on_log_fish_btn_mouse_entered() -> void:
	greyed_out.visible = true
	emit_signal("log_fish_hovered", item_id)

func _on_log_fish_btn_mouse_exited() -> void:
	greyed_out.visible = false
