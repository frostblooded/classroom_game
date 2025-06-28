class_name DialogueUI
extends CanvasLayer

@export var _dialogue_panel: Panel

func _ready() -> void:
    _dialogue_panel.hide()

func start_dialogue() -> void:
    _dialogue_panel.show()

func end_dialogue() -> void:
    _dialogue_panel.hide()
