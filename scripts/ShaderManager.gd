extends Node2D

# Pixelate effect settings
var pixelate_val = 0.5
var pixelate_start = 0.5
var pixelate_end = 4.0
var pixelate_dir = 1
var pixelate_anim_time = 0.0
var pixelate_anim_speed = 0.05

# Color cycle settings
var cycle_anim_time = 0.0
var cycle_anim_speed = 0.07  # Adjusted from original 0.06 to better match perceived speed
var cycle1_num = 1
var cycle1_dir = -1
var cycle2_num = 2
var cycle2_dir = 1
var cycle3_num = 3
var cycle3_dir = 1
var cycle4_num = 4
var cycle4_dir = 1
var cycle5_num = 5
var cycle5_dir = 1

# Color definitions from AnimParams
var heal_colors = [
	Vector4(1.0, 1.0, 1.0, 1.0),
	Vector4(0.25, 0.97, 0.97, 1.0),
	Vector4(0.0, 0.75, 0.97, 1.0),
	Vector4(0.0, 0.44, 0.91, 1.0),
	Vector4(0.0, 0.155, 0.91, 1.0)
]

var fire_colors = [
	Vector4(1.0, 1.0, 1.0, 1.0),
	Vector4(0.97, 0.91, 0.0, 1.0),
	Vector4(0.97, 0.66, 0.0, 1.0),
	Vector4(0.97, 0.41, 0.0, 1.0),
	Vector4(0.91, 0.03, 0.03, 1.0)
]

var alt_heal_colors = [
	Vector4(1.0, 1.0, 1.0, 1.0),
	Vector4(0.0, 248.0/255.0, 0.0, 1.0),
	Vector4(0.0, 192.0/255.0, 0.0, 1.0),
	Vector4(0.0, 160.0/255.0, 0.0, 1.0),
	Vector4(0.0, 88.0/255.0, 0.0, 1.0)
]

var shadow_colors = [
	Vector4(1.0, 1.0, 1.0, 1.0),
	Vector4(0.75, 0.75, 0.75, 1.0),
	Vector4(0.5, 0.5, 0.5, 1.0),
	Vector4(0.25, 0.25, 0.25, 1.0),
	Vector4(0.0, 0.0, 0.0, 1.0)
]

var white_outline_colors = [
	Vector4(0.0, 0.0, 0.0, 1.0),
	Vector4(0.25, 0.25, 0.25, 1.0),
	Vector4(0.5, 0.5, 0.5, 1.0),
	Vector4(0.75, 0.75, 0.75, 1.0),
	Vector4(1.0, 1.0, 1.0, 1.0)
]

var blue_outline_colors = [
	Vector4(0.0, 0.0, 0.0, 1.0),
	Vector4(0.0, 0.155, 0.91, 1.0),
	Vector4(0.0, 0.44, 0.91, 1.0),
	Vector4(0.0, 0.75, 0.97, 1.0),
	Vector4(0.25, 0.97, 0.97, 1.0)
]

var poison_colors = [
	Vector4(0.64, 0.44, 0.854, 1.0),
	Vector4(0.64, 0.44, 0.854, 1.0),
	Vector4(0.64, 0.44, 0.854, 1.0),
	Vector4(0.64, 0.44, 0.854, 1.0),
	Vector4(0.4, 0.0, 0.0, 1.0)
]

var alt_poison_colors = [
	Vector4(0.0, 0.75, 0.0, 1.0),
	Vector4(0.0, 0.75, 0.0, 1.0),
	Vector4(0.0, 0.75, 0.0, 1.0),
	Vector4(0.0, 0.75, 0.0, 1.0),
	Vector4(0.4, 0.0, 0.0, 1.0)
]

# Outline flash settings
var outline_anim_time = 0.0
var outline_anim_speed = 0.08
var outline_cycle_num = 1
var outline_cycle_dir = -1

# Poison settings
var poison_anim_time = 0.0
var poison_anim_speed = 0.15
var poison_cycle_num = 1
var poison_cycle_dir = -1

# References to sprites
@onready var pixelate_sprite = $Sprites/Chocobo4
@onready var heal_sprite = $Sprites/Chocobo6
@onready var fire_sprite = $Sprites/Chocobo7
@onready var poison_sprite = $Sprites/Chocobo8
@onready var alt_heal_sprite = $Sprites/Chocobo11
@onready var shadow_sprite = $Sprites/Chocobo12
@onready var alt_poison_sprite = $Sprites/Chocobo13
@onready var barrier_sprite = $Sprites/Chocobo9
@onready var shield_sprite = $Sprites/Chocobo14

func _ready():
	pixelate_anim_time = pixelate_anim_speed
	cycle_anim_time = cycle_anim_speed
	outline_anim_time = outline_anim_speed
	poison_anim_time = poison_anim_speed

func _process(delta):
	process_pixelate_effect(delta)
	process_color_cycle_effects(delta)
	process_outline_flash_effects(delta)
	process_poison_effects(delta)

func process_pixelate_effect(delta):
	pixelate_anim_time -= delta
	
	if pixelate_anim_time <= 0.0:
		pixelate_anim_time += pixelate_anim_speed
		pixelate_val += 0.5 * pixelate_dir
		
		if pixelate_val == pixelate_end:
			pixelate_dir = -1
		
		if pixelate_val == pixelate_start:
			pixelate_anim_time = pixelate_anim_speed * 5
			pixelate_dir = 1
	
	if pixelate_sprite and pixelate_sprite.material:
		pixelate_sprite.material.set_shader_parameter("pixelation", pixelate_val)

func process_color_cycle_effects(delta):
	cycle_anim_time -= delta
	
	if cycle_anim_time <= 0.0:
		cycle_anim_time = cycle_anim_speed  # Match original timing behavior
		
		# Update cycle indices
		if cycle1_num == 1 or cycle1_num == 5:
			cycle1_dir *= -1
		cycle1_num += cycle1_dir
		
		if cycle2_num == 1 or cycle2_num == 5:
			cycle2_dir *= -1
		cycle2_num += cycle2_dir
		
		if cycle3_num == 1 or cycle3_num == 5:
			cycle3_dir *= -1
		cycle3_num += cycle3_dir
		
		if cycle4_num == 1 or cycle4_num == 5:
			cycle4_dir *= -1
		cycle4_num += cycle4_dir
		
		if cycle5_num == 1 or cycle5_num == 5:
			cycle5_dir *= -1
		cycle5_num += cycle5_dir
	
	# Update heal effect
	if heal_sprite and heal_sprite.material:
		heal_sprite.material.set_shader_parameter("color1", heal_colors[cycle1_num - 1])
		heal_sprite.material.set_shader_parameter("color2", heal_colors[cycle2_num - 1])
		heal_sprite.material.set_shader_parameter("color3", heal_colors[cycle3_num - 1])
		heal_sprite.material.set_shader_parameter("color4", heal_colors[cycle4_num - 1])
		heal_sprite.material.set_shader_parameter("color5", heal_colors[cycle5_num - 1])
	
	# Update fire effect
	if fire_sprite and fire_sprite.material:
		fire_sprite.material.set_shader_parameter("color1", fire_colors[cycle1_num - 1])
		fire_sprite.material.set_shader_parameter("color2", fire_colors[cycle2_num - 1])
		fire_sprite.material.set_shader_parameter("color3", fire_colors[cycle3_num - 1])
		fire_sprite.material.set_shader_parameter("color4", fire_colors[cycle4_num - 1])
		fire_sprite.material.set_shader_parameter("color5", fire_colors[cycle5_num - 1])
	
	# Update alt heal effect
	if alt_heal_sprite and alt_heal_sprite.material:
		alt_heal_sprite.material.set_shader_parameter("color1", alt_heal_colors[cycle1_num - 1])
		alt_heal_sprite.material.set_shader_parameter("color2", alt_heal_colors[cycle2_num - 1])
		alt_heal_sprite.material.set_shader_parameter("color3", alt_heal_colors[cycle3_num - 1])
		alt_heal_sprite.material.set_shader_parameter("color4", alt_heal_colors[cycle4_num - 1])
		alt_heal_sprite.material.set_shader_parameter("color5", alt_heal_colors[cycle5_num - 1])
	
	# Update shadow effect
	if shadow_sprite and shadow_sprite.material:
		shadow_sprite.material.set_shader_parameter("color1", shadow_colors[cycle1_num - 1])
		shadow_sprite.material.set_shader_parameter("color2", shadow_colors[cycle2_num - 1])
		shadow_sprite.material.set_shader_parameter("color3", shadow_colors[cycle3_num - 1])
		shadow_sprite.material.set_shader_parameter("color4", shadow_colors[cycle4_num - 1])
		shadow_sprite.material.set_shader_parameter("color5", shadow_colors[cycle5_num - 1])

func process_outline_flash_effects(delta):
	outline_anim_time -= delta
	
	if outline_anim_time <= 0.0:
		outline_anim_time = outline_anim_speed
		
		# Update outline cycle (separate from color cycle)
		if outline_cycle_num == 1 or outline_cycle_num == 5:
			outline_cycle_dir *= -1
		outline_cycle_num += outline_cycle_dir
	
	# Update barrier effect (white outline)
	if barrier_sprite and barrier_sprite.material:
		barrier_sprite.material.set_shader_parameter("color", white_outline_colors[outline_cycle_num - 1])
	
	# Update shield effect (blue outline)
	if shield_sprite and shield_sprite.material:
		shield_sprite.material.set_shader_parameter("color", blue_outline_colors[outline_cycle_num - 1])

func process_poison_effects(delta):
	poison_anim_time -= delta
	
	if poison_anim_time <= 0.0:
		poison_anim_time = poison_anim_speed
		
		# Update poison cycle
		if poison_cycle_num == 1 or poison_cycle_num == 5:
			poison_cycle_dir *= -1
		poison_cycle_num += poison_cycle_dir
	
	# Update poison effect
	if poison_sprite and poison_sprite.material:
		poison_sprite.material.set_shader_parameter("color", poison_colors[poison_cycle_num - 1])
	
	# Update alt poison effect
	if alt_poison_sprite and alt_poison_sprite.material:
		alt_poison_sprite.material.set_shader_parameter("color", alt_poison_colors[poison_cycle_num - 1])
