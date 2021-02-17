extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_infobutton_pressed():
	$tablamostrar.play("tabla")
	
	
	#get_tree().change_scene("res://BaseMenuPanel.tscn")
	#get_tree().change_scene("res://principal.tscn")
	pass # Replace with function body.


func _on_home_pressed():
	get_tree().change_scene("res://BaseMenuPanel.tscn")
	pass # Replace with function body.


func _on_regresar_pressed():
	$tablamostrar.play_backwards("tabla")
	pass # Replace with function body.


func _on_ProgressBar_contador():
	$perdermsje.play("perder")
	pass # Replace with function body.


func _on_grid_ganar():
	$ganar.play("ganar")
	pass # Replace with function body.
