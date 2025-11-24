class_name GameButton
extends BaseButton

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered():
	pass

func _on_mouse_exited():
	pass

func _on_pressed():
	pass
