extends TextureRect

onready var carbtiempo=get_node("scoreR")
var carbos=81
var isded=false

var playcritic=false
# Called when the node enters the scene tree for the first time.
func _ready():
	_on_tiempo_timeout()





func _on_tiempo_timeout():
	
	if carbos==50:
		$music.stop()
		$critic.play()
		playcritic=true
	if carbos>50 && playcritic:
		$critic.stop()
		$music.play()
		playcritic=false
	
		
	if carbos>0:
		carbos-=1
		carbtiempo.text=String(carbos)
	
	
	
	




func _on_grid_contar(num):
	carbos+=num
	pass # Replace with function body.
