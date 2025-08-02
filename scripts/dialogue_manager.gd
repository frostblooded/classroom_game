class_name DialogueManager
extends Node

@export var _timeline: DialogicTimeline

func _enter_tree() -> void:
    EventBus.dialogue_started.connect(_on_dialogue_started)

func _on_dialogue_started() -> void:
    if Dialogic.current_timeline != null:
        return

    Dialogic.start(_timeline)
    InputManager.can_player_move = false

func _end_dialogue() -> void:
    InputManager.can_player_move = true
