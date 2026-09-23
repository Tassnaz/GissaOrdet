extends Node2D

@onready var score_label: Label = $ScoreLabel
@onready var quit_button: Button = $QuitButton

func _ready() -> void:
	score_label.text = "Score: " + str(Global.score)


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
