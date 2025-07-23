class_name DialogueUI
extends CanvasLayer

@export var _animation_player: AnimationPlayer
@export var _dialogue_background: TextureRect

@export var _dialogue_element_container: DialogueElementContainer

func _enter_tree() -> void:
	_dialogue_background.hide()

func on_start_dialogue(character: TalkableCharacter) -> void:
	_dialogue_element_container.on_start_dialogue(character)
	_animation_player.play("fade_in")

func on_end_dialogue() -> void:
	_dialogue_element_container.on_end_dialogue()
	_animation_player.play("fade_out")

func on_progress_dialogue(element: DialogueElement) -> void:
	_dialogue_element_container.on_progress_dialogue(element)
