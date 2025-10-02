extends Node

var can_repair_rod : bool = false


@export var DEFAULT_ROD_REPAIR_COST : float = 10
var RepairCost = DEFAULT_ROD_REPAIR_COST

@export var max_money = 999999: 
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

var rod_bait_value = 0

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

#region Dev Shop : Activating certain vars for testing
#TODO : technical debt : make it not suck as hard
var ticket_ownership_1 : bool = false
var bait_upgrade_ownership_1 : bool = false
var bait_upgrade_ownership_2 : bool = false
var bait_upgrade_ownership_3 : bool = false
#endregion

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
		money = clamp(theorectical_newdurability, previous_durability, max_rod_durability)
		emit_signal("rod_durability_increased")
	elif increase <= 0: 
		print("Error ! rod_durability increase was 0 or lower. Check the code again.")

func refill_rod_durability():
	if can_repair_rod == true :
		rod_durability = max_rod_durability
		money  -= RepairCost
		emit_signal("rod_durability_increased")

#endregion
#region Money variable
var money : float = 0 :
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

func repair_rod():
	if rod_durability == max_rod_durability:
		print("wtf you can't repair shit")
		return
	elif rod_durability < max_rod_durability:
		pass
		

func repair_rod_eligibility():
	if rod_durability == max_rod_durability:
		can_repair_rod = false
		return
	elif rod_durability < max_rod_durability:
		if CurrentState == "IDLE":
			var missingDurabilityPrcntge = snapped(1 -(rod_durability / max_rod_durability),0.01)
			RepairCost = DEFAULT_ROD_REPAIR_COST + DEFAULT_ROD_REPAIR_COST * missingDurabilityPrcntge
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
			


func buy_ticket_1():
	ticket_ownership_1 = true

func buy_bait_upgrade_1():
	bait_upgrade_ownership_1 = true
	rod_bait_value = 1

func buy_bait_upgrade_2():
	bait_upgrade_ownership_1 = true
	bait_upgrade_ownership_2 = true
	rod_bait_value = 2

func buy_bait_upgrade_3():
	bait_upgrade_ownership_1 = true
	bait_upgrade_ownership_2 = true
	bait_upgrade_ownership_3 = true
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

	pass

func _process(delta: float) -> void:
	repair_rod_eligibility()
