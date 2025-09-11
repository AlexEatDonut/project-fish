extends Node

#max money is 1000 cause it's 100 with one decimal
@export var max_money = 1000: 
	set = set_max_money

@export var cam_sensitivity : float = 500

@export var godmode : bool = false


@export var DEFAULT_MINIMUM_CATCHING_DELAY : float
var minimum_catching_delay  = DEFAULT_MINIMUM_CATCHING_DELAY

@export var DEFAULT_MAXIMUM_CATCHING_DELAY : float
var maximum_catching_delay  = DEFAULT_MAXIMUM_CATCHING_DELAY

var debug_mode : bool = false

var fish_inventory  	

var queued_fish

var CurrentState = "IDLE" 

enum locations {
	DEVMAP,
	RIVER,
	LAKE,
	SWAMP,
	PORT,
	JUNGLE,
	CAVE,
	OCEAN,
	CLOUDS
}

var playerLocation
var playerLocationNumber

var is_controlling_camera : bool = false

var can_catch : bool = false
var start_fishing : bool = false 
var in_fishing_position : bool = false

var playerIsBroke : bool = false

var money = max_money  :
	get: 
		return money
	set(value): 
		if money > value:
			#emit_signal("money_decreased")
			pass
		elif money < value: 
			#emit_signal("money_increased")
			pass
		money = value
		emit_signal("money_changed", money)
		if money <= 0:
			emit_signal("no_money")
			playerIsBroke = true
		else:
			playerIsBroke = false

func set_max_money(value):
	max_money = value
	self.money = min (money, max_money)
	emit_signal("max_money_changed", max_money)

func decrease_money(moneyTaken, ratio):
	#var predamage_money = money
	var moneySpent = moneyTaken * ratio
	self.money -= moneySpent
	emit_signal("money_decreased")
	
func increase_money(moneyGiven, ratio):
	var previous_money = money
	if moneyGiven > 0 : 
		#ratio is a percentage from 0 to 1
		var moneyBonus = max_money * ratio
		var theorectical_newmoney = money + moneyBonus
		money = clamp(theorectical_newmoney, previous_money, max_money)
		emit_signal("money_increased")
	else: 
		print("Error ! moneyGiven was 0 or lower. Not multiplying to avoid calculus issues.")

signal max_money_changed
signal money_changed
signal money_increased
signal money_decreased

func _ready():

	pass
