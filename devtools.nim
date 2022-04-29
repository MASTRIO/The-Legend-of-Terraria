import std/math

proc round_to_int*(num_to_round: int, round_to: int): int =
  return (num_to_round / round_to).round().toInt() * round_to