extern float light;
extern float down_light;
extern float is_blocks;
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    if (is_blocks == 0.0) {
        return pixel;
    }
    float light_diff = light - down_light;
    float new_light = light - light_diff * texture_coords.y;
    vec4 new_pixel = vec4(pixel.r * new_light, pixel.g * new_light, pixel.b * new_light, pixel.a / new_light);
    return new_pixel;
}