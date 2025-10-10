extends Button

signal item_buy_pressed(id)

@onready var texture: TextureRect = $PanelContainer2/MarginContainer/TextureRect

@onready var item_name_label: Label = $PanelContainer/MarginContainer/VBoxContainer/ItemNameLabel
@onready var item_price_label: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ItemPriceLabel

@onready var shop_item_btn: Button = $"."

var id : int

func setup(data: Dictionary, p_id : int) -> void:
	texture.texture = load(data.get("icon_path"))
	item_name_label.text = data.get("item_name")
	item_price_label.text = data.get("item_cost")
	id = p_id

func get_category(data: Dictionary)->void:
	return(data.get("category"))

func _on_pressed() -> void:
	emit_signal("item_buy_pressed", id)
