extends PanelContainer

signal log_item_pressed(id:String)
signal log_item_hovered(id:String)


@onready var item_icon: TextureRect = $MaxSizeContainer/PanelContainer/MarginContainer/TextureRect

@onready var log_item_btn: Button = $LogItemBtn

@onready var greyed_out: Panel = $GreyedOut

var item_type : String

var item_name : String
var item_desc : String

var item_sprite : Texture2D

var rod_strength_desc : String
var rod_weakness_desc : String
var rod_durability : int
var rod_repaircost : int
var rod_repair_mult : int
var rod_luktime_mult : float
var rod_catchwin_mult : float


var item_id : int

var is_rod : bool = false


var id : int

func setup(data: String, p_id : int) -> void:
	item_type = Gamedata.shop_items[data]["category"]
	item_id = int(Gamedata.shop_items[data]["item_id"])
	if Gamedata.shop_items[data]["category"] == "rod":
		setup_rod(data, p_id)
		return
	else:
		#item_icon.texture = load(data.get("icon_path"))
		#item_icon.texture = load(data.get("res://materials/ui/menu_buttons/bait-icon.svg"))
		item_name = Gamedata.shop_items[data]["item_name"]
		item_desc = Gamedata.shop_items[data]["item_description"]
		id = p_id

#func _process(delta: float) -> void:
	#pass

func setup_rod(data: String, p_id : int)-> void:
	is_rod = true
	
	id = p_id


func get_category(data: String):
	return (Gamedata.shop_items[data]["category"])

func get_icon_id(data: String):
	return int(Gamedata.shop_items[data]["icon_id"])
	

func _on_log_item_btn_pressed() -> void:
	emit_signal("log_item_pressed", str(item_id))


func _on_log_item_btn_mouse_entered() -> void:
	greyed_out.visible = true
	emit_signal("log_item_hovered", str(item_id))


func _on_log_item_btn_mouse_exited() -> void:
	greyed_out.visible = false
