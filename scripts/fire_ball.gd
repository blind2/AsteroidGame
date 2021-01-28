extends KinematicBody2D

var speed = 500
var velocity = Vector2()

# créer un balle
func _creer(newPosition, direction):
	position = newPosition
	velocity = Vector2(speed,0).rotated(direction)
	

func _process(delta):
	#enleve la balle du jeu lorsqu'il y a une collision
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	#deload les balles du jeu
	queue_free()
