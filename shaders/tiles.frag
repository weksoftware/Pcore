extern float light;
extern float is_blocks;
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  if (is_blocks == 0.0) {
    return Texel(texture, texture_coords );
  }
  vec2 coords1 = vec2(0.5, 0.5);
  vec2 coords2 = vec2(0.1, 0.1);
  vec2 coords3 = vec2(0.9, 0.9);
  if (texture_coords.x < 0.05 || texture_coords.y < 0.05) {
    return vec4(0.5 * light, 0.5 * light, 0.5 * light, 1.0);
  }
  vec4 pixel1 = Texel(texture, coords1);
  vec4 pixel2 = Texel(texture, coords2);
  vec4 pixel3 = Texel(texture, coords3);

  vec4 pixel = (pixel1 + pixel2 + pixel3) / 3;

  return vec4(pixel.r * light, pixel.g * light, pixel.b * light, pixel.a);
}