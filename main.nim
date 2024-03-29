import std/tables
import nico
import entities/player
import data
import tiles/tile
import tiles/tile_list
import physics_engine
import devtools

var the_player = Player(
  position: [0, 0],
  velocity: [0, 0],
  speed: 50
)

var colour_count = 0
var camera_offset = [0, 0]

proc gameInit() =
  #setPalette(loadPaletteFromImage("palettes/colours.png"))
  hideMouse()

  # Load Sprites/Fonts
  loadFont(0, "fonts/font.png")

  loadSpritesheet(spritesheetID["cursor"], "cursor.png", 7, 7) 

  loadSpritesheet(spritesheetID["player"], "entities/player.png", 14, 14) 
  loadSpritesheet(spritesheetID["amogus"], "amogus.png", 8, 8) 
  
  loadSpritesheet(spritesheetID["objects"], "tiles/objects.png", 12, 12)
  loadSpritesheet(spritesheetID["generic_floor"], "tiles/generic_floor.png", 12, 12)
  loadSpritesheet(spritesheetID["generic_walls"], "tiles/generic_walls.png", 12, 12)
  loadSpritesheet(spritesheetID["liquids"], "tiles/liquids.png", 12, 12)
  loadSpritesheet(spritesheetID["surface_ground"], "tiles/surface_ground.png", 12, 12)

  # Create world
  # TODO make actual world generation
  var amogus = [0, 0]
  for num in 0..1000:
    echo num
    var surface_tile = grass_floor([amogus[0], amogus[1]])
    surface_floor_tilemap.add(surface_tile)

    if amogus[0] > 100:
      amogus[0] = 0
      amogus[1] += 1
    else:
      amogus[0] += 1
  
  #surface_floor_tilemap[0] = wooden_floor([0, 0])
  #surface_floor_tilemap[1] = wooden_floor([1, 0])
  #surface_floor_tilemap[2] = wooden_floor([1, 1])

proc gameUpdate(dt: float32) =
  # Process player stuff
  the_player = the_player.update()
  the_player.position = process_velocity(dt, the_player.position, the_player.velocity, the_player.speed)
  the_player.velocity = [0, 0]

  # Camera movement
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

  # idk testing stuff
  if keyp(K_o):
    colour_count += 1

  if key(K_l):
    surface_floor_tilemap.add(water(the_player.position))
  
  if key(K_k):
    surface_floor_tilemap.add(dirt(the_player.position))
  
  # Dynamic tilemap loading
  if the_player.is_moving:
    loaded_tilemap = @[]
    for tile in surface_floor_tilemap:
      if 
        tile.coords[0] > (0 + the_player.position[0] - toInt((screenWidth / 2)) - 10) and
        tile.coords[1] > (0 + the_player.position[1] - toInt((screenHeight / 2)) - 10) and
        tile.coords[0] < (toInt(screenWidth / 2) + the_player.position[0] + 10) and
        tile.coords[1] < (toInt(screenHeight / 2) + the_player.position[1] + 10)
        :
        loaded_tilemap.add(tile)

  # Tile animation processing
  var tile_counter = 0
  for tile in surface_wall_tilemap:
    if tile.animated:
      surface_wall_tilemap[tile_counter].animation.time_counter += dt

      if tile.animation.time_counter >= tile.animation.spf:
        surface_wall_tilemap[tile_counter].animation.time_counter -= tile.animation.spf
        if tile.animation.current_frame == tile.animation.frames.len() - 1:
          surface_wall_tilemap[tile_counter].animation.current_frame = 0
        else:
          surface_wall_tilemap[tile_counter].animation.current_frame += 1
    tile_counter += 1

  var second_tile_counter = 0
  for tile in surface_floor_tilemap:
    if tile.animated:
      surface_floor_tilemap[second_tile_counter].animation.time_counter += dt

      if tile.animation.time_counter >= tile.animation.spf:
        surface_floor_tilemap[second_tile_counter].animation.time_counter -= tile.animation.spf
        if tile.animation.current_frame == tile.animation.frames.len() - 1:
          surface_floor_tilemap[second_tile_counter].animation.current_frame = 0
        else:
          surface_floor_tilemap[second_tile_counter].animation.current_frame += 1
    second_tile_counter += 1

  #echo "\n------------------------------------\n\n", raft_tilemap

proc gameDraw() =
  cls()

  # Draw background
  setCamera(0, 0)

  setColor(colour_count) #12
  boxfill(0, 0, screenWidth, screenHeight)

  setSpritesheet(spritesheetID["amogus"])
  spr(0, 0, 0)

  # Draw world
  setCamera(
    get_world_coord(the_player.position[0], camera_offset[0], screenWidth),
    get_world_coord(the_player.position[1], camera_offset[1], screenHeight)
  )

  for tile in surface_floor_tilemap:
    if 
      tile.coords[0] > (0 + the_player.position[0] - toInt((screenWidth / 2)) - 10) and
      tile.coords[1] > (0 + the_player.position[1] - toInt((screenHeight / 2)) - 10) and
      tile.coords[0] < (toInt(screenWidth / 2) + the_player.position[0] + 10) and
      tile.coords[1] < (toInt(screenHeight / 2) + the_player.position[1] + 10)
      :
      setSpritesheet(spritesheetID[tile.spritesheet])
      if tile.animated:
        spr(tile.animation.frames[tile.animation.current_frame], tile.coords[0], tile.coords[1])
      else:
        spr(tile.sprite, tile.coords[0], tile.coords[1])

  the_player.draw_shadow()

  for tile in surface_wall_tilemap:
    if 
      tile.coords[0] > (0 + the_player.position[0] - toInt((screenWidth / 2)) - 10) and
      tile.coords[1] > (0 + the_player.position[1] - toInt((screenHeight / 2)) - 10) and
      tile.coords[0] < (toInt(screenWidth / 2) + the_player.position[0] + 10) and
      tile.coords[1] < (toInt(screenHeight / 2) + the_player.position[1] + 10)
      :
      setSpritesheet(spritesheetID[tile.spritesheet])
      if tile.animated:
        spr(tile.animation.frames[tile.animation.current_frame], tile.coords[0], tile.coords[1])
      else:
        spr(tile.sprite, tile.coords[0], tile.coords[1])

  the_player.draw()

  # Draw UI
  setCamera(0, 0)

  setSpritesheet(spritesheetID["cursor"])
  spr(0, mouse()[0] - 3, mouse()[1] - 3)

nico.init("mastrio", "legend_of_terraria")

#fixedSize(true)
#integerScale(true)

nico.createWindow("The Legend of Terraria", 170, 150, 3, false)
nico.run(gameInit, gameUpdate, gameDraw)
