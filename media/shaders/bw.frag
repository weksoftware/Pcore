extern float light;
extern float is_blocks;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    float average = (pixel.r + pixel.b + pixel.g) / 3 * (1 - (is_blocks / 10000.0));
    return vec4(average * light, average * light, average * light, pixel.a);
}