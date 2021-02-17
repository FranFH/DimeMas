extends TextureRect

onready var pregunta_label=get_node("pregunta")
var cad=""

const preguntas: Array =[
	'Carbos del \n brocoli',
	'Carbos de \n la carne',
	'Carbos de una \n bebida de cola',
	'Glucosa elevada \n en la sangre',
	'Glucosa Baja en \n la sangre'
	
]
func get_randomPreguntas()->String:
	randomize()
	return preguntas[randi() % preguntas.size()]

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_grid_genera_p()


func _on_grid_genera_p():
	cad="¿"+get_randomPreguntas()+"?"
	pregunta_label.set_text(cad)
	pass # Replace with function body.


func _on_respuesta_cambiar():
	_on_grid_genera_p()
	pass # Replace with function body.
