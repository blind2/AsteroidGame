extends Area2D

var velocity = Vector2()
onready var  canon = $Canon
onready var shoot_delay = $Timer
var speed = 400

#instance
export(PackedScene) var greenorb = preload("res://scenes/GreenOrb.tscn")
export(PackedScene) var explosion = preload("res://scenes/Explosion.tscn")

func _ready():
	self.position.x =0
	self.position.y = 100
	#Ovnis tire a tout les 0.3 secondes
	shoot_delay.set_wait_time(0.3)
	shoot_delay.start()


func _process(delta):
	velocity = Vector2(speed, 0).rotated(rotation)
	self.position += velocity * delta

func _on_Timer_timeout():
	#créer un balle
	var greenorb_instance = greenorb.instance()	
	greenorb_instance._creer(canon.global_position, 310)
	get_parent().add_child(greenorb_instance)


func _on_Ovnis_body_entered(body):
	if "FireBall" in body.name:
		#augmente le score de 200 points
		Global.score+=100
		body.queue_free()
		queue_free()
		
		#animation de la fireball du joueur
		var explosion_instance = explosion.instance()
		explosion_instance.position = position
		explosion_instance.frame =0
		explosion_instance.visible = true
		explosion_instance.play()
		get_parent().add_child(explosion_instance)
		


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
