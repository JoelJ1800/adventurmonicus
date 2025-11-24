extends Node

var audio_players : Array[AudioStreamPlayer]
var global_volume : float = 0.1# Range 0.0 (mute) to 1.0 (full volume)

func play(stream : AudioStream, volume_scale : float = 1.0):
	var ap : AudioStreamPlayer = _get_available_audio_player()
	ap.stream = stream
	ap.volume_db = linear_to_db(global_volume * volume_scale)
	ap.play()

func set_global_volume(volume : float):
	global_volume = clamp(volume, 0.0, 1.0)
	for player in audio_players:
		if player.playing:
			player.volume_db = linear_to_db(global_volume)

func _create_new() -> AudioStreamPlayer:
	var ap : AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(ap)
	audio_players.append(ap)
	return ap

func _get_available_audio_player() -> AudioStreamPlayer:
	for ap in audio_players:
		if not ap.playing:
			return ap
	return _create_new()
