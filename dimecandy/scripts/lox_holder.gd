extends Node2D

signal remove_lock
signal new
var lock_pieces=[]
var width=14
var height=10

var licox=preload("res://licox.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func make_2d_array():
	var array=[];
	for i in width:
		array.append([]);
		for j in height:
			array[i].append(null);
	return array;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_grid_make_lock(board_position,i):
	board_position.x=randi()% 12+0
	board_position.y=randi()%4+0
	
	if board_position.x==12 && board_position.y==0:
		var choose=randi()%2+1
		if choose==1:
			board_position.x-=1
		else:
			board_position.y+=1
	if board_position.x==12 && board_position.y==4:
		var choose=randi()%2+1
		if choose==1:
			board_position.x-=1
		else:
			board_position.y-=1
	if board_position.x==0 && board_position.y==0:
		var choose=randi()%2+1
		if choose==1:
			board_position.x+=1
		else:
			board_position.y+=1
	if board_position.x==0 && board_position.y==4:
		var choose=randi()%2+1
		if choose==1:
			board_position.x+=1
		else:
			board_position.y-=1
	if lock_pieces.size()==0:
		lock_pieces=make_2d_array()
	var current=licox.instance()
	add_child(current)
	current.position=Vector2(board_position.x*80+150,-board_position.y*80+475)
	lock_pieces[board_position.x][board_position.y]=current
	emit_signal("new",i,board_position)
	
	
	# Replace with function body. 450


func _on_grid_damage_lock(board_position):
	if lock_pieces[board_position.x][board_position.y]!=null:
		lock_pieces[board_position.x][board_position.y].take_damage(1)
		if lock_pieces[board_position.x][board_position.y].health<=0:
			lock_pieces[board_position.x][board_position.y].queue_free()
			lock_pieces[board_position.x][board_position.y]=null
			emit_signal("remove_lock",board_position)
	pass # Replace with function body.


