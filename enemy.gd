extends CharacterBody3D

@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var collision_shape_3d = $CollisionShape3D
@onready var death_sound = $DeathSound
@onready var hit_player = $HitPlayer
@onready var health_up = $HealthUp
@export var attack_range = 1.3
@export var respawn_time = 6.0  # Tempo de respawn

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
var dead = false
var respawn_timer = 0.0
var original_position: Vector3
var cooldown_time = 2.0  # Define o tempo de cooldown em segundos
var current_cooldown = 0.0  # Controla o tempo restante de cooldown

func _ready():

	respawn_timer = respawn_time  
	original_position = global_position 
	Global.kills = 0
	Global.enemy_move_speed = 1.5
	if Global.mode == 2: 
		player.SPEED = 10.0
		player.animated_sprite_2d.speed_scale = 2.0
		Global.enemy_move_speed = 9.0
		animated_sprite_3d.speed_scale =1.1

func _physics_process(delta):
	if dead:
		handle_respawn(delta)
		return

	if player == null:
		return

	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	velocity = dir * Global.enemy_move_speed
	move_and_slide()

	# Verifica se o inimigo está em cooldown antes de tentar atacar novamente
	if current_cooldown > 0.0:
		current_cooldown -= delta
		return

	attempt_to_kill_player()

func attempt_to_kill_player():
	var dist_to_player = global_position.distance_to(player.global_position)
	if dist_to_player > attack_range:
		return

	var eye_line = Vector3.UP * 1.5
	var query = PhysicsRayQueryParameters3D.create(global_position + eye_line, player.global_position + eye_line, 1)
	var result = get_world_3d().direct_space_state.intersect_ray(query)

	# Verifica se o resultado está vazio e se o inimigo não está em cooldown
	if result.is_empty() and current_cooldown <= 0.0 and player.dead == false:
		current_cooldown = cooldown_time
		player.kill()
		hit_player.play()



func kill():

	death_sound.play()
	dead = true
	animated_sprite_3d.play("death")
	collision_shape_3d.disabled = true
	modes()

func handle_respawn(delta):
	respawn_timer -= delta
	if respawn_timer <= 0.0:
		respawn()
		respawn_timer = respawn_time

func respawn():
	global_position = original_position  # Define a posição de respawn como a posição original
	dead = false
	animated_sprite_3d.play("idle")
	collision_shape_3d.disabled = false

func modes():
	if Global.mode == 1:
		power_ups()
	if Global.mode == 2:
		power_ups_hell()

func power_ups():
	if Global.kills % 15 == 0:
		player.SPEED += 0.7
	if Global.kills % 20 == 0:
		player.animated_sprite_2d.speed_scale+=0.4
	if Global.kills % 50 == 0:
		player.playerLife +=1
		health_up.play()
	Global.enemy_move_speed += 0.05
	animated_sprite_3d.speed_scale += 0.02
	Global.kills += 1
	

func power_ups_hell():
	if Global.kills % 20 == 0:
		player.SPEED += 1.0
	if Global.kills % 25 == 0:
		player.animated_sprite_2d.speed_scale+=0.8
	if Global.kills % 40 == 0:
		player.playerLife +=1
		health_up.play()
	Global.enemy_move_speed += 0.04
	animated_sprite_3d.speed_scale += 0.05
	Global.kills += 2
