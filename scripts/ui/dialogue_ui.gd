class_name DialogueUI
extends CanvasLayer

@export var _animation_player: AnimationPlayer
@export var _dialogue_background: TextureRect

@export var _dialogue_text_container: DialogueTextContainer
@export var _dialogue_choice_container: DialogueChoiceContainer

func _enter_tree() -> void:
	_dialogue_background.hide()

func on_start_dialogue(character: TalkableCharacter) -> void:
	_dialogue_text_container.on_start_dialogue(character)
	_dialogue_choice_container.on_start_dialogue(character)
	_animation_player.play("fade_in")

func on_end_dialogue() -> void:
	_animation_player.play("fade_out")

func on_progress_dialogue(element: DialogueElement) -> void:
	if element is DialogueTextElement:
		_dialogue_text_container.show()
		_dialogue_choice_container.hide()
		_dialogue_text_container.on_progress_dialogue(element)
	elif element is DialogueChoiceElement:
		_dialogue_text_container.hide()
		_dialogue_choice_container.show()
		_dialogue_choice_container.on_progress_dialogue(element)
	else:
		push_error("Unsupported dialogue element type: %s" % element.get_class())
