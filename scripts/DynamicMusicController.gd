extends AudioStreamPlayer

@export var player1: Node
@export var player2: Node
@export var close_distance: float = 10.0

@export var start_close_music: int
@export var close_endings: Array[int] = []
@export var start_far_music: int
@export var far_endings: Array[int] = []

var is_close: bool = false

func _ready():
	set_process(true)

func _process(delta):
	update_music_based_on_distance()

func update_music_based_on_distance():
	if player1 and player2:
		var distance = player1.global_position.distance_to(player2.global_position)
		var should_be_close = distance <= close_distance

		if should_be_close != is_close:
			if should_be_close:
				transition_to_close_music()
			else:
				transition_to_far_music()
			is_close = should_be_close

func transition_to_close_music():
	var stream = get_stream() as AudioStreamInteractive
	for end_clip in far_endings:
		if stream and not stream.has_transition(end_clip, start_close_music):
			stream.add_transition(
				end_clip, start_close_music,
				AudioStreamInteractive.TransitionFromTime.TRANSITION_FROM_TIME_END,
				AudioStreamInteractive.TransitionToTime.TRANSITION_TO_TIME_START,
				AudioStreamInteractive.FadeMode.FADE_DISABLED, 0.0
			)
	play_clip(start_close_music)

func transition_to_far_music():
	var stream = get_stream() as AudioStreamInteractive
	for end_clip in close_endings:
		if stream and not stream.has_transition(end_clip, start_far_music):
			stream.add_transition(
				end_clip, start_far_music,
				AudioStreamInteractive.TransitionFromTime.TRANSITION_FROM_TIME_IMMEDIATE,
				AudioStreamInteractive.TransitionToTime.TRANSITION_TO_TIME_START,
				AudioStreamInteractive.FadeMode.FADE_DISABLED, 0.0
			)
	play_clip(start_far_music)

func play_clip(clip_index: int):
	var playback = get_stream_playback()
	if playback is AudioStreamPlaybackInteractive:
		pass
