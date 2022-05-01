# Physics engine?

proc process_velocity*(
    delta_time: float32,
    position: array[2, int],
    velocity: array[2, int],
    speed: float32
    ): array[2, int] =
  
  var new_position = position
  if velocity != [0, 0]:
    new_position[0] += velocity[0] * toInt(speed * delta_time)
    new_position[1] += velocity[1] * toInt(speed * delta_time)

    #echo "w: ", velocity, " : ", new_position

  return new_position