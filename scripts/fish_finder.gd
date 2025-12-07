extends Node


var foundFishes = []
var sortedfishes = []

# Number starts with 0
# df = Dev Fish btw

var no_fishes_error_message : Dictionary = {"ERROR" : "The array has for some reason not been made. Trying again."}

var fishValueHeight_rng = RandomNumberGenerator.new()
var fishValueHeight_randomizer = [0.9,1.2]

var rarities_weights_FINAL = PackedFloat32Array([100, 18, 9, 4, 1])
# List of each weights by bait (0 is default no upgrade)
var rarities_weights_bait0 = PackedFloat32Array([85, 15, 0, 0, 0])
var rarities_weights_bait1 = PackedFloat32Array([90, 16, 7, 0, 0])
var rarities_weights_bait2 = PackedFloat32Array([95, 17, 8, 3, 0])
#DEV WEIGHTS
#var rarities_weights_FINAL = PackedFloat32Array([1, 1, 1, 1, 1])
var rarities_rng = RandomNumberGenerator.new()
var rarities_array = ["COMMON", "UNCOMMON", "RARE", "UNUSUAL", "LEGENDARY"]
var rarities_weights = rarities_weights_bait0


enum fish_types{
	COMMON,
	UNCOMMON,
	RARE,
	UNUSUAL,
	LEGENDARY,
	DEVELOPPER
}


func _ready() -> void:
	#get_fish_from_dict("devfish1")
	#pick_random_fish(fish_dict)
	#pick_random_array(get_fishes_by_biome("RIVER"))
	return

func update_fishweights():
	match Playerinfo.rod_bait_value:
		1:
			rarities_weights = rarities_weights_bait1
		2:
			rarities_weights = rarities_weights_bait2
		3:
			rarities_weights = rarities_weights_FINAL

#get a random fish : by which biome do we sort ? Do we get a random rarity ?  If not which rarit would you like ?
#TODO : add a sorting by BAIT VALUE to lock fisheds behind bait/rods
func get_fishes_by_sorting(biome : String, rng_rarity : bool = true, defined_rarity : String = "null",):
	var current_bait_value : int = Playerinfo.rod_bait_value
	print(Playerinfo.rod_bait_value)
	print(rarities_weights)
	#print(current_bait_value)
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
			for item in Gamedata.fish_dict:
				if Gamedata.fish_dict[item]["fish_locations"].has(biome) and Gamedata.fish_dict[item]["fish_type"] == rng_selected_rarity and Gamedata.fish_dict[item]["bait_value"] <= current_bait_value:
					foundFishes.append(Gamedata.fish_dict[item])
			return foundFishes
#		will sort by rarity, but a defined one
		[true, false]:
			for item in Gamedata.fish_dict:
				if Gamedata.fish_dict[item]["fish_locations"].has(biome) and Gamedata.fish_dict[item]["fish_type"] == defined_rarity and Gamedata.fish_dict[item]["bait_value"] <= current_bait_value :
					foundFishes.append(Gamedata.fish_dict[item])
			return foundFishes
#		will not sort by rarity, doesn't matter if it is random or not
		[false, true or false] :
			for item in Gamedata.fish_dict:
				if Gamedata.fish_dict[item]["fish_locations"].has(biome) :
					foundFishes.append(Gamedata.fish_dict[item])
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
	if array.size() == 0:
		return no_fishes_error_message
	#var randomItem = array[randi() % array.size()] 
	var randomItem = array.pick_random()
	randomItem["value"] = snappedf(randomItem["value"] * fishValueHeight_rng.randf_range(fishValueHeight_randomizer[0], fishValueHeight_randomizer[1]), 0.01)
	randomItem["weight"] = snappedf(randomItem["weight"] * fishValueHeight_rng.randf_range(fishValueHeight_randomizer[0], fishValueHeight_randomizer[1]), 0.01)
	return randomItem



func rarities_weights_reset():
	rarities_weights = rarities_weights_FINAL
