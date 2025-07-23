class_name DialogueElementContainer
extends Control

@export var _text_label: Label
@export var _speaker_image: TextureRect
@export var _choices_container: Control

var _current_choices: Array[String]
var _current_choice_index: int
var _is_dialogue_active: bool = false

func on_start_dialogue(character: TalkableCharacter) -> void:
    _speaker_image.texture = character.dialogue_sprite.texture
    _is_dialogue_active = true

func on_progress_dialogue(element: DialogueElement) -> void:
    _text_label.text = element.text
    _current_choices = element.choices

    for c in _choices_container.get_children():
        _choices_container.remove_child(c)
        c.queue_free()
    
    if !_current_choices.is_empty():
        for choice_string in _current_choices:
            var choice_label = Label.new()
            choice_label.text = choice_string
            _choices_container.add_child(choice_label)

        _set_current_choice_index(0)

func on_end_dialogue() -> void:
    _is_dialogue_active = false

func _input(event: InputEvent) -> void:
    if !_is_dialogue_active:
        return

    if event.is_action_pressed("dialogue_choice_up"):
        _dialogue_up()
        get_viewport().set_input_as_handled()

    if event.is_action_pressed("dialogue_choice_down"):
        _dialogue_down()
        get_viewport().set_input_as_handled()

func _dialogue_up() -> void:
    _set_current_choice_index(max(0, _current_choice_index - 1))

func _dialogue_down() -> void:
    _set_current_choice_index(min(_current_choice_index + 1, _choices_container.get_child_count() - 1))

func _set_current_choice_index(value: int) -> void:
    if _current_choices.is_empty():
        return

    var previous_choice_label = _choices_container.get_child(_current_choice_index)
    previous_choice_label.remove_theme_color_override("font_color")

    _current_choice_index = value

    var current_choice_label = _choices_container.get_child(_current_choice_index)
    current_choice_label.add_theme_color_override("font_color", Color(1, 0, 0))
