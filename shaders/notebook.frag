extern float light;
extern float is_blocks;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    float average = (pixel.r + pixel.b + pixel.g) / 3;
    if (average < 0.3) {
        float blue = average + 0.2;
        return vec4(0.0 * light, 0.0 * light, blue * light, pixel.a);
    }
    float white = 0.9 - (1 - average) / 3;
    if (is_blocks == 1.0 && ((texture_coords.y > 0.2 && texture_coords.y < 0.3) || (texture_coords.x > 0.45 && texture_coords.x < 0.55))) {
        white = 0.5;
    }
    return vec4(white * light, white * light, white * light, pixel.a);
}