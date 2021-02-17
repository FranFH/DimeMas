extends Node2D

signal remove_slime



var slime_pieces=[]
var width=14
var height=10
var qty=7

var slime=preload("res://slime.tscn")
func _ready():
	pass # Replace with function body.
func make_2d_array():
	var array=[];
	for i in width:
		array.append([]);
		for j in height:
			array[i].append(null);
	return array;
func _on_grid_make_slime(board_position):
	if slime_pieces.size()==0:
		slime_pieces=make_2d_array()
	var current=slime.instance()
	
	add_child(current)
	current.position=Vector2(board_position.x*80+150,-board_position.y*80+475)
	slime_pieces[board_position.x][board_position.y]=current
func _on_grid_damage_slime(board_position):
	if slime_pieces[board_position.x][board_position.y]!=null:
		slime_pieces[board_position.x][board_position.y].take_damage(1)
		if slime_pieces[board_position.x][board_position.y].health<=0:
			slime_pieces[board_position.x][board_position.y].queue_free()
			slime_pieces[board_position.x][board_position.y]=null
			emit_signal("remove_slime",board_position)
			qty-=1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
