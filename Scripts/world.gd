extends Node2D

@onready var timer = get_node("RoundTimer")
@onready var time_left_label = get_node("UI/TimeLeftLabel")

@onready var levelMusic = get_node("LevelMusicPlayer")
@onready var startSound = get_node("StartSound")
@onready var bubblePopSoundPlayer = get_node("Monde/acteurs/bubble_generator/BubblePopSoundPlayer")
@onready var noteLayerBubblePop = get_node("Monde/acteurs/bubble_generator/NoteLayerBubblePop")

var chordToPlay = 0
var banques = [
	"boite à musique",
	"xylo",
	"banjo",
	"guimbarde"
]

const MAX_PLAYERS = 20
var audio_players: Array = []

@onready var chordArray = global.get_chord_progression(banques[randi() % banques.size()])

#CLASSES
func _ready() -> void:
	for i in range(MAX_PLAYERS):
		var player = AudioStreamPlayer.new()
		add_child(player)
		audio_players.append(player)
	
	startSound.play()
	levelMusic.play(global.continue_level_music_at)
	

func _process(delta: float) -> void:
	var time = levelMusic.get_playback_position() + AudioServer.get_time_since_last_mix()
	time -= AudioServer.get_output_latency()
	chordToPlay = int(time / 2.0)
	
	print(str(time, " ", chordToPlay))
	
	time_left_label.text = str(int(timer.get_time_left()))
	#if global.is_bubble_selected == true:
	if Input.is_action_just_released("ui_mouse_LeftClick"):
		for x in global.currently_selected_bubble_ids:
			play_note(global.get_random_note(chordArray, chordToPlay))
			global.get_chord_progression("boite à musique")
			bubblePopSoundPlayer.stream = global.bubblePopSounds[randi() % 12]
			bubblePopSoundPlayer.play()
			global.destroy_bubble(global.bubble_array[x])
			#if global.checkIfAcquired(global.elephant_powerups, "Exbullession"):
				#var border_spacing = 50
				#global.bee_x = randi_range(border_spacing, 1920-border_spacing)
				#global.bee_y = randi_range(border_spacing, 1080-border_spacing)

func play_note(stream: AudioStream):
	for player in audio_players:
		if not player.is_playing():  # Trouve un player disponible
			player.stream = stream
			player.play()
			return

func _on_round_timer_timeout() -> void:
	global.continue_level_music_at = levelMusic.get_playback_position()  + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	self.get_parent().get_tree().change_scene_to_file("res://round_end.tscn")
