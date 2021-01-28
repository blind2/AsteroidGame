extends KinematicBody2D

export var speed = 200
export var dempening = 0.99
var velocity = Vector2()
onready var canon = $Canon

#script variables
export(PackedScene) var fireball = preload("res://scenes/FireBall.tscn")

func _physics_process(delta):
	get_input()
	cote_ecran()
	#rotation du joueur
	var dir = get_global_mouse_position() - global_position
	if dir.length() > 5:
		rotation = dir.angle()
		move_and_slide(velocity)

func get_input():
	var shoot = Input.is_action_just_pressed("key_S")
	var avancer = Input.is_action_pressed("key_A")

	if avancer:
		velocity = Vector2(speed, 0).rotated(rotation)
	else:
		#perd 0.1% de sa vitesse a toutes les frames
		velocity*= dempening
	
	if shoot:
		var fireball_instance = fireball.instance()	
		fireball_instance._creer(canon.global_position,rotation)
		get_parent().add_child(fireball_instance)

#le joueur peut traversé l'écran de bord en bord
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
