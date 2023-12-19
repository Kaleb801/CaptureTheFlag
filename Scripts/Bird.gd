extends KinematicBody2D

const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
var WALK_SPEED = 160 # pixels/sec
var JUMP_SPEED = 340
const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000
const SHOOT_TIME_SHOW_WEAPON = 0.2
const CAMERA_MOVE_DISTANCE = 16
const CLIMB_SPEED = 150

var linear_vel = Vector2()
var onair_time = 0 #

func move(input):
	if input.x>0:
		$AnimatedSprite.flip_h=true
	else:
		$AnimatedSprite.flip_h=false
	linear_vel=input*Vector2(WALK_SPEED,WALK_SPEED)
	move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
