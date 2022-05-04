import std/tables
import nico
import ../data

type
  Player* = object
    is_moving*: bool
    position*: array[2, int]
    velocity*: array[2, int]
    speed*: int

proc update*(player: Player): Player =
  var player = player
  player.is_moving = false

  if key(K_a):
    player.velocity[0] -= 1
    player.is_moving = true
  if key(K_d):
    player.velocity[0] += 1
    player.is_moving = true
  if key(K_w):
    player.velocity[1] -= 1
    player.is_moving = true
  if key(K_s):
    player.velocity[1] += 1
    player.is_moving = true

  return player

proc draw*(player: Player) =
  setSpritesheet(spritesheetID["player"])
  spr(0, player.position[0], player.position[1])

  #setColor(5)
  #circ(player.position[0], player.position[1], 3)

proc draw_shadow*(player: Player) =
  setSpritesheet(spritesheetID["player"])
  spr(1, player.position[0] - 1, player.position[1] + 11, 1, 1, true, true)