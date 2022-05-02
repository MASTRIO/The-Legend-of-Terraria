import std/tables
#import std/sequtils
import tiles/tile
import tiles/tile_list

let spritesheetID* = {
  "player": 0,
  "surface_ground": 1,
  "amogus": 2,
  "objects": 3,
  "cursor": 4,
  "generic_floor": 5,
  "generic_walls": 6,
  "liquids": 7
}.toTable

# Tilemaps
var surface_floor_tilemap* = @[grass_floor([0, 0])]

var surface_wall_tilemap* = @[
  torch([0, 0]),
  chippys_couch([1, 0]),
  torch([2, 0]),
  wooden_wall([3, 3]),
  wooden_wall([4, 3]),
  wooden_wall([5, 3])
]