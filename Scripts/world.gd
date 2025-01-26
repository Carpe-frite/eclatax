extends Node2D

@onready var timer = get_node("RoundTimer")
@onready var time_left_label = get_node("UI/TimeLeftLabel")

@onready var levelMusic = get_node("LevelMusicPlayer")
@onready var startSound = get_node("StartSound")
@onready var bubblePopSoundPlayer = get_node("Monde/acteurs/bubble_generator/BubblePopSoundPlayer")
@onready var noteLayerBubblePop = get_node("Monde/acteurs/bubble_generator/NoteLayerBubblePop")
@onready var secret_eclatax = get_node("Audio/secretEclatax")

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
	
	##Scene and bubbles init
	global.bubble_array = []
	global.speed_bubble = 200
	global.currently_selected_bubble_ids = []
	

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
			##Exbullession
			if global.checkIfAcquired(global.elephant_powerups, "Exbullession") and global.probability(global.ExbullesionProb, global.elephant_luck):
				var border_spacing = 50
				global.bee_x = randi_range(border_spacing, 1920-border_spacing)
				global.bee_y = randi_range(border_spacing, 1080-border_spacing)
			
			##Pique-Nique
			if global.checkIfAcquired(global.bee_powerups, "Pique-Nique") and global.probability(global.PiqueNiqueProb, global.bee_luck):
				var j
				var valid_bubbles = []
				for i in range(3):
					valid_bubbles = []
					for k in global.bubble_array:
						if k.bubble_properties["is_alive"]:
							valid_bubbles.append(k)
					print(valid_bubbles)
					if len(valid_bubbles) > 0:
						j = randi_range(0, len(valid_bubbles)-1)
						global.destroy_bubble(valid_bubbles[j])
				
	if Input.is_action_just_released("ui_kb_x"):
		secret_eclatax.play()

func play_note(stream: AudioStream):
	for player in audio_players:
		if not player.is_playing():  # Trouve un player disponible
			player.stream = stream
			player.play()
			return

func _on_round_timer_timeout() -> void:
	global.continue_level_music_at = levelMusic.get_playback_position()  + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	self.get_parent().get_tree().change_scene_to_file("res://round_end.tscn")
