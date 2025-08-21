class_name FishResource
extends Resource

enum FishType{
	COMMON,
	UNCOMMON,
	RARE,
	UNUSUAL,
	LEGENDARY
}

@export_category("Fish data")
@export var name : StringName
@export var description : StringName
@export var fishType : FishType

@export_category("Fish data")
@export var caught_sound : PackedScene
@export var sprite : Texture2D
@export var fish_locations = [false,false,false,false,false,false,false,false,false]

@export_category("Fish stats")

@export var min_value : float
@export var max_value : float
@export var min_weight : float
@export var max_weight : float
@export var rod_damage : float
@export var bait_value : float
