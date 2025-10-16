extern number light;
extern number light_top;
extern number light_left;
extern number light_right;
extern number light_bottom;

extern number light_top_left;
extern number light_top_right;
extern number light_bottom_left;
extern number light_bottom_right;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  vec4 pixel = Texel(texture, texture_coords);

  number final_light = light;

  number light_x1 = light_top_left - (light_top_left - light_top) * texture_coords.x + light_bottom + light_right + light_top_right + light_bottom_left + light_bottom_right;
  number light_y1 = light_top_left - (light_top_left - light_left) * texture_coords.y;

  number light_y = light_top - (light_top - light) * texture_coords.y;
  number light_y_left = light_top_left - (light_top_left - light_top) * texture_coords.y;
  number light_y_right = 1;
  number light_x = light_y_left - (light_y_left - light_y) * texture_coords.x;

  
  light_y_left = light_top_left - (light_top_left - light_left) * (texture_coords.y / 2 + 0.5);

  final_light = light;

  pixel.r = pixel.r * final_light;
  pixel.g = pixel.g * final_light;
  pixel.b = pixel.b * final_light;
  return pixel;
}