import std/math

proc round_to_int*(num_to_round: int, round_to: int): int =
  return (num_to_round / round_to).round().toInt() * round_to

proc get_world_coord*(object_coord: int, camera_offset: int, screen_dimension: int): int =
  return (object_coord - toInt(screen_dimension / 2) + 7) + camera_offset

proc to_world_coords*(object_pos: array[2, int], camera_offset: array[2, int], screen_dimensions: array[2, int]): array[2, int] =
  return [
    get_world_coord(object_pos[0], camera_offset[0], screen_dimensions[0]),
    get_world_coord(object_pos[1], camera_offset[1], screen_dimensions[1])
  ]