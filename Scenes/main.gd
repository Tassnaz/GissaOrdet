extends Node2D

var word_list: Array = ["Guccikeps", "Ejnar", "Allardismen"]

var current_word: String = ""
var tries_left: int = 5

@onready var world_label: Label = $WordLabel
@onready var guess_input: LineEdit = $GuessInput
@onready var guess_button: Button = $GuessButton
@onready var feedback_label: Label = $FeedbackLabel
@onready var tries_left_label: Label = $TriesLeftlabel

func _ready() -> void:
	new_word()
	world_label.text = current_word

func new_word():
	current_word = word_list.pick_random()
	
	
func _on_guess_button_pressed() -> void:
	if guess_input.text == current_word:
		feedback_label.text = "Correct"
		new_word()
		guess_input.clear()
		world_label.text = current_word
		
	else:
		feedback_label.text = "Wrong"
		guess_input.clear()
