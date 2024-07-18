extends TileMap

@export var fill_tile_name: String = "cielo"  # Nombre del tile que quieres usar para rellenar
@export var start_position: Vector2i = Vector2i(0, 0)  # Posición de inicio para el relleno
@export var area_size: Vector2i = Vector2i(100, 100)  # Tamaño del área a rellenar

func _ready():
	fill_area_with_tile(start_position, area_size, fill_tile_name)

func fill_area_with_tile(start_pos: Vector2i, size: Vector2i, tile_name: String):
	var ts = tile_set  # Obtener el TileSet asignado al TileMap
	if ts == null:
		print("TileSet no asignado al TileMap")
		return
	
	var tile_id = get_tile_id_by_name(ts, tile_name)
	if tile_id == -1:
		print("Tile not found: " + tile_name)
		return

	for x in range(start_pos.x, start_pos.x + size.x):
		for y in range(start_pos.y, start_pos.y + size.y):
			set_cell(0, Vector2i(x, y), tile_id)

func get_tile_id_by_name(ts: TileSet, tile_name: String) -> int:
	for tile_set_id in ts.tile_set_ids:
		var tile_data = ts.tile_get_data(tile_set_id)
		if tile_data.get_name() == tile_name:
			return tile_set_id
	return -1
