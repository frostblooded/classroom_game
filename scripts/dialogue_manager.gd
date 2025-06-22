class_name DialogueManager
extends Node

@export var _dialogue_ui: DialogueUI

var dialogue_playing: bool = false

func _enter_tree() -> void:
	EventBus.dialogue_started.connect(_on_dialogue_started)

func _input(event: InputEvent) -> void:
	if !dialogue_playing:
		return
	
	if event.is_action_pressed("advance_dialogue"):
		_end_dialogue()
		get_viewport().set_input_as_handled()

func _on_dialogue_started() -> void:
	_dialogue_ui.start_dialogue()
	dialogue_playing = true
	InputManager.can_player_move = false

func _end_dialogue() -> void:
	_dialogue_ui.end_dialogue()
	dialogue_playing = false
	InputManager.can_player_move = true
