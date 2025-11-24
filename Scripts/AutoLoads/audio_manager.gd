extends Node

var audio_players : Array[AudioStreamPlayer]


func play (stream : AudioStream):
	var ap : AudioStreamPlayer = _get_available_audio_player()
	ap.stream = stream
	ap.play()

func _create_new () -> AudioStreamPlayer:
	var ap : AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(ap)
	audio_players.append(ap)
	return ap

func _get_available_audio_player () -> AudioStreamPlayer:
	for ap in audio_players:
		if not ap.playing:
			return ap
	
	return _create_new()
