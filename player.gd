extends CharacterBody2D

@onready var joystick = $UI/JoystickControl/Joystick
var speed = 450

@onready var health_bar = $UI/LifeBarControl/LifeBar
@onready var health_label = $UI/LifeBarControl/LifeCounter
@onready var animated_sprite = $AnimatedSprite2D

var max_health = 500
var current_health = 500

func _ready():
	animated_sprite.play()
	update_health_bar()

func _process(delta):
	velocity = joystick.get_velo() * speed
	
	move_and_slide()
	
	update_animation()

func update_animation():
	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animated_sprite.animation = "walk-right"
			else:
				animated_sprite.animation = "walk-left"
		else:
			if velocity.y > 0:
				animated_sprite.animation = "walk-down"
			else:
				animated_sprite.animation = "walk-up"
		animated_sprite.play()
	else:
		# Quando o personagem parar, escolha a animação idle correspondente
		if animated_sprite.animation.begins_with("walk"):
			animated_sprite.animation = animated_sprite.animation.replace("walk", "idle")
		animated_sprite.play()

func update_health_bar():
	health_bar.value = current_health
	health_label.text = str(current_health)

func die():
	print("O personagem morreu.")

func take_damage(amount):
	current_health -= amount
	current_health = clamp(current_health, 0, max_health) # Garante que a vida não seja negativa
	update_health_bar()
	
	if current_health <= 0:
		die()
