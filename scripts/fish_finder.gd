extends Node

var fishDataFile = "res://scripts/fish_data.json"
var json_as_text = FileAccess.get_file_as_string(fishDataFile)
var fish_dict = JSON.parse_string(json_as_text)
#if json_as_dict:
	#print(json_as_dict)

@export var devsprite1 = Texture2D
@export var devsprite2 = Texture2D

var foundFishes = []
# Number starts with 0
# df = Dev Fish btw
var df0
@export var df0_data = []
var df1

var fishValueHeight_randomizer = [0.7,1.3]

enum FishTypes{
	COMMON,
	UNCOMMON,
	RARE,
	UNUSUAL,
	LEGENDARY,
	DEVELOPPER
}

func init_fishes():
	pass


func _ready() -> void:
	#init_fishes()
	#get_fish_from_dict("devfish1")
	#pick_random_fish(fish_dict)
	#pick_random_array(get_fishes_by_biome("RIVER"))
	return

func add_to_inventory():
	pass

func get_fishes_by_biome(biome : String):
	foundFishes = []
	for item in fish_dict:
		if fish_dict[item]["fish_locations"].has(biome):
			foundFishes.append(fish_dict[item])
	return foundFishes

func get_fish_from_dict(fishName : String):
	#print(fish_dict[fishName]["value"])
## code to get all data of all items in the dict
	#for items in fish_dict:
		#print(items, fish_dict[items]) 
		#for part_func in fish_dict[items]:
			#print(fish_dict[items][part_func])
	return

func pick_random_dict(dictionary: Dictionary) -> Variant:
	var random_key = dictionary.keys().pick_random()
	#print(random_key)
	return dictionary[random_key]

func pick_random_array(array : Array) -> Variant:
	var randomItem = array[randi() % array.size()] 
	#print(randomItem)
	return randomItem

signal createdFishList
