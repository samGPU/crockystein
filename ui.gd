extends CanvasLayer

var pistol_ammo = 10
var rifle_ammo = 30000
var chain_ammo = 20000
var current_weapon = "knife" # Default weapon

var is_mouse_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if current_weapon == "knife" and not is_mouse_pressed:
			$AnimatedSprite2D.play("knife_stab")
		elif current_weapon == "pistol" and not is_mouse_pressed:
			if pistol_ammo > 0:
				$AnimatedSprite2D.play("pistol_shoot")
				pistol_ammo -= 1
			print("Pistol ammo remaining: ", pistol_ammo)
		elif current_weapon == "rifle":
			if rifle_ammo > 0:
				$AnimatedSprite2D.play("rifle_shoot")
				rifle_ammo -= 1
			print("Rifle ammo remaining: ", rifle_ammo)
		elif current_weapon == "chain":
			if chain_ammo > 0:
				$AnimatedSprite2D.play("chain_shoot")
				chain_ammo -= 1
			print("Chain ammo remaining: ", chain_ammo)
		is_mouse_pressed = true
	else:
		is_mouse_pressed = false

func _on_AnimatedSprite2D_animation_finished():
	if current_weapon == "knife":
		$AnimatedSprite2D.play("knife_idle")
	elif current_weapon == "pistol":
		$AnimatedSprite2D.play("pistol_idle")
	elif current_weapon == "rifle":
		$AnimatedSprite2D.play("rifle_idle")
	elif current_weapon == "chain":
		$AnimatedSprite2D.play("chain_idle")
