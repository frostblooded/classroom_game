class_name DialogueUI
extends CanvasLayer

@export var _animation_player: AnimationPlayer

func start_dialogue() -> void:
	_animation_player.play("fade_in")

func end_dialogue() -> void:
	_animation_player.play("fade_out")
