extends Node2D

#state machine
enum {wait,move}
var state
var sec=10
export (int) var width;
export (int) var height;
export (int) var x_start;
export (int) var y_start;
export (int) var offset;
export (int) var y_offset;
#espacios vacios
export (PoolVector2Array) var empty_spaces
export (PoolVector2Array) var ice_spaces
export (PoolVector2Array) var lock_spaces
export (PoolVector2Array) var slime_spaces

var sqty=7
var iqty=6
var lqty=10
var damage_slime=false

#señales obstaculo
signal damage_ice
signal make_ice
signal make_lock
signal damage_lock
signal make_slime
signal damage_slime
signal genera_p
signal actualiza_barra
signal contar
signal pasarsprite



const fruta: Array = [
	'res://piece_manzana.tscn',
	'res://piece_mango.tscn',
	'res://piece_coco.tscn',
	'res://piece_cereza.tscn',
	'res://piece_sandia.tscn',
	'res://piece_uva.tscn',
	'res://piece_papaya.tscn',
	'res://piece_carambola.tscn',
	'res://piece_limon.tscn',
	'res://piece_naranja.tscn',
	'res://piece_melon.tscn'
	#'res://piece_lima.tscn',

	
]
const carboFruta: Array=[
	15,
	16,
	16,
	15,
	12,
	18,
	14,
	7,
	9,
	13,
	13
]
const cadFruta: Array=[
	'manzana',
	'mango',
	'coco',
	'cereza',
	'sandia',
	'uva',
	'papaya',
	'carambola',
	'limon',
	'naranja',
	'melon'
]
const verdura: Array=[
	'res://piece_zanahoria.tscn',
	'res://piece_ajo.tscn',
	'res://piece_ejote.tscn',
	'res://piece_chile.tscn',
	'res://piece_champinon.tscn',
	'res://piece_tomate.tscn',
	'res://piece_calabaza.tscn',
	'res://piece_lechuga.tscn',
	#'res://piece_cebolla.tscn',
	'res://piece_cebolla2.tscn',
	'res://piece_pimiento.tscn',
	'res://piece_rabano.tscn',
	'res://piece_brocoli.tscn',
]
const cadVerdura:Array=[
'zanahoria',
'ajo',
'ejote',
'chile',
'champinon',
'tomate',
'calabaza',
'lechuga',
'cebolla2',
'pimiento',
'rabano',
'brocoli'


]
const cadrealVerdura:Array=[
'zanahoria',
'ajo',
'ejote',
'chile',
'champinon',
'tomate',
'calabaza',
'lechuga',
'cebolla',
'pimiento',
'rabano',
'brocoli'
]
const carboVerdura: Array=[
	4,
	24,
	7,
	4,#poblano
	8,
	4,
	5,
	4,
	5,
	4,
	3,
	4
	#
]

const leguminosa: Array=[
'res://frijoles.tscn',

]
const carboLeguminosa:Array=[
20
]
const cadLeguminosa:Array=[
	'canbeans'
]
const cadrealLeg:Array=[
'frijoles'
]

const leche: Array=[
'res://leche.tscn',
'res://lechesoy.tscn',
'res://helado.tscn',
'res://yogur.tscn',
'res://yogurfruta.tscn'

]
const carboLeche: Array=[
11,
4,
23,
16,
17
]
const cadLeche: Array=[
	'leche',
	'lechesoya',
	'helado',
	'yogur',
	'yogurfruta'
]
const cadrealLeche:Array=[
	'leche entera',
	'leche de soya',
	'helado de vainilla',
	'yogur light',
	'yogur light con fruta'
]

const grasa: Array=[
'res://piece_aguacate.tscn',
'res://aceitemaiz.tscn',
'res://aceiteoliva.tscn',
'res://mantequilla.tscn',
'res://guacamole.tscn'
]
const cadGrasa:Array=[
'aguacate',
'aceiteM',
'oliva',
'mantequilla',
'guacamole'
]
const cadrealGrasa:Array=[
'aguacate',
'aceite de maíz',
'aceite de oliva',
'mantequilla',
'guacamole'
]
const carboGrasa:Array=[
2,
0,
0,
0,
2
]

const especial: Array=[
'res://osito.tscn',
'res://coca.tscn',
'res://miel.tscn',
'res://sobreazucar.tscn',
'res://jugo.tscn'
]
const carboEspecial:Array=[
3,
15,
6,
5,
20
]
const proteina: Array=[
'res://carne_res.tscn',
'res://carne_pez.tscn',
'res://carne_pollo.tscn'
]
const cadProteina: Array=[
'res',
'pescado',
'pollo'
]
const carboProteina:Array=[
0,
0,
0
]

const cereal: Array=[
'res://piece_papa.tscn',
'res://arroz.tscn',
'res://galletasalada.tscn',
'res://palomitas.tscn'
]
const cadCereal:Array=[
'papa',
'arroz',
'galletasalada',
'palomitas'
]
const carboCereal:Array=[
17,
13,
11,
14
]

var n1=get_randomVerdura();
var n2=get_randomFruta();
var n3=get_randomLegCereal();
var n4=get_randomProteina();
#var n5=get_randomLeche();
var n5=get_randomGrasaLeche();
#var n6=get_randomGrasa();
var possible_pieces=[

load(n1),
load(n2),
load(n3),
load(n4),
load(n5)
#load(n6)

];

var all_pieces =[];
var current_matches=[]
#deshacer variables
var piece_one=null
var piece_two=null
var last_place=Vector2(0,0)
var last_direction=Vector2(0,0)
var move_checked=false
#
var first_touch=Vector2(0,0);
var final_touch=Vector2(0,0);
var controlling= false;


var scoreGrasa;
var scoreLeche
var scoreVerdura;
var scoreFruta;
var scoreProteina;
var scoreCereal
var scoreLeguminosa;

#score variables
signal update_score
export (int) var piece_value
var streak=1
# Called when the node enters the scene tree for the first time.
#Effectos
var particle_effect=preload("res://ParticleEffect.tscn")
var animated_effect=preload("res://AnimatedExplosion.tscn")
func _ready():
	state=move
	randomize();
	all_pieces=make_2d_array();
	spawn_pieces();
	spawn_ice()
	spawn_lock()
	spawn_slime()
	#spawn_pregunta() emit_signal("genera_p")

func restricted_movement(place): #restricted fill
	#checar piezas vacias
	if is_in_array(empty_spaces,place):
		return true
	if is_in_array(slime_spaces,place):
		return true
	return false
	#for i in empty_spaces.size():
	#	if empty_spaces[i]==place:
	#		return true
	#return false
func restricted_move(place):
	#checar el licox
	if is_in_array(lock_spaces,place):
		return true
	return false
func is_in_array(array,item):
	for i in array.size():
		if array[i]==item:
			return true
	return false
func get_randomVerdura() ->String:
	randomize();
	var index=randi()%verdura.size();
	scoreVerdura=index
	
	
	return verdura[index] 
func get_randomLegCereal() ->String:
	randomize();
	var elegir= randi()%2+1
	if elegir ==1:
		return get_randomCereal()
	
	return get_randomLeguminosa()
func get_randomGrasaLeche():
	randomize();
	var elegir= randi()%2+1
	if elegir ==1:
		return get_randomLeche()
	
	return get_randomGrasa()
func get_randomLeguminosa() ->String:
	randomize();
	var index=randi()%leguminosa.size();
	scoreLeguminosa=index
	return leguminosa[scoreLeguminosa] 
	
func get_randomFruta() ->String:
	randomize();
	var index=randi()%fruta.size();
	scoreFruta=index
	return fruta[scoreFruta]

func get_randomGrasa() ->String:
	randomize();
	var index=randi()%grasa.size();
	scoreGrasa=index
	return grasa[scoreGrasa] 

func get_randomLeche() ->String:
	randomize();
	var index=randi()%leche.size();
	scoreLeche=index
	return leche[scoreLeche] 

func get_randomhipo() ->String:
	randomize();
	return especial[randi() % especial.size()]  

func get_randomCereal() ->String:
	randomize();
	var index=randi()%cereal.size();
	scoreCereal=index
	return cereal[scoreCereal] 

func get_randomProteina() ->String:
	randomize();
	var index=randi()%proteina.size();
	scoreProteina=index
	return proteina[scoreProteina] 
func make_2d_array():
	var array=[];
	for i in width:
		array.append([]);
		for j in height:
			array[i].append(null);
	return array;
func spawn_pieces():
	for i in width:
		for j in height:
			if !restricted_movement(Vector2(i,j)):
				#elegir numero al azar y almacenarlo
				var rand=floor(rand_range(0,possible_pieces.size()));
				
				var piece=possible_pieces[rand].instance();
				var loops=0;
				while(match_at(i,j,piece.color) && loops<100):
					rand=floor(rand_range(0,possible_pieces.size()));
					loops+=1;
					piece=possible_pieces[rand].instance();
				#instane that piece from the array
				add_child(piece);
				piece.position=grid_to_pixel(i,j);
				all_pieces[i][j]=piece;
				
	$Label.text=String(cadrealVerdura[scoreVerdura])
	if scoreLeguminosa!=null:
		$Label2.text=String(cadrealLeg[scoreLeguminosa])
	if scoreCereal !=null:
		$Label2.text=String(cadCereal[scoreCereal])
	$Label3.text=String(cadFruta[scoreFruta])
	$Label4.text=String(cadProteina[scoreProteina])
	if scoreGrasa!=null:
		$Label5.text=String(cadrealGrasa[scoreGrasa])
	if scoreLeche!=null:
		$Label5.text=String(cadrealLeche[scoreLeche])
	$generadas/gener.add_child(possible_pieces[0].instance())
	$generadas/n2.add_child(possible_pieces[1].instance())
	$generadas/n3.add_child(possible_pieces[2].instance())
	$generadas/n4.add_child(possible_pieces[3].instance())
	$generadas/n5.add_child(possible_pieces[4].instance())
	
	
	#$generadas._on_grid_pasarsprite(n1,n2,n3,n4,n5)
	#emit_signal("pasarsprite",n1,n2,n3,n4,n5)

func spawn_ice():
	for i in ice_spaces.size():
		emit_signal("make_ice",ice_spaces[i])
		
	
func spawn_lock():
	for i in 10:
		emit_signal("make_lock",lock_spaces[i],i)
		
		
func spawn_slime():
	for i in slime_spaces.size():
		emit_signal("make_slime",slime_spaces[i])
func match_at(i,j,color):
	if i>1:
		if all_pieces[i-1][j]!=null && all_pieces[i-2][j] !=null:
			if all_pieces[i-1][j].color==color && all_pieces[i-2][j].color==color:
				return true;
	if j>1:
		if all_pieces[i][j-1]!=null && all_pieces[i][j-2] !=null:
			if all_pieces[i][j-1].color==color && all_pieces[i][j-2].color==color:
				return true;
func grid_to_pixel(column, row):
	var new_x=x_start+offset*column;
	var new_y=y_start+-offset*row;
	return Vector2(new_x,new_y);
	pass;

func pixel_to_grid(pixel_x,pixel_y):
	var new_x=round((pixel_x-x_start)/offset);
	var new_y=round((pixel_y-y_start)/-offset);
	return Vector2(new_x,new_y);
	pass;

func is_in_grid(column,row):
	if column>=0 && column<width:
		if row >=0 && row<height:
			return true;
	return false;
	pass;

func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		first_touch=get_global_mouse_position();
		var grid_position=pixel_to_grid(first_touch.x,first_touch.y);
		if is_in_grid(grid_position.x, grid_position.y):
			controlling=true;
		else:
			print("not ok");
	if Input.is_action_just_released("ui_touch"):
		final_touch=get_global_mouse_position();
		var grid_position = pixel_to_grid(final_touch.x,final_touch.y);
		if is_in_grid(grid_position.x,grid_position.y) && controlling:
			touch_difference(pixel_to_grid(first_touch.x,first_touch.y),grid_position);
			controlling=false;
			
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func swap_pieces(column,row,direction):
	var first_pice=all_pieces[column][row];
	var other_piece=all_pieces[column+direction.x][row+direction.y];
	if first_pice!=null && other_piece!=null:
		if !restricted_move(Vector2(column,row)) and !restricted_move(Vector2(column,row)+direction):
			store_info(first_pice,other_piece,Vector2(column,row),direction)
			state=wait
			all_pieces[column][row]=other_piece;
			all_pieces[column+direction.x][row+direction.y]=first_pice;
			first_pice.move(grid_to_pixel(column+direction.x, row+direction.y));
			other_piece.move(grid_to_pixel(column,row));
			if !move_checked:
				find_matches()
	
func store_info(first_piece,other_piece,place,direction):
	piece_one=first_piece
	piece_two=other_piece
	last_place=place
	last_direction=direction
	pass
func swap_back():
	#deshacer si no combinan
	if piece_one!=null && piece_two!=null:
		swap_pieces(last_place.x,last_place.y,last_direction)
		state=move
		move_checked=false
	pass
func touch_difference(grid_1,grid_2):
	var difference=grid_2-grid_1;
	if abs(difference.x)> abs(difference.y):
		if difference.x>0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(1,0));
		elif difference.x<0:
			swap_pieces(grid_1.x,grid_1.y,Vector2(-1,0));
	elif abs(difference.y)>abs(difference.x):
		if difference.y>0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0,1));
		if difference.y<0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0,-1));
	pass;
func _process(delta):
	if state==move:
		touch_input();
#	pass
func find_matches():
	var clr
	for i in width:
		for j in height:
			if all_pieces[i][j]!=null:
				var current_color=all_pieces[i][j].color;
				clr=current_color;
				if i>0 && i<width-1:
					if !is_piece_null(i-1,j) && all_pieces[i+1][j]!=null:
						if all_pieces[i-1][j].color==current_color && all_pieces[i+1][j].color==current_color:
							match_and_dim(all_pieces[i-1][j])
							
							#all_pieces[i-1][j].matched=true;
							#all_pieces[i-1][j].dim();
							match_and_dim(all_pieces[i][j])
							#all_pieces[i][j].matched=true;
							#all_pieces[i][j].dim();
							match_and_dim(all_pieces[i+1][j])
							#all_pieces[i+1][j].matched=true;
							#all_pieces[i+1][j].dim();
							add_to_array(Vector2(i,j))
							add_to_array(Vector2(i+1,j))
							add_to_array(Vector2(i-1,j))
							
							
				if j>0 && j<height-1:
					if all_pieces[i][j-1]!= null && all_pieces[i][j+1]!=null:
						if all_pieces[i][j-1].color==current_color && all_pieces[i][j+1].color==current_color:
							match_and_dim(all_pieces[i][j-1])
							
							#all_pieces[i-1][j].matched=true;
							#all_pieces[i-1][j].dim();
							match_and_dim(all_pieces[i][j])
							#all_pieces[i][j].matched=true;
							#all_pieces[i][j].dim();
							match_and_dim(all_pieces[i][j+1])
							add_to_array(Vector2(i,j))
							add_to_array(Vector2(i,j+1))
							add_to_array(Vector2(i,j-1))
							
							
	
	get_parent().get_node("destroytimer").start()
	
func add_to_array(value,array_to_add=current_matches):
	if !array_to_add.has(value):
		array_to_add.append(value)
		
func is_piece_null(column,row):
	if all_pieces[column][row]==null:
		return true
	return false
func match_and_dim(item):
	item.matched=true
	item.dim()
	pass
func find_bombs():
	for i in current_matches.size():
		var current_column=current_matches[i].x
		var current_row=current_matches[i].y
		
		var current_color=all_pieces[current_column][current_row].color
		var matched=0
		for j in current_matches.size():
			var this_column=current_matches[j].x
			var this_row=current_matches[j].y
			var this_color=all_pieces[current_column][current_row].color
			var col_matched=0
			var row_matched=0
			if current_matches[j].x==current_column and current_color==this_color:
				col_matched+=1
			if this_row==current_row and this_color==current_color:
				row_matched+=1
		
			
func destroy_matched():
	find_bombs()
	var clr
	var was_matched=false
	for i in width:
		for j in height:
			
			if all_pieces[i][j]!=null:
				var current_color=all_pieces[i][j].color
				if all_pieces[i][j].matched:
					clr=current_color
					damage_special(i,j)
					was_matched=true
					all_pieces[i][j].queue_free()
					all_pieces[i][j]=null
					make_effect(particle_effect,i,j)
					make_effect(animated_effect,i,j)
					if clr==cadVerdura[scoreVerdura]:
						
						emit_signal("update_score",(carboVerdura[scoreVerdura]/3)*streak)
						emit_signal("actualiza_barra",carboVerdura[scoreVerdura]/3)
						emit_signal("contar",carboVerdura[scoreVerdura]/3)
					
					if clr==cadFruta[scoreFruta]:
						emit_signal("update_score",(carboFruta[scoreFruta]/3)*streak)
						emit_signal("actualiza_barra",carboFruta[scoreFruta]/3)
						emit_signal("contar",carboFruta[scoreFruta]/3)
					
					if scoreGrasa!=null && clr==cadGrasa[scoreGrasa]:
						
						emit_signal("update_score",(carboGrasa[scoreGrasa]/3)*streak)
						emit_signal("actualiza_barra",carboGrasa[scoreGrasa]/3)
						emit_signal("contar",carboGrasa[scoreGrasa]/3)
					
					if scoreLeche!=null && clr==cadLeche[scoreLeche]:
						emit_signal("update_score",(carboLeche[scoreLeche]/3)*streak)
						emit_signal("actualiza_barra",carboLeche[scoreLeche]/3)
						emit_signal("contar",carboLeche[scoreLeche]/3)
					
					if scoreCereal!=null && clr==cadCereal[scoreCereal]:
						emit_signal("update_score",(carboCereal[scoreCereal]/3)*streak)
						emit_signal("actualiza_barra",carboCereal[scoreCereal]/3)
						emit_signal("contar",carboCereal[scoreCereal]/3)
					
					if scoreLeguminosa!=null && clr==cadLeguminosa[scoreLeguminosa]:
						emit_signal("update_score",(carboLeguminosa[scoreLeguminosa]/3)*streak)
						emit_signal("actualiza_barra",carboLeguminosa[scoreLeguminosa]/3)
						emit_signal("contar",carboLeguminosa[scoreLeguminosa]/3)
					
					if clr==cadProteina[scoreProteina]:
						emit_signal("update_score",(carboProteina[scoreProteina]/3)*streak)
						emit_signal("actualiza_barra",carboProteina[scoreProteina]/3)
						emit_signal("contar",carboProteina[scoreProteina]/3)
					
					
	move_checked=true
	if was_matched:
		#print(clr)
		
		get_parent().get_node("collapsetimer").start()
		
		
	else:
		swap_back()
	current_matches.clear()
func make_effect(effect,column,row):
	var current=effect.instance()
	current.position=grid_to_pixel(column,row)
	add_child(current)
	pass
func check_slime(column,row):
	if column < width-1:
		emit_signal("damage_slime",Vector2(column+1,row))
	if column > 0:
		emit_signal("damage_slime",Vector2(column-1,row))
	if row < height-1:
		emit_signal("damage_slime",Vector2(column,row+1))
	if row > 0:
		emit_signal("damage_slime",Vector2(column,row-1))
func damage_special(column,row):
	emit_signal("damage_ice",Vector2(column,row))
	emit_signal("damage_lock",Vector2(column,row))
	check_slime(column,row)
	
func collapse_columns():
	for i in width:
		for j in height:
			if all_pieces[i][j]==null && !restricted_movement(Vector2(i,j)):
				for k in range(j+1,height):
					if all_pieces[i][k]!=null:
						all_pieces[i][k].move(grid_to_pixel(i,j))
						all_pieces[i][j]=all_pieces[i][k]
						all_pieces[i][k]=null
						break
	get_parent().get_node("refill_timer").start()
	
func refill_columns():
	streak+=1
	for i in width:
		for j in height:
			#elegir numero al azar y almacenarlo
			if all_pieces[i][j]==null && !restricted_movement(Vector2(i,j)):
				var rand=floor(rand_range(0,possible_pieces.size()));
				var piece=possible_pieces[rand].instance();
				var loops=0;
				while(match_at(i,j,piece.color) && loops<100):
					rand=floor(rand_range(0,possible_pieces.size()));
					loops+=1;
					piece=possible_pieces[rand].instance();
				#instane that piece from the array
				add_child(piece);
				piece.position=grid_to_pixel(i,j-y_offset);
				piece.move(grid_to_pixel(i,j))
				all_pieces[i][j]=piece;
	after_refill()
signal ganar
func after_refill():
	for i in width:
		for j in height:
			if all_pieces[i][j]!=null:
				if match_at(i,j,all_pieces[i][j].color):
					find_matches()
					get_parent().get_node("destroytimer")
					return
	if !damage_slime:
		sqty+=1
		generate_slime()
	state=move
	streak=1
	move_checked=false
	damage_slime=false
	
func generate_slime():
	#hay piezas aun?
	if slime_spaces.size()>0:
		var slime_made=false
		var tracker=0
		while !slime_made and tracker<100:
			#checar slime al azar
			var random_num=floor(rand_range(0,slime_spaces.size()))
			var curr_x=slime_spaces[random_num].x
			var curr_y=slime_spaces[random_num].y
			var neighbor=find_normal_neighbor(curr_x,curr_y)
			if neighbor!=null:
				#convertir al vecino en slime
				all_pieces[neighbor.x][neighbor.y].queue_free()
				all_pieces[neighbor.x][neighbor.y]=null
				slime_spaces.append(Vector2(neighbor.x,neighbor.y))
				emit_signal("make_slime",Vector2(neighbor.x,neighbor.y))
				slime_made=true
			tracker+=1
	pass
func find_normal_neighbor(column,row):
	#checar derecha
	if is_in_grid(Vector2(column+1,row).x,Vector2(column+1,row).y):
		if all_pieces[column+1][row]!=null:
			return Vector2(column+1,row)
	#checar izq
	if is_in_grid(Vector2(column-1,row).x,Vector2(column-1,row).y):
		if all_pieces[column-1][row]!=null:
			return Vector2(column-1,row)
	#checar arriba
	if is_in_grid(Vector2(column,row+1).x,Vector2(column,row+1).y):
		if all_pieces[column][row+1]!=null:
			return Vector2(column,row+1)
	#checar abajo
	if is_in_grid(Vector2(column,row-1).x,Vector2(column,row-1).y):
		if all_pieces[column][row-1]!=null:
			return Vector2(column,row-1)
	return null
var gano=false
func _on_destroytimer_timeout():
	destroy_matched()
	if sqty==0 && lqty==0 && !gano:
		
		emit_signal("ganar")
		
		gano=true
	 # Replace with function body.


func _on_collapsetimer_timeout():
	collapse_columns()


func _on_refill_timer_timeout():
	refill_columns()
	


func _on_lox_holder_remove_lock(place):
	for i in range(lock_spaces.size()-1,-1,-1):
		if lock_spaces[i]==place:
			lock_spaces.remove(i)
			lqty-=1
			print(lqty)


func _on_slime_holder_remove_slime(place):
	damage_slime=true
	for i in range(slime_spaces.size()-1,-1,-1):
		if slime_spaces[i]==place:
			slime_spaces.remove(i)
			sqty-=1
			print(sqty)
	pass # Replace with function body.


func _on_lox_holder_new(i,board_position):
	lock_spaces.set(i,Vector2(board_position.x,board_position.y))
	
	pass # Replace with function body.


func _on_tiempo_timeout():
	
	
	if sec % 2 ==0:
		$generadas/rotarR.play("rotarR")
	else:
		$generadas/rotarR.play_backwards("rotarR")
	sec-=1
	if sec==0:
		sec=10
	
	pass # Replace with function body.
