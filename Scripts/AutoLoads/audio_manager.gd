extends Node

var audio_players : Array[AudioStreamPlayer]


func play (stream : AudioStream):
	pass

func _create_new () -> AudioStreamPlayer:
	var ap : AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(ap)
	audio_players.append(ap)
	return ap

func _get_available_audio_player () -> AudioStreamPlayer:
	pass
