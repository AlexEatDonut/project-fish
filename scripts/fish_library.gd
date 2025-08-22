extends Node


var foundFishes = []
# Number starts with 0
# df = Dev Fish btw
var df0
@export var df0_data = []
var df1

enum FishType{
	COMMON,
	UNCOMMON,
	RARE,
	UNUSUAL,
	LEGENDARY,
	DEVELOPPER
}

class Fish:
	var name : String
	var description : String
	var fishType : String
	var sprite : Texture2D
	var fish_locations = []
	var value : float
	var weight : float
	var rod_damage : float
	var bait_value : float
	var catch_time : float
	var vw_randomizer = [0.7,1.3]

func init_fishes():
	df0 = Fish.new()
	df0.name = df0_data[0]
	df0.description = df0_data[1]
	df0.fishType = df0_data[2]
	df0.sprite = df0_data[3]
	df0.fish_locations = df0_data[4]
	df0.value = df0_data[5]
	df0.weight = df0_data[6]
	df0.rod_damage = df0_data[7]
	df0.bait_value = df0_data[8]
	df0.catch_time = df0_data[9]
	
	#df1 = Fish.new()
	#df1.name = "Dev fish 2"
	#df1.description = "A developper fish to test the functionality of the fish system"
	#df1.fishType = FishType.DEVELOPPER
	#df1.sprite = null
	#df1.fish_locations = [0,1]
	#df1.base_value = 4
	#df1.base_weight = 8
	#df1.rod_damage = 3
	#df1.bait_value = 0
	#df1.catch_time = 3

	print("finished initializing fishes")

var everyFish = [ 
	df0,
	df1
	]


func _ready() -> void:
	init_fishes()

func add_to_inventory():
	pass

func findFishByBiome(biome : float):
	##for fish in 
	#for item in everyFish :
		#if item.fish_locations.has(biome):
			#foundFishes.append(item)
	## for each fishes add to the foundFishes array
	#print(foundFishes)
	#createdFishList.emit(foundFishes)
	return foundFishes


signal createdFishList
