extern float light;
extern float is_blocks;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    return vec4(pow(pixel.r * light * (1 - (is_blocks / 10000.0)),1.8 ), pow(pixel.g * light,1.8), pow(pixel.b * light,1.8), pixel.a);
}