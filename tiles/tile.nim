import ../devtools

type
  TileType* = enum
    # Objects
    CHIPPYS_COUCH

    # Surface floor
    GRASS_FLOOR

  Tile* = object
    tile*: TileType
    coords*: array[2, int]
    spritesheet*: string
    sprite*: int

proc init*(tile: Tile): Tile =
  var tile = tile

  tile.coords[0] = round_to_int(tile.coords[0], 12)
  tile.coords[1] = round_to_int(tile.coords[1], 12)

  return tile