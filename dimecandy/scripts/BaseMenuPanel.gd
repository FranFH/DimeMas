extends CanvasLayer
var sec=10
func slide_in():
	$AnimationPlayer.play("slide")
func slide_out():
	$AnimationPlayer.play_backwards("slide")
func rotar():
	
	
	$figuras.play("rotar")
	#$figuras.play_backwards("rotar")
func _on_play_pressed():
	get_tree().change_scene("res://principal.tscn")


func _on_TextureButton_press():
	
	pass # Replace with function body.


func _on_TextureButton_pressed():
	slide_in()
	pass # Replace with function body.


func _on_regresar_pressed():
	slide_out()
	pass # Replace with function body.


func _on_Timer_timeout():
	
	if sec % 2 ==0:
		$figuras.play("rotar")
	else:
		$figuras.play_backwards("rotar")
	sec-=1
	if sec==0:
		sec=10
	
	pass # Replace with function body.
