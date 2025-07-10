class_name DialogueManager
extends Node

@export var _dialogue_ui: DialogueUI

var _dialogue_playing: bool = false
var _current_dialogue_data: DialogueData
var _current_dialogue_element_index: int = -1

func _enter_tree() -> void:
    EventBus.dialogue_started.connect(_on_dialogue_started)

func _input(event: InputEvent) -> void:
    if !_dialogue_playing:
        return
    
    if event.is_action_pressed("advance_dialogue"):
        _progress_dialogue()
        get_viewport().set_input_as_handled()

func _on_dialogue_started(character: TalkableCharacter) -> void:
    _dialogue_ui.on_start_dialogue(character)
    _dialogue_playing = true

    _current_dialogue_data = character.dialogue_data
    assert(_current_dialogue_data, "Character has no dialogue data.")

    _current_dialogue_element_index = -1
    InputManager.can_player_move = false

    _progress_dialogue()

func _progress_dialogue() -> void:
    assert(_dialogue_playing, "Trying to progress dialogue when none is playing.")

    var new_element_index: int = _current_dialogue_element_index + 1
    if new_element_index == _current_dialogue_data.elements.size():
        _end_dialogue()
        return

    _current_dialogue_element_index = new_element_index
    var element: DialogueElement = _current_dialogue_data.elements[_current_dialogue_element_index]
    _dialogue_ui.on_progress_dialogue(element)

func _end_dialogue() -> void:
    _dialogue_ui.on_end_dialogue()
    _dialogue_playing = false
    _current_dialogue_data = null
    _current_dialogue_element_index = -1
    InputManager.can_player_move = true
