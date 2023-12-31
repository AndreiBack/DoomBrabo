extends CharacterBody3D

@onready var animated_sprite_2d = $CanvasLayer/GunBase/AnimatedSprite2D
@onready var ray_cast_3d = $RayCast3D
@onready var shoot_sound = $ShootSound
@onready var death_sound = $DeathSound
@onready var doom_soundtrack = $"../../DoomSoundtrack"

var SPEED = 5.0


var can_shoot = true
var dead = false
var playerLife = 3
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animated_sprite_2d.animation_finished.connect(shoot_anim_done)
	$CanvasLayer/DeathScreen/Panel/Button.button_up.connect(restart)

func _input(event):
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * Global.MOUSE_SENS


func _process(delta):

	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if dead:
		return
	if Input.is_action_just_pressed("shoot"):
		shoot()


func _physics_process(delta):
	if dead:
		return
	var input_dir = Input.get_vector("move_left", "move_right", "move_foward", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()


func restart():
	get_tree().reload_current_scene()
	

func shoot():
	if !can_shoot:
		return
	can_shoot = false
	animated_sprite_2d.play("shoot")
	shoot_sound.play()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill"):
		ray_cast_3d.get_collider().kill()

func shoot_anim_done():
	can_shoot = true

func kill():

	playerLife -= 1
	if playerLife <= 0:
		if Global.highest_kills <= Global.kills:
			Global.highest_kills = Global.kills
		dead = true
		doom_soundtrack.stop()
		death_sound.play()
		$CanvasLayer/DeathScreen.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	
