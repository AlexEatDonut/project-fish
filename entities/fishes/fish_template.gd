extends Node3D

var initialize_error = "ERROR : minimum value is above maximum"

@export var minimum_value : float
@export var maximum_value : float
var value : float

@export var minimum_weight : float
@export var maximum_weight : float
var weight : float

@onready var sprite_3d: Sprite3D = $Sprite3D
@export var sprite : Texture2D
var sprite_size : float

var rng_value = RandomNumberGenerator.new()
var rng_weight = RandomNumberGenerator.new()



func _ready() -> void:
	if minimum_value > maximum_value or minimum_weight > maximum_weight :
		print(initialize_error)
		return
	value = rng_value.randf_range(minimum_value, maximum_value)
	weight = rng_weight.randf_range(minimum_weight, maximum_weight)
	sprite_3d.texture = sprite
