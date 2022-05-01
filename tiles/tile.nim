import ../devtools

type
  TileType* = enum
    # Objects
    CHIPPYS_COUCH
    TORCH

    # Surface floor
    GRASS_FLOOR

  TileAnimation* = object
    spf*: float32
    frames*: array[3, int]
    current_frame*: int
    time_counter*: float32

  Tile* = object
    tile*: TileType
    coords*: array[2, int]
    spritesheet*: string
    sprite*: int
    animated*: bool
    animation*: TileAnimation

proc init*(tile: Tile): Tile =
  var tile = tile

  tile.coords[0] = round_to_int(tile.coords[0], 12)
  tile.coords[1] = round_to_int(tile.coords[1], 12)

  return tile