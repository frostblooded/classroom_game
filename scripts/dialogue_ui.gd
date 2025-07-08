class_name DialogueUI
extends CanvasLayer

@export var _animation_player: AnimationPlayer
@export var _speaker_image: TextureRect

func start_dialogue(character: TalkableCharacter) -> void:
	_speaker_image.texture = character.dialogue_sprite.texture
	_animation_player.play("fade_in")

func end_dialogue() -> void:
	_animation_player.play("fade_out")
