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
#311
@export var spr_rods_common1 = Texture2D
#312
@export var spr_rods_common2 = Texture2D
#313
@export var spr_rods_common3 = Texture2D
#314
@export var spr_rods_common4 = Texture2D
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
		311:
			SpriteRect.texture = spr_rods_common1
		312:
			SpriteRect.texture = spr_rods_common2
		313:
			SpriteRect.texture = spr_rods_common3
		314:
			SpriteRect.texture = spr_rods_common4
		_:
			SpriteRect.texture = null


#region list of all fish sprites
## FRESHWATER FISHES - COMMON
#111
@export var spr_fresh_1_1 = Texture2D
#112
@export var spr_fresh_1_2 = Texture2D
#113
@export var spr_fresh_1_3 = Texture2D
#114
@export var spr_fresh_1_4 = Texture2D
#115
@export var spr_fresh_1_5 = Texture2D
## FRESHWATER FISHES - UNCOMMON
#121
@export var spr_fresh_2_1 = Texture2D
#122
@export var spr_fresh_2_2 = Texture2D
#123
@export var spr_fresh_2_3 = Texture2D
## FRESHWATER FISHES - RARE
#131
@export var spr_fresh_3_1 = Texture2D
#132
@export var spr_fresh_3_2 = Texture2D
## FRESHWATER FISHES - UNUSUAL
#141
@export var spr_fresh_4_1 = Texture2D
#142
@export var spr_fresh_4_2 = Texture2D
## FRESHWATER FISHES - LEGENDARY
#151
@export var spr_fresh_5_1 = Texture2D
#endregion

func give_fish_sprite(SpriteRect, spritenumber : float)->void :
	var spritenumberInt = int(spritenumber)
	match spritenumberInt:
		## FRESHWATER FISHES - COMMON
		111:
			SpriteRect.texture = spr_fresh_1_1
		112:
			SpriteRect.texture = spr_fresh_1_2
		113:
			SpriteRect.texture = spr_fresh_1_3
		114:
			SpriteRect.texture = spr_fresh_1_4
		115:
			SpriteRect.texture = spr_fresh_1_5
		## FRESHWATER FISHES - UNCOMMON
		121:
			SpriteRect.texture = spr_fresh_2_1
		122:
			SpriteRect.texture = spr_fresh_2_2
		123:
			SpriteRect.texture = spr_fresh_2_3
		## FRESHWATER FISHES - RARE
		131:
			SpriteRect.texture = spr_fresh_3_1
		132:
			SpriteRect.texture = spr_fresh_3_2
		## FRESHWATER FISHES - UNUSUAL
		141:
			SpriteRect.texture = spr_fresh_4_1
		142:
			SpriteRect.texture = spr_fresh_4_2
		## FRESHWATER FISHES - LEGENDARY
		151:
			SpriteRect.texture = spr_fresh_5_1
		## FRESHWATER FISHES - LEGENDARY
		_:
			SpriteRect.texture = null
