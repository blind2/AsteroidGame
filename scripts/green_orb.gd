extends KinematicBody2D

var speed = 500
var velocity = Vector2()

#instance
export(PackedScene) var explosion = preload("res://scenes/Explosion.tscn")

# créer un balle
func _creer(newPosition, direction):
	position = newPosition
	velocity = Vector2(speed,0).rotated(direction)

func _process(delta):
	#enleve la balle du jeu lorsqu'il y a une collision
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()
		#enleve une vie au joueur lorsqu'il se fait toucher par un greenorb
		Global. prendre_degat = true
		#créer un explosion
		var explosion_instance = explosion.instance()
		explosion_instance.position = position
		explosion_instance.modulate = Color(0,255,0)
		explosion_instance.frame =0
		explosion_instance.visible = true
		explosion_instance.play()
		get_parent().add_child(explosion_instance)
		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
