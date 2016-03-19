
extends Node2D


var screen_size
var pad_size
var left_Score = 0
var right_Score = 0

export var base_ball_speed = 80
export var base_direction = Vector2(-1, 0)
export var base_pad_speed = 150

var ball_speed = base_ball_speed
var direction = base_direction
var pad_speed = base_pad_speed

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("Left").get_texture().get_size()
	set_process(true)


func _process(delta):
	var ball_pos = get_node("Ball").get_pos()
	var left_rect = Rect2(get_node("Left").get_pos() - pad_size/2, pad_size)
	var right_rect = Rect2(get_node("Right").get_pos() - pad_size/2, pad_size)
	
	ball_pos += direction * ball_speed * delta
	
	if (( ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
		
	if (( left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		direction.x = -direction.x
		ball_speed *= 1.1
		direction.y = randf()*2.0-1
		direction = direction.normalized()
		
	if (ball_pos.x < 0):
		ball_pos = screen_size * 0.5
		ball_speed = base_ball_speed
		direction = base_direction
		right_Score += 1
		get_node("Right_Score").set_text(str(right_Score))
		#print("R " + str(right_Score))
		
	if (ball_pos.x > screen_size.x):
		ball_pos = screen_size * 0.5
		ball_speed = base_ball_speed
		direction = -base_direction
		left_Score += 1
		get_node("Left_Score").set_text(str(left_Score))
		#print("L " + str(left_Score))
		
		
	get_node("Ball").set_pos(ball_pos)
	
	
	var left_pos = get_node("Left").get_pos()
	
	if (left_pos.y > 0 and Input.is_action_pressed("left_move_up")):
		left_pos.y += -pad_speed * delta
	if (left_pos.y < screen_size.y and Input.is_action_pressed("left_move_down")):
		left_pos.y += pad_speed * delta
	
	get_node("Left").set_pos(left_pos)
		
	var right_pos = get_node("Right").get_pos()
		
	if (right_pos.y > 0 and Input.is_action_pressed("right_move_up")):
		right_pos.y += -pad_speed * delta
	if (right_pos.y < screen_size.y and Input.is_action_pressed("right_move_down")):
		right_pos.y += pad_speed * delta
		
	get_node("Right").set_pos(right_pos)
	


