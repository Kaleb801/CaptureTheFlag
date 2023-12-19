extends TileMap

var stage
var tilemapCollect
var player
var doorPos=[
]
var doorPlayer=[
]
var tile_hp = [
]
var max_tile_hp = [
]
var pos_array = [
	
]
func _ready():
	if PlayerInventory.player=="player1":
		player=get_tree().get_current_scene().get_node("/root/stage/player1")
	else:
		player=get_tree().get_current_scene().get_node("/root/stage/player2")
	stage= get_tree().get_current_scene().get_node("/root/stage")
	tilemapCollect = get_tree().get_current_scene().get_node("/root/stage/tile_map/tile_map_collect")
	var tilemapbg = get_tree().get_current_scene().get_node("/root/stage/tile_map_bg")
	var i = -270
	var j = 0
	var hp=0
	var hpmax =0
	while i<=270:
		while j<=136:
			var tile = get_cellv(Vector2(i,j))
			if tile==0:
				tilemapbg.set_cellv(Vector2(i,j),1)
				hp=1
				hpmax=hp
			if tile==1:
				tilemapbg.set_cellv(Vector2(i,j),1)
				hp=2
				hpmax=hp
			if tile==4:
				tilemapbg.set_cellv(Vector2(i,j),1)
				hp=3
				hpmax=hp
			if tile==5:
				tilemapbg.set_cellv(Vector2(i,j),1)
				hp=4
				hpmax=hp
			if tile==6:
				tilemapbg.set_cellv(Vector2(i,j),1)
				hp=5
				hpmax=hp
			if tile==7:
				tilemapbg.set_cellv(Vector2(i,j),1)
				hp=6
				hpmax=hp
			if tile==8:
				tilemapbg.set_cellv(Vector2(i,j),1)
				hp=7
				hpmax=hp
			if tile==36:
				tilemapbg.set_cellv(Vector2(i,j),1)
				hp=1
				hpmax=hp
			pos_array.append(Vector2(i,j))
			max_tile_hp.append(hpmax)
			tile_hp.append(hp)
			j+=1
		j=0
		i+=1
	
func openDoor(pos,player):
	var k=0
	for tile in doorPos:
		if tile==pos and doorPlayer[k]==player:
			return true
		k+=1
	return false
	
sync func put_block(block,pos,player):
	var i=0
	for tile in pos_array:
		if tile==pos:
			if block=="Dirt":
				max_tile_hp[i]=1
				tile_hp[i]=max_tile_hp[i]
			elif block=="Stone":
				max_tile_hp[i]=2
				tile_hp[i]=max_tile_hp[i]
			elif block=="Sand":
				max_tile_hp[i]=1
				tile_hp[i]=max_tile_hp[i]
			elif block=="Wood Wall":
				max_tile_hp[i]=6
				tile_hp[i]=max_tile_hp[i]
			elif block=="Wood Door":
				doorPlayer.append(player)
				doorPos.append(pos)
				max_tile_hp[i]=6
				tile_hp[i]=max_tile_hp[i]
			elif block=="Birch Wall":
				max_tile_hp[i]=8
				tile_hp[i]=max_tile_hp[i]
			elif block=="Birch Door":
				doorPlayer.append(player)
				doorPos.append(pos)
				max_tile_hp[i]=8
				tile_hp[i]=max_tile_hp[i]
			elif block=="Plum Wall":
				max_tile_hp[i]=10
				tile_hp[i]=max_tile_hp[i]
			elif block=="Plum Door":
				doorPlayer.append(player)
				doorPos.append(pos)
				max_tile_hp[i]=10
				tile_hp[i]=max_tile_hp[i]
			elif block=="Eucalyptus Wall":
				max_tile_hp[i]=12
				tile_hp[i]=max_tile_hp[i]
			elif block=="Eucalyptus Door":
				doorPlayer.append(player)
				doorPos.append(pos)
				max_tile_hp[i]=12
				tile_hp[i]=max_tile_hp[i]
			elif block=="Brazier Wall":
				max_tile_hp[i]=14
				tile_hp[i]=max_tile_hp[i]
			elif block=="Brazier Door":
				doorPlayer.append(player)
				doorPos.append(pos)
				max_tile_hp[i]=14
				tile_hp[i]=max_tile_hp[i]
			else:
				max_tile_hp[i]=-11
				tile_hp[i]=max_tile_hp[i]
		i+=1
	var audioStream=preload("res://Sounds/click_001.wav")
	$Audio.set_stream(audioStream)
	$Audio.play()

func maintain_hp(hp,pos):
	var i = 0
	for tile in pos_array:
		max_tile_hp[i]=hp
		tile_hp[i]=max_tile_hp[i]	

sync func delete_furniture(pos):
	if get_cellv(pos)==30 or get_cellv(Vector2(pos.x-1,pos.y))==30 or get_cellv(Vector2(pos.x,pos.y-1))==30 or get_cellv(Vector2(pos.x-1,pos.y-1))==30:
		stage.rpc("update_stage_terrain","delete_table", pos)
		tilemapCollect.set_cellv(pos,-1)
	if get_cellv(pos)==30 or get_cellv(Vector2(pos.x-1,pos.y))==34 or get_cellv(Vector2(pos.x,pos.y-1))==34 or get_cellv(Vector2(pos.x-1,pos.y-1))==34:
		stage.rpc("update_stage_terrain","delete_chest", pos)
		tilemapCollect.set_cellv(pos,-1)
	if get_cellv(pos)==31 or get_cellv(Vector2(pos.x+1,pos.y))==31 or get_cellv(Vector2(pos.x,pos.y))==31 or get_cellv(Vector2(pos.x,pos.y-1))==31:
		stage.rpc("update_stage_terrain","delete_furnace", pos)
		tilemapCollect.set_cellv(pos,-1)
	if get_cellv(pos)==31 or get_cellv(Vector2(pos.x-1,pos.y))==32 or get_cellv(Vector2(pos.x-2,pos.y))==32 or get_cellv(Vector2(pos.x-3,pos.y))==32  or get_cellv(Vector2(pos.x-4,pos.y))==32:
		if get_cellv(Vector2(pos.x+2,pos.y-1))==-1 and get_cellv(Vector2(pos.x+1,pos.y-1))==-1 and get_cellv(Vector2(pos.x,pos.y-1))==-1 and get_cellv(Vector2(pos.x-1,pos.y-1))==-1 and get_cellv(Vector2(pos.x-2,pos.y-1))==-1:
			stage.rpc("update_stage_terrain","delete_vase", pos)
			tilemapCollect.set_cellv(pos,-1)
	

func set_cell_hp(force,pos,player):
	var i = 0
	for tile in pos_array:
		if tile==pos and get_cellv(pos)!=-1 and get_cellv(pos)!=14 and get_cellv(pos)!=15 and get_cellv(pos)!=16 and get_cellv(pos)!=17:
			tile_hp[i]-=force
			if tile_hp[i]>max_tile_hp[i]*0.75:
				tilemapCollect.set_cellv(pos,0)
			elif tile_hp[i]>max_tile_hp[i]*0.50:
				tilemapCollect.set_cellv(pos,1)
			elif tile_hp[i]>max_tile_hp[i]*0.25:
				tilemapCollect.set_cellv(pos,2)
			elif tile_hp[i]==0:
				tilemapCollect.set_cellv(pos,3)
			elif tile_hp[i]>-10 and tile_hp[i]<0:
				if get_cellv(pos)==0:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_dirt", pos)
					tilemapCollect.set_cellv(pos,-1)
					var audioStream=preload("res://Sounds/amber.wav")
					$Audio.set_stream(audioStream)
					$Audio.play()
					stage.rpc("set_exp",0.1,player)
				if get_cellv(pos)==1:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_stone", pos)
					tilemapCollect.set_cellv(pos,-1)
					var audioStream=preload("res://Sounds/given_item.wav")
					$Audio.set_stream(audioStream)
					$Audio.play()
					stage.rpc("set_exp",0.2,player)
				if get_cellv(pos)==4:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_copper", pos)
					tilemapCollect.set_cellv(pos,-1)
					var audioStream=preload("res://Sounds/given_item.wav")
					$Audio.set_stream(audioStream)
					$Audio.play()
					stage.rpc("set_exp",0.4,player)
				if get_cellv(pos)==5:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_iron", pos)
					tilemapCollect.set_cellv(pos,-1)
					var audioStream=preload("res://Sounds/given_item.wav")
					$Audio.set_stream(audioStream)
					$Audio.play()
					stage.rpc("set_exp",0.6,player)
				if get_cellv(pos)==6:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_mythril", pos)
					tilemapCollect.set_cellv(pos,-1)
					var audioStream=preload("res://Sounds/given_item.wav")
					$Audio.set_stream(audioStream)
					$Audio.play()
					stage.rpc("set_exp",0.8,player)
				if get_cellv(pos)==7:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_adamant", pos)
					tilemapCollect.set_cellv(pos,-1)
					var audioStream=preload("res://Sounds/given_item.wav")
					$Audio.set_stream(audioStream)
					$Audio.play()
					stage.rpc("set_exp",1,player)
				if get_cellv(pos)==8:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_dragonite", pos)
					tilemapCollect.set_cellv(pos,-1)
					var audioStream=preload("res://Sounds/given_item.wav")
					$Audio.set_stream(audioStream)
					$Audio.play()
					stage.rpc("set_exp",1.2,player)
				if get_cellv(pos)==2:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_wood_wall", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==10:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_birch_wall", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==11:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_plum_wall", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==12:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_eucalyptus_wall", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==13:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_brazier_wall", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==17:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_wood_door", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==20:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_birch_door", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==22:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_plum_door", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==24:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_eucalyptus_door", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==26:
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_brazier_door", pos)
					tilemapCollect.set_cellv(pos,-1)
				if get_cellv(pos)==36:
					var audioStream=preload("res://Sounds/amber.wav")
					$Audio.set_stream(audioStream)
					$Audio.play()
					tile_hp[i]=0
					max_tile_hp[i]=0
					stage.rpc("update_stage_terrain","delete_sand", pos)
					tilemapCollect.set_cellv(pos,-1)
					stage.rpc("set_exp",0.1,player)
		i+=1
