extern float light;
extern float is_blocks;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  vec4 pixel = Texel(texture, texture_coords);
  pixel.r = (pixel.r + texture_coords.x) / 2 * light;
  pixel.g = (pixel.g + texture_coords.x + texture_coords.y) / 3 * light;
  pixel.b = (pixel.b + texture_coords.y) / 2 * light;
  pixel.a = pixel.a;
  if (is_blocks == 0.0) {
    pixel.b = (pixel.b + texture_coords.y) / 3 * light * 1.5;
  }
  return pixel;
}