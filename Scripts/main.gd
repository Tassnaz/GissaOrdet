extends Node2D

var word_list: Array = ["GUCCIKEPS", "EJNAR", "ALLARDISMEN"]

var current_word: String = ""
var scrambled_word: String = ""
var tries_left: int = 5

@onready var word_label: Label = $WordLabel
@onready var guess_input: LineEdit = $GuessInput
@onready var guess_button: Button = $GuessButton
@onready var feedback_label: Label = $FeedbackLabel
@onready var tries_left_label: Label = $TriesLeftlabel

func _ready() -> void:
	new_word()
	word_label.text = scrambled_word
	guess_input.grab_focus()
	tries_left_label.text = str(tries_left)

func new_word():
	current_word = word_list.pick_random()
	scrambled_word = scramble_word(current_word)
	
func scramble_word(word: String) -> String:
	var letters: Array = word.split("")
	var result: String = word
	while result == word:
		letters.shuffle()
		return "".join(letters)
	return result

func _on_guess_button_pressed() -> void:
	if guess_input.text == current_word:
		feedback_label.text = "Correct"
		new_word()
		guess_input.clear()
		word_label.text = scrambled_word
		guess_input.grab_focus()
		
	else:
		feedback_label.text = "Wrong"
		tries_left -= 1
		tries_left_label.text = str(tries_left)
		guess_input.clear()
