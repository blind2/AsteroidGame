extends Node

var fullscreen = OS.window_fullscreen
onready var timer = $Timer
onready var spawn_timer = $OvnisSpawnTimer

#script variables
export(PackedScene) var asteroide= preload("res://scenes/Asteroid.tscn")
export(PackedScene) var ovnis = preload("res://scenes/Ovnis.tscn")

func _ready():
	# initialise le jeu avec 2 asteroides
	for i in range(2):
		var asteroide_instance = asteroide.instance()
		add_child(asteroide_instance)
		#timer qui s'occupe de spawner l'ovnis a tout les 15 secondes
		spawn_timer.set_wait_time(15)
		spawn_timer.start()
		#timer qui s'occupe de spawner les astéroides
		timer.set_wait_time(5)
		timer.start()

func _process(delta):
	if Global.is_dead == true:
		timer.stop()
		spawn_timer.stop()

#exit fullscreen
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_Timer_timeout():
	#Ajoute 2 asteroides au jeu
	for i in range(2):
		var asteroide_instance = asteroide.instance()
		add_child(asteroide_instance)
	
func _on_OvnisSpawnTimer_timeout():
	#spaw l'ovnis
	var ovnis_instance = ovnis.instance()
	add_child(ovnis_instance)
