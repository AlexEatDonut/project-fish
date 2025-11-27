extends Node

var rodsDataFile = "res://scripts/rods_data.json"
var rods_json_as_text = FileAccess.get_file_as_string(rodsDataFile)
var fishing_rods = JSON.parse_string(rods_json_as_text)

var shopItemsDataFile = "res://scripts/items_data.json"
var shopitems_json_as_text = FileAccess.get_file_as_string(shopItemsDataFile)
var shop_items = JSON.parse_string(shopitems_json_as_text)

var fishDataFile = "res://scripts/fish_data.json"
var fishes_json_as_text = FileAccess.get_file_as_string(fishDataFile)
var fish_dict = JSON.parse_string(fishes_json_as_text)

#region list of all icons used in shop
#Placeholder Before any items are hovered
@export var spr_default = Texture2D
#110
@export var spr_bait_generic = Texture2D
#111
@export var spr_bait_rare = Texture2D
#112
@export var spr_bait_unusual = Texture2D
#113
@export var spr_bait_legendary = Texture2D
#210
@export var spr_ticket_generic = Texture2D
#211
@export var spr_ticket_lakeside = Texture2D
#212
@export var spr_ticket_port = Texture2D

#310
@export var spr_rods_generic = Texture2D

#endregion

func give_item_icon(SpriteRect, spritenumber)->void :
	match spritenumber:
		## BAITS
		110:
			SpriteRect.texture = spr_bait_generic
		111:
			SpriteRect.texture = spr_bait_rare
		112:
			SpriteRect.texture = spr_bait_unusual
		113:
			SpriteRect.texture = spr_bait_legendary
		
		## TICKETS 
		210:
			SpriteRect.texture = spr_ticket_generic
		211:
			SpriteRect.texture = spr_ticket_lakeside
		212:
			SpriteRect.texture = spr_ticket_port
		##Rods
		310:
			SpriteRect.texture = spr_rods_generic
		_:
			SpriteRect.texture = null
