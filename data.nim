import std/tables
import tiles/tile

let spritesheetID* = {
  "player": 0,
  "surface_ground": 1,
  "amogus": 2
}.toTable

var surface_tilemap* = @[Tile(
  coords: [0, 0],
  spritesheet: "surface_ground",
  sprite: 0
)]