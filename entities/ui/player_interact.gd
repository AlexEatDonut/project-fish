extends Control

signal StartFishing

@onready var start_fishing: Button = $StartFishing


func disable_button():
	start_fishing.disabled = true
func enable_button():
	start_fishing.disabled = false

func _on_start_fishing_pressed() -> void:
	StartFishing.emit()
	disable_button()
	print("haha")
