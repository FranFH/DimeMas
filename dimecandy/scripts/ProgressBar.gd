extends ProgressBar

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal contador
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var isdead=false
func _on_tiempo_timeout():
	
	if value==10 && !isdead:
		emit_signal("contador")
		isdead=true
		#get_tree().set_pause(true)
	if value>140 && !isdead:
		
		emit_signal("contador")
		isdead=true
		#get_tree().set_pause(true)
	value-=1
	pass # Replace with function body.


func _on_grid_actualiza_barra(numero_sumar):
	value+=numero_sumar
	#emit_signal("contador",numero_sumar)
	pass # Replace with function body.
