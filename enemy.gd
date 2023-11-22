extends CharacterBody3D

@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var collision_shape_3d = $CollisionShape3D
@onready var death_sound = $DeathSound
@onready var hit_player = $HitPlayer

@export var move_speed = 2.0
@export var attack_range = 2.0
@export var respawn_time = 6.0  # Tempo de respawn

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
var dead = false
var respawn_timer = 0.0
var original_position: Vector3
var cooldown_time = 2.0  # Define o tempo de cooldown em segundos
var current_cooldown = 0.0  # Controla o tempo restante de cooldown
var kills = 0  # Contador de kills

func _ready():
	original_position = global_position  # Armazena a posição original no início
	respawn_timer = respawn_time  # Inicia o timer de respawn no início

func _physics_process(delta):
	if dead:
		handle_respawn(delta)
		return

	if player == null:
		return

	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	velocity = dir * move_speed
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
	move_speed += 0.8
	# Incrementa o contador de kills
	kills += 1

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
