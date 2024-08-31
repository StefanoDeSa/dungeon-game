extends Area2D

@onready var OuterCircle = $OuterCircle
@onready var InnerCircle = $OuterCircle/InnerCircle
@onready var max_distance = $CollisionShape2D.shape.radius

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(OuterCircle.global_position)
		if not touched:
			if distance<max_distance:
				touched = true
		else:
			InnerCircle.position = Vector2(0,0)
			touched = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if touched:
		InnerCircle.global_position = get_global_mouse_position()
		InnerCircle.position = OuterCircle.position + (InnerCircle.position - OuterCircle.position).limit_length(max_distance)

func get_velo():
	var joy_velo = Vector2(0,0)
	joy_velo.x = InnerCircle.position.x / max_distance
	joy_velo.y = InnerCircle.position.y / max_distance
	return joy_velo
	
