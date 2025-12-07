extends Node

# TODO : Move every var and function related to data to a new simpleton.
# Currently, Playerinfo handles everything. This IS bad AND illogical.

var can_repair_rod : bool = false
var can_switch_rod : bool = true


var all_rods_duability = []

@export var DEFAULT_ROD_REPAIR_COST : float = 10
var RepairCost = DEFAULT_ROD_REPAIR_COST

@export var max_money = 999999999.99: 
	set = set_max_money

@export var max_rod_durability = 100:
	set = set_max_rod_durability	

@export var cam_sensitivity : float = 500

@export var godmode : bool = false


@export var DEFAULT_MINIMUM_CATCHING_DELAY : float
var minimum_catching_delay  = DEFAULT_MINIMUM_CATCHING_DELAY

@export var DEFAULT_MAXIMUM_CATCHING_DELAY : float
var maximum_catching_delay  = DEFAULT_MAXIMUM_CATCHING_DELAY

var debug_mode : bool = false

var equipped_rod : int = 300
var equipped_rod_data : Dictionary

var rod_bait_value : int = 0
var bait_upgrade_stage = 0

var fish_inventory  


var owned_upgrades : Array = []

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

#region Rod Durability
var rod_durability = max_rod_durability:
	get:
		return rod_durability
	set(value): 
		if rod_durability > value:
			#emit_signal("rod_durability_decreased")
			pass
		elif rod_durability < value: 
			#emit_signal("rod_durability_increased")
			pass
		rod_durability = value
		emit_signal("rod_durability_changed", rod_durability)

func set_max_rod_durability(value):
	max_rod_durability = value
	self.rod_durability = min (rod_durability, max_rod_durability)
	emit_signal("max_rod_durability_changed", max_rod_durability)
	
func decrease_rod_durability(damage, ratio : float = 1):
	#var predamage_money = money
	var rod_damage = damage * ratio
	self.rod_durability -= rod_damage
	emit_signal("rod_durability_decreased")
	
func increase_rod_durability(increase, ratio : float = 1):
	var previous_durability = rod_durability
	if increase > 0 : 
		#ratio is a percentage from 0 to 1
		var rod_restoration = increase * ratio
		var theorectical_newdurability = rod_durability + rod_restoration
		rod_durability = clamp(theorectical_newdurability, previous_durability, max_rod_durability)
		emit_signal("rod_durability_increased")
	elif increase <= 0: 
		print("Error ! rod_durability increase was 0 or lower. Check the code again.")

func refill_rod_durability():
	if can_repair_rod == true :
		rod_durability = max_rod_durability
		decrease_money(RepairCost)
		emit_signal("rod_durability_increased")

func repair_rod_eligibility():
	if rod_durability == max_rod_durability:
		can_repair_rod = false
		return
	elif rod_durability < max_rod_durability:
		if CurrentState == "IDLE":
			var missingDurabilityPrcntge = snapped(1 -(rod_durability / max_rod_durability) ,0.01)
			RepairCost = equipped_rod_data["baseline_repair_cost"] + equipped_rod_data["baseline_repair_cost"] * snapped(missingDurabilityPrcntge * equipped_rod_data["durability_repair_multiplier"], 0.01) 
			if money >= RepairCost :
				can_repair_rod = true
				return(RepairCost)
			else:
				can_repair_rod = false
				return
		else :
			can_repair_rod = false
	else:
		return

func repair_rod_free():
	rod_durability = max_rod_durability

func switch_rod_eligibility():
	if CurrentState == "IDLE":
		can_switch_rod = true
	else:
		can_switch_rod = false


func get_rod_data():
	match equipped_rod:
		300:
			equipped_rod_data = Gamedata.fishing_rods["300"]
		301:
			equipped_rod_data = Gamedata.fishing_rods["301"]
		302:
			equipped_rod_data = Gamedata.fishing_rods["302"]
		303:
			equipped_rod_data = Gamedata.fishing_rods["303"]
	#print(equipped_rod_data["strength_desc"])

func get_fish_lurk_timer():
	var rng_lurk_timer = RandomNumberGenerator.new()
	var lurk_timer = rng_lurk_timer.randf_range(queued_fish["lurk_time"][0], queued_fish["lurk_time"][1])
	return(snappedf(lurk_timer * equipped_rod_data["lurk_time_multiplier"] ,0.01))

	
func get_fish_catch_window():
	return(queued_fish["catch_time"] * equipped_rod_data["catch_window_multiplier"])

#endregion
#region Money variable
var money : float = 5 :
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
			playerIsBroke = true
		else:
			playerIsBroke = false

func set_max_money(value):
	max_money = value
	self.money = min (money, max_money)
	emit_signal("max_money_changed", max_money)

func decrease_money(moneyTaken, ratio : float = 1):
	#var predamage_money = money
	var moneySpent = moneyTaken * ratio
	self.money -= moneySpent
	emit_signal("money_decreased")
	
func increase_money(moneyGiven, ratio : float = 1):
	var previous_money = money
	if moneyGiven > 0 : 
		#ratio is a percentage from 0 to 1
		var moneyBonus = moneyGiven * ratio
		var theorectical_newmoney = money + moneyBonus
		money = clamp(theorectical_newmoney, previous_money, max_money)
		emit_signal("money_increased")
	else: 
		print("Error ! moneyGiven was 0 or lower. Not multiplying to avoid calculus issues.")
#endregion


func buy_upgrade(id : int):
	owned_upgrades.append(id)
	#print(owned_upgrades)


func check_bait_value():
	if owned_upgrades.has(101):
		rod_bait_value = 1
		if owned_upgrades.has(102):
			rod_bait_value = 2
			if owned_upgrades.has(103):
				rod_bait_value = 3

signal max_money_changed
signal money_changed
signal money_increased
signal money_decreased

signal max_rod_durability_changed
signal rod_durability_changed
signal rod_durability_increased
signal rod_durability_decreased

func _ready():
	get_rod_data()
	set_max_rod_durability(equipped_rod_data["base_durability"])
	repair_rod_free()

func _process(delta: float) -> void:
	repair_rod_eligibility()
	switch_rod_eligibility()
	
func update_rod_switch():
	get_rod_data()
	set_max_rod_durability(equipped_rod_data["base_durability"])
	repair_rod_free()
