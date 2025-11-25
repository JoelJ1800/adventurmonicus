class_name GameButton
extends BaseButton

var hover_sound:AudioStream = preload("res://Audio/UI/Button_Hover.ogg")
var click_sound:AudioStream = preload("res://Audio/UI/Button_Click.ogg")

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	pivot_offset = size / 2

func _on_mouse_entered():
	scale.x = 1.05
	scale.y = 1.05
	
	AudioManager.play(hover_sound)

func _on_mouse_exited():
	scale.x = 1.0
	scale.y = 1.0

func _on_pressed():
	AudioManager.play(click_sound)
