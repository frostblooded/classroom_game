class_name DialogueElementContainer
extends Control

@export var _text_label: Label
@export var _speaker_image: TextureRect

func on_start_dialogue(character: TalkableCharacter) -> void:
    _speaker_image.texture = character.dialogue_sprite.texture

func on_progress_dialogue(element: DialogueElement) -> void:
    _text_label.text = element.text
