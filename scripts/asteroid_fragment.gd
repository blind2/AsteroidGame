extends Area2D

export var velocity = Vector2()
export var speed = 60
var rng = RandomNumberGenerator.new()
var nombre_positionX
var nombre_positionY
var rotation_fragment
var point = 10

#instance
export(PackedScene) var explosion = preload("res://scenes/Explosion.tscn")
export(PackedScene) var explosion_player = preload("res://scenes/Explosion2.tscn")

func _ready():
	rng.randomize()
	#Créer un float entre -200 et 200
	nombre_positionX = rng.randf_range(-200,200)
	nombre_positionY = rng.randf_range(-200,200)
	#Créer un float entre -5 et 5
	rotation_fragment = rng.randf_range(-5, 5)
	

func _process(delta):
	velocity = Vector2(nombre_positionX, nombre_positionY)
	rotation +=rotation_fragment*delta
	position += velocity * delta
	cote_ecran()
	

func cote_ecran():
	var largeur = get_viewport().size.x
	var hauteur = get_viewport().size.y
	
	if self.position.x > largeur+ self.rotation:
		self.position.x = -self.rotation
	elif self.position.x < -self.rotation:
		self.position.x = largeur+self.rotation
	
	if self.position.y > hauteur+ self.rotation:
		self.position.y = -self.rotation
	elif self.position.y < -self.rotation:
		self.position.y = hauteur+self.rotation

func _on_AsteroidFragment_body_entered(body):
	if "Player" in body.name:
		#enleve l'asteroide de l'ecran
		queue_free()
		
		#explosion animation pour le joueur
		var explosion_player_instance = explosion_player.instance()
		explosion_player_instance.position = position
		explosion_player_instance.frame =0
		explosion_player_instance.visible = true
		explosion_player_instance.play()
		get_parent().add_child(explosion_player_instance)
		
		#le joueur peut prendre des degat
		Global. prendre_degat = true
		
		if Global.life ==0 :
			#enleve le joueur de l'ecran
			body.queue_free()

	if "FireBall" in body.name:
		#enleve la balle et l'asteroide de l'ecran
		body.queue_free()
		queue_free()
		
		#ajoute les points au score
		Global.score+=point
		#créer une explosion l'orsque la balle entre en collision
		var explosion_instance = explosion.instance()
		explosion_instance.position = body.position
		explosion_instance.frame =0
		explosion_instance.visible = true
		explosion_instance.play()
		get_parent().add_child(explosion_instance)

