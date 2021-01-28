extends Control

onready var life3 = $Panel/Life3
onready var life2 = $Panel/Life2
onready var life1 =  $Panel/Life1
onready var score = $Panel/Score
onready var game_over = $GameOver

func _process(delta):
	hit()
	score.text =String(Global.score)

func hit():
	#quand le joueur à 3 vie
	if Global.life == 3 and  Global.prendre_degat ==true:
		life3.modulate = Color(255,0,0)
		Global.life -=1
		Global.prendre_degat = false
		
	#quand le joueur à 2 vie
	if Global.life == 2 and Global.prendre_degat == true:
		life2.modulate =  Color(255,0,0)
		life3.modulate =  Color(255,0,0)
		Global.life -=1
		Global.prendre_degat = false
		
	#quand le joueur à une vie
	if Global.life == 1 and Global.prendre_degat == true:
		life1.modulate =  Color(255,0,0)
		life2.modulate =  Color(255,0,0)
		life3.modulate =  Color(255,0,0)
		Global.life-=1
		Global.prendre_degat = false
		
	#quand le joueur è 0 vie
	if Global.life == 0 and Global.prendre_degat == true:
		life1.modulate =  Color(255,0,0)
		life2.modulate =  Color(255,0,0)
		life3.modulate =  Color(255,0,0)
		Global.is_dead = true
		#affiche le pop up pour dire que la partie est terminée
		game_over.show()
