extends ColorRect

var pos
var newpos
var tilemap
var tilemap2
var tilemapbg
var torch1
var torch2
var time = 0
const MORNING_COLOR = Color(0, 0.007, 0.08, 0.7) # Amarelo claro com transparência
const DAY_COLOR = Color(0, 0, 0, 0)    # Branco totalmente transparente (sem cor)
const EVENING_COLOR = Color(0.7, 0.4, 0.4, 0.3) # Laranja claro com transparência
const NIGHT_COLOR = Color(0, 0.007, 0.08, 0.7)
const DAY_NIGHT_CYCLE_DURATION = 300

# Função para atualizar a cor e intensidade do ColorRect com base no tempo
func update_time_of_day():
	time+=0.1
	# Calcula a porcentagem do ciclo de dia e noite já decorrido
	var cycle_progress = time / DAY_NIGHT_CYCLE_DURATION
	
	# Define as cores intermediárias com base no progresso do ciclo
	var color_start
	var color_end
	
	if time>=DAY_NIGHT_CYCLE_DURATION:
		time=0
		color_start = MORNING_COLOR
		color_end = DAY_COLOR
	elif cycle_progress < 0.25:
		# Manhã (começa em MORNING_COLOR e vai até DAY_COLOR)
		color_start = MORNING_COLOR
		color_end = DAY_COLOR
	elif cycle_progress < 0.5:
		# Dia (começa em DAY_COLOR e vai até EVENING_COLOR)
		color_start = DAY_COLOR
		color_end = EVENING_COLOR
	elif cycle_progress < 0.75:
		# Tarde (começa em EVENING_COLOR e vai até NIGHT_COLOR)
		color_start = EVENING_COLOR
		color_end = NIGHT_COLOR
	else:
		# Noite (começa em NIGHT_COLOR e vai até MORNING_COLOR)
		color_start = NIGHT_COLOR
		color_end = MORNING_COLOR
	
	# Calcula a cor atual interpolando entre as cores de início e fim
	var current_color = color_start.linear_interpolate(color_end, (cycle_progress - floor(cycle_progress / 0.25) * 0.25) * 4.0)
	
	# Define a cor do ColorRect
	self.color = current_color

func _ready():
	tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	tilemap2 = get_tree().get_current_scene().get_node("/root/stage/Light")
	tilemapbg = get_tree().get_current_scene().get_node("/root/stage/tile_map_bg")
	$Timer.start()

func set_area_torch(i, j):
	for k in range(-3, 4):
		for l in range(-3, 4):
			tilemap2.set_cellv(Vector2(i + k, j + l), 3)

func _on_Timer_timeout():
	update_time_of_day()
	if PlayerInventory.player == "player1":
		pos = tilemap.world_to_map(get_tree().get_current_scene().get_node("/root/stage/camera1").position)
		var torch1 = get_tree().get_current_scene().get_node("/root/stage/player1/Torch")
		var torch2 = get_tree().get_current_scene().get_node("/root/stage/player2/Torch")
		light(torch1,torch2)
	else:
		pos = tilemap.world_to_map(get_tree().get_current_scene().get_node("/root/stage/camera2").position)
		var torch2 = get_tree().get_current_scene().get_node("/root/stage/player1/Torch")
		var torch1 = get_tree().get_current_scene().get_node("/root/stage/player2/Torch")
		light(torch1,torch2)
	$Timer.start()

func intensity(torch,i,j):
	var lightPos = torch.global_position
	var blockPos = tilemap.map_to_world(Vector2(i, j))
	# Calculate distance and intensity based on light propagation
	var maxIntensity = 1
	var textureSize = Vector2(torch.texture.get_width(), torch.texture.get_height()) * torch.texture_scale
	var maxDistance = sqrt(textureSize.x * textureSize.x + textureSize.y * textureSize.y)
	var distance = lightPos.distance_to(blockPos)
	var intensity = (maxDistance - distance) / maxDistance
	intensity = clamp(intensity, 0, 1)  # Ensure intensity is within the range [0, 1]
	if torch.visible==false:
		return 0
	return intensity

func light(torch,torch2):
	for i in range(pos.x - 19, pos.x + 20):
		for j in range(pos.y - 19, pos.y + 20):
			var lightAbove = tilemap2.get_cellv(Vector2(i, j - 1))
			var lightBelow = tilemap2.get_cellv(Vector2(i, j + 1))
			var lightleft = tilemap2.get_cellv(Vector2(i - 1, j))
			var lightright = tilemap2.get_cellv(Vector2(i + 1, j))
			var blockPos = tilemap.map_to_world(Vector2(i, j))
			var bgabove = tilemapbg.get_cellv(Vector2(i, j - 5))
			var block = tilemap.get_cellv(Vector2(i, j))
			var intensity = intensity(torch,i,j)
			var intensity2 = intensity(torch2,i,j)

			if  tilemap2.get_cellv(Vector2(i, j)) != 3:
				if bgabove != -1 and tilemapbg.get_cellv(Vector2(i, j)) != -1 and intensity <= 0 or intensity2 <= 0 and torch.visible == false and (lightAbove != 2 or lightAbove != 3 or lightleft != 2 or lightleft != 3 or lightright != 2 or lightright != 3 or lightBelow != 2 or lightBelow != 3):
					tilemap2.set_cellv(Vector2(i, j), 0)
				elif intensity > 0.3 or intensity2 > 0.3 or lightAbove == 2 or lightAbove == 3 or lightleft == 2 or lightleft == 3 or lightright == 2 or lightright == 3 or lightBelow == 2 or lightBelow == 3:
					if intensity > 0.3:  # Adjust this threshold as needed
						tilemap2.set_cellv(Vector2(i, j), 2)
					else:
						tilemap2.set_cellv(Vector2(i, j), 0)  # Set the tile to a black version when intensity is low
				else:
					tilemap2.set_cellv(Vector2(i, j), 0)  # Set the tile to a black version when not affected by light

								
				if block != -1:
					if block == 18:  # Check for special tiles (e.g., torches, etc.)
						set_area_torch(i, j)
					elif block == -1 or intensity >= 0.4 or intensity2 >= 0.4 or tilemap.get_cellv(Vector2(i, j))==14 or tilemap.get_cellv(Vector2(i, j))==15 or tilemapbg.get_cellv(Vector2(i, j))==0:  # Check if the block above is empty or the intensity is high enough to illuminate
						if bgabove == -1 or tilemap.get_cellv(Vector2(i, j))==14 or tilemap.get_cellv(Vector2(i, j))==15 or tilemapbg.get_cellv(Vector2(i, j))==0:
							tilemap2.set_cellv(Vector2(i, j), 2)  # Set the current block to normal luminosity (2)
					elif lightAbove == 2 or lightAbove == 3 or lightleft == 2 or  lightleft == 3 or lightright == 2 or lightright == 3 or lightBelow == 2 or lightBelow == 3:
						tilemap2.set_cellv(Vector2(i, j), 1)  # Set the current block to a grayed version (1)
					else:
						tilemap2.set_cellv(Vector2(i, j), 0)  # Set the current block to a black version (0)
				# If the block is broken and there is no light, transform it into a normal luminosity block
				elif bgabove == -1:
					tilemap2.set_cellv(Vector2(i, j), 2)
		
