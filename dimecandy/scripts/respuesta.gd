extends Node2D

signal cambiar
func _ready():
    set_process_input(true) 
    ##This may or may not be required for inputs to work.

func _input(ev):
    if Input.is_key_pressed(KEY_ENTER):
        emit_signal("cambiar")