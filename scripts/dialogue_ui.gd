class_name DialogueUI
extends CanvasLayer

@export var _animation_player: AnimationPlayer
@export var _speaker_image: TextureRect
@export var _current_line_label: Label

func on_start_dialogue(character: TalkableCharacter) -> void:
	_speaker_image.texture = character.dialogue_sprite.texture
	_animation_player.play("fade_in")

func on_end_dialogue() -> void:
	_animation_player.play("fade_out")

func on_progress_dialogue(line: String) -> void:
	_current_line_label.text = line
