extends Node

var fishDataFile = "res://scripts/fish_data.json"
var json_as_text = FileAccess.get_file_as_string(fishDataFile)
var fish_dict = JSON.parse_string(json_as_text)
#if json_as_dict:
	#print(json_as_dict)



@export var devsprite1 = Texture
@export var devsprite2 = Texture
@export var devsprite3 = Texture
@export var devsprite4 = Texture

var foundFishes = []
var sortedfishes = []
# Number starts with 0
# df = Dev Fish btw

var fishValueHeight_rng = RandomNumberGenerator.new()
var fishValueHeight_randomizer = [0.9,1.2]

var rarities_weights_DEFAULT = PackedFloat32Array([100, 15, 7, 3, 1])
var rarities_rng = RandomNumberGenerator.new()
var rarities_array = ["COMMON", "UNCOMMON", "RARE", "UNUSUAL", "LEGENDARY"]
var rarities_weights = rarities_weights_DEFAULT


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

#get a random fish : by which biome do we sort ? Do we get a random rarity ?  If not which rarit would you like ?
#TODO : add a sorting by BAIT VALUE to lock fisheds behind bait/rods
func get_fishes_by_sorting(biome : String, rng_rarity : bool = true, defined_rarity : String = "null",):
	foundFishes = []
	var willSortByRarity : bool = true
	var willSortByRNGRarity : bool = true
	var rng_selected_rarity : String
	if rng_rarity == false:
		if defined_rarity == "null":
			print("No random rarity sorting.")
			willSortByRarity = false
		willSortByRNGRarity = false
	elif rng_rarity == true :
			match rarities_array[rarities_rng.rand_weighted(rarities_weights)] :
				"COMMON":
					rng_selected_rarity = "COMMON"
				"UNCOMMON":
					rng_selected_rarity = "UNCOMMON"
				"RARE":
					rng_selected_rarity= "RARE"
				"UNUSUAL":
					rng_selected_rarity = "UNUSUAL"
				"LEGENDARY":
					rng_selected_rarity = "LEGENDARY"
	match [willSortByRarity, willSortByRNGRarity]:
#		will sort by rng rarity
		[true, true]:
			for item in fish_dict:
				if fish_dict[item]["fish_locations"].has(biome) and fish_dict[item]["fishType"] == rng_selected_rarity :
					foundFishes.append(fish_dict[item])
			return foundFishes
#		will sort by rarity but a defined one
		[true, false]:
			for item in fish_dict:
				if fish_dict[item]["fish_locations"].has(biome) and fish_dict[item]["fishType"] == defined_rarity :
					foundFishes.append(fish_dict[item])
			return foundFishes
#		will not sort by rarity
		[false, true or false] :
			for item in fish_dict:
				if fish_dict[item]["fish_locations"].has(biome) :
					foundFishes.append(fish_dict[item])
			return foundFishes


func pick_random_dict(dictionary: Dictionary) -> Variant:
	var random_key = dictionary.keys().pick_random()
	#print(random_key)
	return dictionary[random_key]

func get_fishes_by_rarity(array : Array) -> Variant:
	var filter
	match rarities_array[rarities_rng.rand_weighted(rarities_weights)] :
		"COMMON":
			filter = "COMMON"
		"UNCOMMON":
			filter = "UNCOMMON"
		"RARE":
			filter = "RARE"
		"UNUSUAL":
			filter = "UNUSUAL"
		"LEGENDARY":
			filter = "LEGENDARY"
	for item in array:
		if array[item].has(filter):
			sortedfishes.append(array[item])
	#var randomItem = sortedfishes[randi() % sortedfishes.size()] 
	#print(randomItem)
	return sortedfishes


func pick_random_array(array : Array) -> Variant:
	var randomItem = array[randi() % array.size()] 
	randomItem["value"] = snappedf(randomItem["value"] * fishValueHeight_rng.randf_range(fishValueHeight_randomizer[0], fishValueHeight_randomizer[1]), 0.01)
	randomItem["weight"] = snappedf(randomItem["weight"] * fishValueHeight_rng.randf_range(fishValueHeight_randomizer[0], fishValueHeight_randomizer[1]), 0.01)
	return randomItem


func rarities_weights_reset():
	rarities_weights = rarities_weights_DEFAULT

signal createdFishList
