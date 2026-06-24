extends CharacterBody2D

const SPEED = 80.0
const GRAVITY = 800.0

var direction = 1
var pode_dar_dano := true

@onready var floor_right: RayCast2D = $FloorRight
@onready var floor_left: RayCast2D = $FloorLeft
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $killzone

func _ready():
	killzone.body_entered.connect(_on_killzone_body_entered)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if not floor_left.is_colliding():
		direction = 1
	if not floor_right.is_colliding():
		direction = -1

	velocity.x = direction * SPEED
	anim.flip_h = direction > 0
	anim.play("walk")

	move_and_slide()

# =========================
# DANO CONTROLADO
# =========================

func _on_killzone_body_entered(body: Node2D) -> void:
	if not pode_dar_dano:
		return

	if body.has_method("tomar_dano"):
		pode_dar_dano = false
		body.tomar_dano(1)

		await get_tree().create_timer(0.5).timeout
		pode_dar_dano = true
