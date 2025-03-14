vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  vec4 pixel = Texel(texture, texture_coords);
  number m = (pixel.r + pixel.g + pixel.b) / 3;
  pixel.r = m;
  pixel.g = m;
  pixel.b = m;
  return pixel;
}