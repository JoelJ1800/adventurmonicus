extends Node

var player: Player
var camera: Camera2D
var brdge_built:bool = false

var STATS := {
	"DMG": {
		"icon": "res://UI/resources/dmg_icon.png",
		"max_value": null,
		"tooltip": "Damage"
	},
	"DEF": {
		"icon": "res://UI/resources/deff_icon.png",
		"max_value": null,
		"tooltip": "Defense"
	},
	"SPEED": {
		"icon": "res://UI/resources/speed_icon.png",
		"max_value": 100,
		"tooltip": "Speed"
	},
	"SP.DMG": {
		"icon": "res://UI/resources/sp_dmg.png",
		"max_value": null,
		"tooltip": "Special Damage"
	},
	"SP.DEF": {
		"icon": "res://UI/resources/sp_deff_icon.png",
		"max_value": 100,
		"tooltip": "Special Defense"
	}
}
var SLOTS = {
	"HELMET":{
		"icon": "res://UI/resources/cw_item_example_helmet.png",
		"tooltip": "Helmet"
	},
	"CHEST":{
		"icon": "res://UI/resources/cw_item_example_chest.png",
		"tooltip": "Chestpiece"
	},
	"BELT":{
		"icon": "res://UI/resources/cw_item_example_belt.png",
		"tooltip": "Belt"
	},
	"BOOTS":{
		"icon": "res://UI/resources/cw_item_example_boots.png",
		"tooltip": "Boots"
		},
	"BRACER":{
		"icon": "res://UI/resources/cw_item_example_bracer.png",
		"tooltip": "Bracers"
	},
	"GLOVES":{
		"icon": "res://UI/resources/cw_item_example_gloves.png",
		"tooltip": "Gloves"
	},
	"MAINHAND":{
		"icon": "res://UI/resources/cw_item_example_mainhand.png",
		"tooltip": "Main Weapon"
	},
	"OFFHAND":{
		"icon": "res://UI/resources/cw_item_example_offhand.png",
		"tooltip": "Offhand"
	},
	"MAGIC1":{
		"icon": "res://UI/resources/cw_item_example_rune.png",
		"tooltip": "Rune"
	},
	"MAGIC2":{
		"icon":"res://UI/resources/cw_item_example_rune2.png",
		"tooltip": "Rune"
	},
	"RING1":{
		"icon": "res://UI/resources/cw_item_example_finger.png",
		"tooltip": "Ring"
	},
	"RING2":{
		"icon": "res://UI/resources/cw_item_example_finger.png",
		"tooltip": "Ring"
	}
}

signal scene_changed()

func start_game():
	# Load the initial overworld scene
	get_tree().change_scene_to_file("res://Scenes/NewOverwerld/overworld_2.tscn")
	while get_tree().current_scene == null:
		await get_tree().process_frame
	var overworld = get_tree().root.get_node("Main/Overworld")
	# First time starting the game: get player and camera from scene
	if player == null:
		player = overworld.get_node("Player")
		camera = overworld.get_node("Camera2D")

		# Make persistent by moving to root
		get_tree().root.add_child(player)
		get_tree().root.add_child(camera)

	# Reparent back into overworld for proper Y-sorting
	for node in [player, camera]:
		if node.get_parent() != overworld:
			node.get_parent().remove_child(node)
			overworld.add_child(node)

	# Set starting positions
	player.global_position = Vector2(23, 466)
	camera.global_position = player.global_position
	scene_changed.emit("res://Scenes/NewOverwerld/overworld_2.tscn")

func change_scene(scene: PackedScene, player_position: Vector2):
	# move persistent nodes to root to avoid being freed
	for node in [player, camera]:
		if node != null and node.get_parent() != get_tree().root:
			node.get_parent().remove_child(node)
			get_tree().root.add_child(node)
	get_tree().change_scene_to_packed(scene)
	while get_tree().current_scene == null:
		await get_tree().process_frame
	# get the new overworld
	var overworld = get_tree().root.get_node("Main/Overworld")
	# reparent player and camera into the new overworld
	for node in [player, camera]:
		if node != null and node.get_parent() != overworld:
			node.get_parent().remove_child(node)
			overworld.add_child(node)
	player.global_position = player_position
	camera.global_position = player_position
	overworld.move_child(player, overworld.get_child_count() - 1)

func play_game():
	start_game()

func game_over():
	player.queue_free()
	camera.queue_free()
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
