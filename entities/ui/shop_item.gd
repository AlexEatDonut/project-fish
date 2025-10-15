extends PanelContainer

signal item_buy_pressed(id)
signal item_hovered(id)

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/PanelContainer2/MarginContainer/TextureRect

@onready var item_name_label: Label = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ItemNameLabel
@onready var item_price_label: Label = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ItemPriceLabel

@onready var shop_item_btn: Button = $ShopItemBtn


var id : int

func setup(data: Dictionary, p_id : int) -> void:
	#texture_rect.texture = load(data.get("icon_path"))
	#texture_rect.texture = load(data.get("res://materials/ui/menu_buttons/bait-icon.svg"))
	item_name_label.text = data["item_name"]
	item_price_label.text = data["item_cost"]
	id = p_id

func get_category(data: Dictionary):
	return(data["category"])


func _on_shop_item_btn_pressed() -> void:
	emit_signal("item_buy_pressed", id)


func _on_shop_item_btn_mouse_entered() -> void:
	emit_signal("item_hovered", id)
