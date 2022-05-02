import ../devtools

type
  TileType* = enum
    # Objects
    CHIPPYS_COUCH
    TORCH

    # Generic floor
    WOODEN_FLOOR

    # Generic walls
    WOODEN_WALL

    # Liquids
    WATER

    # Surface floor
    GRASS_FLOOR

  TileAnimation* = object
    spf*: float32
    frames*: seq[int] #array[3, int]
    current_frame*: int
    time_counter*: float32

  Tile* = object
    tile*: TileType
    coords*: array[2, int]
    spritesheet*: string
    sprite*: int
    animated*: bool
    animation*: TileAnimation

proc create_tile_pos*(position: array[2, int]): array[2, int] =
  var position = position
  position[0] = round_to_int(position[0] * 10, 12)
  position[1] = round_to_int(position[1] * 10, 12)
  return position