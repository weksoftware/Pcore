extern float light;
extern float is_blocks;
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  if (is_blocks == 0.0) {
    return Texel(texture, texture_coords );
  }
  vec2 new_coords = vec2(0.5, 0.5);
  if (texture_coords.x < 0.05 || texture_coords.y < 0.05) {
    return vec4(0.5 * light, 0.5 * light, 0.5 * light, 1.0);
  }
  vec4 pixel = Texel(texture, new_coords);
  return vec4(pixel.r * light, pixel.g * light, pixel.b * light, pixel.a);
}