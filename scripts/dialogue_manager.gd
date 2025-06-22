class_name DialogueManager
extends Node

@export var _dialogue_ui: DialogueUI

func _enter_tree() -> void:
	EventBus.dialogue_started.connect(_on_dialogue_started)

func _on_dialogue_started() -> void:
	_dialogue_ui.start_dialogue()
	InputManager.can_player_move = false
