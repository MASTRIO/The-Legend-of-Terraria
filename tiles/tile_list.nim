import std/random
import tile

#* Objects
proc chippys_couch*(position: array[2, int]): Tile =
  return Tile(
    tile: TileType.CHIPPYS_COUCH,
    coords: position.create_tile_pos(),
    spritesheet: "objects",
    sprite: 0,
    animated: false
  )

proc torch*(position: array[2, int]): Tile =
  return Tile(
    tile: TileType.TORCH,
    coords: position.create_tile_pos(),
    spritesheet: "objects",
    sprite: 5,
    animated: true,
    animation: TileAnimation(
      spf: 0.1,
      frames: @[5, 6, 7],
      current_frame: 0,
      time_counter: 0.0
    )
  )

# Generic floor
proc wooden_floor*(position: array[2, int]): Tile =
  return Tile(
    tile: TileType.WOODEN_FLOOR,
    coords: position.create_tile_pos(),
    spritesheet: "generic_floor",
    sprite: 0,
    animated: false
  )

# Generic walls
proc wooden_wall*(position: array[2, int]): Tile =
  return Tile(
    tile: TileType.WOODEN_WALL,
    coords: position.create_tile_pos(),
    spritesheet: "generic_walls",
    sprite: 0,
    animated: false
  )

# Liquids
proc water*(position: array[2, int]): Tile =
  return Tile(
    tile: TileType.WATER,
    coords: position.create_tile_pos(),
    spritesheet: "liquids",
    sprite: 0,
    animated: true,
    animation: TileAnimation(
      spf: 0.7,
      frames: @[0, 1, 2, 1],
      current_frame: 0,
      time_counter: 0.0
    )
  )

# Surface floor
proc grass_floor*(position: array[2, int]): Tile =
  randomize()

  return Tile(
    tile: TileType.GRASS_FLOOR,
    coords: position.create_tile_pos(),
    spritesheet: "surface_ground",
    sprite: rand(1..6),
    animated: false
  )