extends Node

var IncomingFishList = []
var FishList =[]

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	FishLibrary.createdFishList.connect(InitFishList)

func resetFishList():
	FishList = []

func InitFishList():
	resetFishList()
	IncomingFishList = FishLibrary.foundFishes
	for fish in IncomingFishList :
		var value_randomizer = rng.randf_range(fish.vw_randomizer[0],fish.vw_randomizer[1])
		value_randomizer = snapped(value_randomizer, 0.01) 
		if value_randomizer != 1:
			fish.value = fish.value * value_randomizer
			fish.weight = fish.weight * value_randomizer
		FishList.append(fish)
	print(FishList)
