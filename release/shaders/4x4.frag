vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  vec2 new_coords = vec2(ceil(texture_coords.x * 32 / 8) / 4, ceil(texture_coords.y * 32 / 8) / 4);
  vec4 pixel = Texel(texture, new_coords);
  return pixel;
}