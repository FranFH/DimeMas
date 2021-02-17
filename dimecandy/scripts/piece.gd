extends Node2D
export (String) var color;
var matched=false;
var move_tween;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	move_tween=get_node("move_tween");
	
func move(target):
	move_tween.interpolate_property(self,"position",position,target,.3,Tween.TRANS_BOUNCE,Tween.EASE_OUT);
	move_tween.start();
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func dim():
	var sprite = get_node("Sprite")
	sprite.modulate = Color(1, 1, 1, .5);