class_name GameButton
extends BaseButton

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered():
	scale.x = 1.05
	scale.y = 1.05

func _on_mouse_exited():
	scale.x = 1.0
	scale.y = 1.0

func _on_pressed():
	pass
