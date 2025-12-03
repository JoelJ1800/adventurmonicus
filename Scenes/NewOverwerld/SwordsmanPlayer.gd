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
	if direction:
		last_direction = direction
	if Input.is_action_pressed("sprint"):
		velocity = direction * sprint_speed * int(can_move)
	else:
		velocity = direction * speed * int(can_move)
	get_move_state()
	move_and_slide()

func get_input():
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if Input.is_action_just_pressed("attack") and not $AnimationTree.get("parameters/SwordOneShot/active"):
		if move_state != "running" and move_state != "walking":
			can_move = false
		var attack_anim = get_attack_animation_name()
		sword_state_machine.travel(attack_anim)
		var direction_animation: Vector2 = Vector2(round(last_direction.x), round(last_direction.y))
		$AnimationTree.set("parameters/SwordStateMachine/" + attack_anim + "/blend_position", direction_animation)
		$AnimationTree.set("parameters/SwordOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		print(attack_anim + move_state)
		await get_tree().create_timer(0.5).timeout
		can_move = true

func set_animation():
	if direction.length() > 0 and move_state == "walking":
		move_state_machine.travel('Walk')
		var direction_animation: Vector2 = Vector2(round(direction.x), round(direction.y))
		$AnimationTree.set("parameters/MoveStateMachine/Walk/blend_position", direction_animation)
		$AnimationTree.set("parameters/MoveStateMachine/Idle/blend_position", direction_animation)
	elif direction and move_state == "running":
		move_state_machine.travel('Running')
		var direction_animation: Vector2 = Vector2(round(direction.x), round(direction.y))
		$AnimationTree.set("parameters/MoveStateMachine/Running/blend_position", direction_animation)
		$AnimationTree.set("parameters/MoveStateMachine/Idle/blend_position", direction_animation)
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

func get_attack_animation_name() -> String:
	match move_state:
		"idle":
			return "IdleAttack"
		"walking":
			return "WalkingAttack"
		"running":
			return "RunningAttack"
		_:
			return "IdleAttack"

func wait_for_oneshot():
	while $AnimationTree.get("parameters/SwordOneShot/active"):
		await get_tree().process_frame
#class_name Player
#extends Character
#
#signal UpdatedGold(gold:int)
#
#@onready var inventory:Inventory = $Inventory
#@onready var dialogue_controller : DialogueController = $DialogueController
#var interaction_controller : InteractionController
#@onready var shop_ui : ShopUI = $HUD/ShopScreen
#
#var gold : int = 0
#
#func _ready() -> void:
	#if GameManager.player and GameManager.player != self:
		#queue_free()
		#return
	#
	#var gold_ui = $HUD/Gold/GoldText
	#UpdatedGold.connect(gold_ui._on_updated_gold)
	#
	#UpdatedGold.emit(gold)
	#
	#GameManager.player = self
	#reparent.call_deferred(get_tree().root)
#
#
#func _process(_delta: float) -> void:
	#move_input = Input.get_vector("move_left","move_right","move_up","move_down")
	#
	#var mouse_pos: Vector2 = get_global_mouse_position()
	#look_direction = global_position.direction_to(mouse_pos)
#
#
#func _die():
	#GameManager.game_over()
#
#func toggle_usability (toggle:bool):
	#can_move = toggle
	#weapons.can_use = toggle
	#if not interaction_controller:
		#interaction_controller = $InteractionController
	#if toggle:
		#interaction_controller.enable()
	#else:
		#interaction_controller.disable()
#
#func give_gold (amount : int):
	#gold += amount
	#UpdatedGold.emit(gold)
#
#func take_gold (amount : int):
	#gold -= amount
	#UpdatedGold.emit(gold)
