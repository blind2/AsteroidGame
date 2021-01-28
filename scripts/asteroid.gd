extends Area2D

export var velocity = Vector2()
export var speed = 60
var rng = RandomNumberGenerator.new()
var nombre_positionX
var nombre_positionY
var rotation_asteroide
var point = 30

#instance
export(PackedScene) var fragment = preload("res://scenes/AsteroidFragment.tscn")
export(PackedScene) var explosion = preload("res://scenes/Explosion.tscn")
export(PackedScene) var explosion_player = preload("res://scenes/Explosion2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	#créer un float entre -200 et 200
	nombre_positionX = rng.randf_range(-200,200)
	nombre_positionY = rng.randf_range(-200,200)
	
	#créer un float entre -4 et 4
	rotation_asteroide = rng.randf_range(-4, 4)
	#
	self.position = Vector2(nombre_positionX, nombre_positionY)
	
func _process(delta):
	velocity = Vector2(nombre_positionX, nombre_positionY)
	self.rotation +=rotation_asteroide*delta
	self.position += velocity * delta
	cote_ecran()
	

func cote_ecran():
	var largeur = get_viewport().size.x
	var hauteur = get_viewport().size.y
	
	if self.position.x > largeur+ self.rotation:
		self.position.x = -self.rotation
	elif self.position.x < -self.rotation:
		self.position.x = largeur+rotation
	
	if self.position.y > hauteur+ self.rotation:
		self.position.y = -self.rotation
	elif self.position.y < -self.rotation:
		self.position.y = hauteur+rotation


func _on_Asteroid_body_entered(body):
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
		
		#Créer 2 fragments d'asteroide  a l'endroit de  l'asteroide
		for i in range(2):
			var fragment_instance = fragment.instance()	
			fragment_instance.position = body.position
			get_parent().add_child(fragment_instance)	
			
