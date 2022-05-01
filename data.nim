import std/tables
import tiles/tile

let spritesheetID* = {
  "player": 0,
  "surface_ground": 1,
  "amogus": 2,
  "objects": 3
}.toTable

# Tilemaps
var surface_floor_tilemap* = @[Tile(
  tile: TileType.GRASS_FLOOR,
  coords: [0, 0],
  spritesheet: "surface_ground",
  sprite: 0,
  animated: false
)]

var surface_wall_tilemap* = @[Tile(
  tile: TileType.CHIPPYS_COUCH,
  coords: [0, 0],
  spritesheet: "objects",
  sprite: 5,
  animated: true,
  animation: TileAnimation(
    spf: 0.1,
    frames: [5, 6, 7],
    current_frame: 0,
    time_counter: 0.0
  )
)]