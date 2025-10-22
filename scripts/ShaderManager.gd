extends Node2D

# Pixelate effect settings
var pixelate_val = 0.5
var pixelate_start = 0.5
var pixelate_end = 4.0
var pixelate_dir = 1
var pixelate_anim_time = 0.0
var pixelate_anim_speed = 0.05  # Each step duration in seconds (SNES-style timing)

# Reference to the sprite with pixelate shader
@onready var pixelate_sprite = $Sprites/Chocobo4

func _ready():
	pixelate_anim_time = pixelate_anim_speed

func _process(delta):
	process_pixelate_effect(delta)

func process_pixelate_effect(delta):
	pixelate_anim_time -= delta
	
	if pixelate_anim_time <= 0.0:
		pixelate_anim_time += pixelate_anim_speed  # Preserve overshoot for accurate timing
		pixelate_val += 0.5 * pixelate_dir
		
		if pixelate_val == pixelate_end:
			pixelate_dir = -1
		
		if pixelate_val == pixelate_start:
			pixelate_anim_time = pixelate_anim_speed * 5  # Reset to pause duration at start
			pixelate_dir = 1
	
	# Update the shader parameter
	if pixelate_sprite and pixelate_sprite.material:
		pixelate_sprite.material.set_shader_parameter("pixelation", pixelate_val)

