import std/random
import tile

proc grass_floor*(position: array[2, int]): Tile =
  randomize()

  return Tile(
    tile: TileType.GRASS_FLOOR,
    coords: position,
    spritesheet: "surface_ground",
    sprite: rand(1..6)
  )