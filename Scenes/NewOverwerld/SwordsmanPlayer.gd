extends CharacterBody2D

@onready var move_state_machine:  AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var sword_state_machine:  AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/SwordStateMachine/playback")

#movement
var direction: Vector2
var last_direction: Vector2
@export var speed: int = 5
@export var sprint_speed: int = 5
@export var tool_offset:= 20
var can_move: bool = true
var building:= false

func _physics_process(_delta: float) -> void:
	if can_move:
		get_input()
		set_animation()
	if Input.is_action_pressed("sprint"):
		velocity = direction * sprint_speed * int(can_move)
	else:
		velocity = direction * speed * int(can_move)
	move_and_slide()

func get_input():
	pass

func set_animation():
	pass
