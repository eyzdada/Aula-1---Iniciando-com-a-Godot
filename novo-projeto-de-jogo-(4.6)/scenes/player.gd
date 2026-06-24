extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hud: CanvasLayer = $"../HUD"
@onready var posicao_inicial: Marker2D = $"../PosicaoInicial"

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func die() -> void:
	tomar_dano(1)

func tomar_dano(dano: int) -> void:
	GameManager.vidas -= dano

	if GameManager.vidas <= 0:
		print("Game Over")
		GameManager.resetar_jogo() 
		get_tree().reload_current_scene()
	else:
		respawn()

	if hud and hud.has_method("atualizar_vidas"):
		hud.atualizar_vidas()

func respawn() -> void:
	position = posicao_inicial.position
