import std/tables
import nico
import ../data

type
  Player* = object
    position*: array[2, int]

proc update*(player: Player, delta_time: float32): Player =
  var player = player

  if key(K_a):
    player.position[0] -= toInt(50 * delta_time)
  if key(K_d):
    player.position[0] += toInt(50 * delta_time)
  if key(K_w):
    player.position[1] -= toInt(50 * delta_time)
  if key(K_s):
    player.position[1] += toInt(50 * delta_time)

  return player

proc draw*(player: Player) =
  setSpritesheet(spritesheetID["player"])
  spr(1, player.position[0] - 1, player.position[1] + 11, 1, 1, true, true)
  spr(0, player.position[0], player.position[1])

  #setColor(5)
  #circ(player.position[0], player.position[1], 3)