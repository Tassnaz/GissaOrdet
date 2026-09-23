extends Node2D

var word_list: Array = ["HAMBURGARE", "SUSHI", "RAMEN", "TACOS", "PIZZA", "KÖTTBULLAR", "SALLAD", "PASTA"]


var current_word: String = ""
var last_word: String = ""
var scrambled_word: String = ""
var tries_left: int = 5

@onready var word_label: Label = $WordLabel
@onready var guess_input: LineEdit = $GuessInput
@onready var feedback_label: Label = $FeedbackLabel
@onready var tries_left_label: Label = $TriesLeftlabel
@onready var score_label: Label = $ScoreLabel
@onready var score_sfx: AudioStreamPlayer = $ScoreSFX
@onready var incorrect_sfx: AudioStreamPlayer = $IncorrectSFX
@onready var timer_label: Label = $TimerLabel

func _ready() -> void:
	Global.score = 0
	new_word()
	word_label.text = scrambled_word
	guess_input.grab_focus()
	tries_left_label.text = "tries left: " + str(tries_left)

func _process(delta: float) -> void:
	
	
	if tries_left <= 0:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
	timer_label.text = "Time: %d" % ceil($Timer.time_left)

func new_word():
		current_word = word_list.pick_random()
		while current_word == last_word:
			current_word = word_list.pick_random()
		scrambled_word = scramble_word(current_word)
		word_label.text = str(current_word)

func scramble_word(word: String) -> String:
	var letters: Array = word.split("")
	var result: String = word
	while result == word:
		letters.shuffle()
		return "".join(letters)
	return result

func _input(event):
		if event.is_action_pressed("guess") and not guess_input.text.is_empty():
			if guess_input.text == current_word:
				Global.score += 1
				score_label.text = str(Global.score)
				last_word = current_word
				feedback_label.text = "Correct"
				feedback_label.add_theme_color_override("font_color", Color(0.293, 0.676, 0.0, 1.0))
				new_word()
				guess_input.clear()
				word_label.text = scrambled_word
				guess_input.grab_focus()
				score_sfx.play(0)
			
			else:
				feedback_label.text = "Wrong"
				feedback_label.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
				tries_left -= 1
				tries_left_label.text = "tries left: " + str(tries_left)
				guess_input.clear()
				incorrect_sfx.play(0)
				new_word()

func _on_guess_input_text_changed(new_text: String) -> void:
	var upper = new_text.to_upper()
	if upper != new_text:
		var caret = guess_input.caret_column
		guess_input.text = upper
		guess_input.caret_column = caret

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
