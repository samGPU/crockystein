extends CanvasLayer

var ammo = 0
var current_weapon = "knife"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if current_weapon == "knife":
			$AnimatedSprite2D.play("stab")
		elif current_weapon == "gun":
			if ammo > 0:
				$AnimatedSprite2D.play("shoot")
				ammo -= 1

func _on_AnimatedSprite2D_animation_finished():
	if current_weapon == "knife":
		$AnimatedSprite2D.play("knife_idle")
	elif current_weapon == "gun":
		$AnimatedSprite2D.play("gun_idle")
