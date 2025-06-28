class_name FadeManager
extends Node

@export var _timer: Timer
@export var _fade_ui: Control

# If true, the fade will be a fade in, otherwise it will be a fade out.
var _is_fade_in: bool = true

func _ready() -> void:
    _fade_ui.modulate.a = 0.0

func _process(_delta: float) -> void:
    if _timer.is_stopped():
        return

    var fade_progress: float = 1 - (_timer.time_left / _timer.wait_time)

    if _is_fade_in:
        _fade_ui.modulate.a = 1 - fade_progress
    else:
        _fade_ui.modulate.a = fade_progress

func start_fade_out() -> void:
    _is_fade_in = false
    _timer.start()

func start_fade_in() -> void:
    _is_fade_in = true
    _timer.start()
