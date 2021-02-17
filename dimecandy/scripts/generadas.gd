extends VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var s1
var s2
var s3
var s4
var s5
var sec=10
# Called when the node enters the scene tree for the first time.
func _ready():
	#_on_grid_pasarsprite()
	add_child(s1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_grid_pasarsprite(n1,n2,n3,n4,n5):
	s1=n1
	
	#var sprite = Sprite.new()
	#sprite.texture = load(n1)
	#add_child(n1.instance())
	#$Node.add_child(sprite)
	pass # Replace with function body.


func _on_tiempo_timeout():
	
	if sec % 2 ==0:
		$rotarR.play("rotarR")
	else:
		$rotarR.play_backwards("rotarR")
	sec-=1
	if sec==0:
		sec=10
	
	pass # Replace with function body.
