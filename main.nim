import std/tables
import nico
import entities/player
import data
import tiles/tile
import tiles/grass_floor

var the_player = Player(
  position: [0, 0]
)

var camera_offset = [0, 0]

proc gameInit() =
  #setPalette(loadPalettePico8())
  hideMouse()

  # Load Sprites/Fonts
  loadFont(0, "fonts/font.png")

  loadSpritesheet(spritesheetID["player"], "entities/player.png", 14, 14) 
  loadSpritesheet(spritesheetID["amogus"], "amogus.png", 8, 8) 
  
  loadSpritesheet(spritesheetID["surface_ground"], "tiles/surface_ground.png", 12, 12)

  # Create world
  # TODO make actual world generation
  var amogus = [0, 0]
  for num in -1000..1000:
    echo num
    var surface_tile = grass_floor([amogus[0] * 10, amogus[1] * 10])
    surface_tile = surface_tile.init()
    surface_tilemap.add(surface_tile)

    if amogus[0] > 100:
      amogus[0] = 0
      amogus[1] += 1
    else:
      amogus[0] += 1

proc gameUpdate(dt: float32) =
  the_player = the_player.update(dt)
  #echo the_player.position

  if key(K_left):
    camera_offset[0] -= 1
  if key(K_right):
    camera_offset[0] += 1
  if key(K_up):
    camera_offset[1] -= 1
  if key(K_down):
    camera_offset[1] += 1
  
  if keyp(K_space):
    camera_offset = [0, 0]

  if key(K_l):
    var tile = grass_floor(the_player.position)
    tile = tile.init()
    surface_tilemap.add(tile)
  
  #echo "\n------------------------------------\n\n", raft_tilemap

proc gameDraw() =
  cls()

  # Draw background
  setCamera(0, 0)

  setColor(12)
  boxfill(0, 0, screenWidth, screenHeight)

  setSpritesheet(spritesheetID["amogus"])
  spr(0, 0, 0)

  # Draw world
  setCamera(
    (the_player.position[0] - toInt(screenWidth / 2) + 7) + camera_offset[0],
    (the_player.position[1] - toInt(screenHeight / 2) + 7) + camera_offset[1]
  )

  for tile in surface_tilemap:
    #if tile.coords[0] > 0 and tile.coords[1] > 0 and tile.coords[0] < screenWidth and tile.coords[1] < screenHeight:
    if 
      tile.coords[0] > (0 + the_player.position[0] - toInt((screenWidth / 2)) - 10) and
      tile.coords[1] > (0 + the_player.position[1] - toInt((screenHeight / 2)) - 10) and
      tile.coords[0] < (toInt(screenWidth / 2) + the_player.position[0] + 10) and
      tile.coords[1] < (toInt(screenHeight / 2) + the_player.position[1] + 10)
      :
      setSpritesheet(spritesheetID[tile.spritesheet])
      spr(tile.sprite, tile.coords[0], tile.coords[1])

  the_player.draw()

  # Draw UI
  setCamera(0, 0)

  setColor(10)
  circ(mouse()[0], mouse()[1], 2)

nico.init("mastrio", "legend_of_terraria")

#fixedSize(true)
#integerScale(true)

nico.createWindow("The Legend of Terraria", 250, 128, 4, false)
nico.run(gameInit, gameUpdate, gameDraw)
