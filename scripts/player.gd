class_name Player
extends CharacterBody2D

@export var _movement_speed: float = 200.0

@export var _sprite: Sprite2D
@export var _talkable_search_area: Area2D
@export var _start_dialogue_hint_panel: Panel

func _ready() -> void:
    _start_dialogue_hint_panel.hide()

func _process(_delta: float) -> void:
    _set_sprite_rotation()
    _update_dialogue_hint()

func _physics_process(_delta: float) -> void:
    if !InputManager.can_player_move:
        velocity = Vector2.ZERO
        return

    var input: Vector2 = Input.get_vector("player_left", "player_right", "player_up", "player_down")
    velocity = input * _movement_speed
    move_and_slide()

func _input(event: InputEvent) -> void:
    if !event.is_action_pressed("start_dialogue"):
        return

    var overlapping_talkable_area: Area2D = _get_overlapping_talkable_area()

    if overlapping_talkable_area:
        var talkable_character: TalkableCharacter = overlapping_talkable_area.get_parent() as TalkableCharacter
        EventBus.dialogue_started.emit(talkable_character)
        get_viewport().set_input_as_handled()

func _update_dialogue_hint() -> void:
    var overlapping_talkable_area: Area2D = _get_overlapping_talkable_area()

    if overlapping_talkable_area:
        _start_dialogue_hint_panel.show()
    else:
        _start_dialogue_hint_panel.hide()

func _set_sprite_rotation() -> void:
    if velocity.length() > 0:
        _sprite.rotation = sin(Time.get_unix_time_from_system() * 10) / 2
    else:
        _sprite.rotation = 0.0

func _get_overlapping_talkable_area() -> Area2D:
    for overlapped_talkable_area: Area2D in _talkable_search_area.get_overlapping_areas():
        if overlapped_talkable_area.is_in_group("talkable_areas"):
            return overlapped_talkable_area

    return null

func _has_valid_talkable_area_overlapping() -> bool:
    return _get_overlapping_talkable_area() != null
