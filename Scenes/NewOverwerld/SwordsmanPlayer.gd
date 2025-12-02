extends CharacterBody2D

@onready var move_state_machine:  AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var sword_state_machine:  AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/SwordStateMachine/playback")


#movement
var direction: Vector2
var last_direction: Vector2
@export var speed: int = 50
@export var sprint_speed: int = 100
@export var tool_offset:= 20
var can_move: bool = true
var building:= false
const WALK_SPEED_THRESHOLD = 80.0
const RUN_SPEED_THRESHOLD = 160.0

var move_state 




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
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	#if Input.is_action_just_pressed("attack"):
		#get_move_state()
		#print(move_state)
		#sword_state_machine.travel(state_names[current_tool])
		#$AnimationTree.set("parameters/ToolOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		#can_move = false

func set_animation():
	
	if direction.length() > 0:
		move_state_machine.travel('Walk')
		var direction_animation: Vector2 = Vector2(round(direction.x), round(direction.y))
		$AnimationTree.set("parameters/MoveStateMachine/Walk/blend_position", direction_animation)
		$AnimationTree.set("parameters/MoveStateMachine/Idle/blend_position", direction_animation)
	#elif direction and get_move_state() == "running":
		#move_state_machine.travel('Running')
		#var direction_animation: Vector2 = Vector2(round(direction.x), round(direction.y))
		#$AnimationTree.set("parameters/MoveStateMachine/Running/blend_position", direction_animation)
		#$AnimationTree.set("parameters/MoveStateMachine/Idle/blend_position", direction_animation)
	else:
		move_state_machine.travel('Idle')

func get_move_state():
	var current_speed := velocity.length()
	if current_speed < 5:
		move_state = "idle"
	elif current_speed < WALK_SPEED_THRESHOLD:
		move_state = "walking"
	else:
		move_state = "running"

func _on_animation_tree_animation_finished(_anim_name: StringName) -> void:
	pass
