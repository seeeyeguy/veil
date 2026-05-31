const rl = @import("raylib");
const Hex = @import("../models/hex.zig").Hex;
const HexCoord = @import("../models/hex.zig").HexCoord;
const Terrain = @import("../models/hex.zig").Terrain;
const World = @import("../models/world.zig").World;

const hex_size: f32 = 32.0; // hex size in pixels
const sqrt3: f32 = 1.7320508; // used in hex coord calcuations

fn hexToScreen(coord: HexCoord) rl.Vector2 {
    return rl.Vector2{
        .x = hex_size * (sqrt3 * @as(f32, @floatFromInt(coord.q)) + sqrt3 / 2.0 * @as(f32, @floatFromInt(coord.r))),
        .y = hex_size * (1.5 * @as(f32, @floatFromInt(coord.r))), 
    };
}

fn terrainColor(terrain: Terrain) rl.Color {
    return switch (terrain) {
        .fresh_water => rl.Color{ .r = 100, .g = 180, .b = 220, .a = 255 },
        .forest      => rl.Color{ .r = 30,  .g = 120, .b = 40,  .a = 255 },
        .seawater    => rl.Color{ .r = 20,  .g = 80,  .b = 180, .a = 255 },
        .coastal     => rl.Color{ .r = 100, .g = 160, .b = 220, .a = 255 },
        .desert      => rl.Color{ .r = 220, .g = 190, .b = 100, .a = 255 },
        .plains      => rl.Color{ .r = 140, .g = 200, .b = 80,  .a = 255 },
        .jungle      => rl.Color{ .r = 20,  .g = 90,  .b = 30,  .a = 255 },
        .ocean       => rl.Color{ .r = 30,  .g = 100, .b = 200, .a = 255 },
        .arctic      => rl.Color{ .r = 220, .g = 235, .b = 245, .a = 255 },
    };
}

fn drawHex(hex: Hex, offset: rl.Vector2) void {
    const center = rl.Vector2{
        .x = hexToScreen(hex.hex_coord).x + offset.x,
        .y = hexToScreen(hex.hex_coord).y + offset.y,
    };

    const color = terrainColor(hex.terrain);

    // filled hex
    rl.drawPoly(center, 6, hex_size, 30.0, color);

    // outline for debugging
    rl.drawPolyLines(center, 6, hex_size, 30.0, .black);
}

pub fn drawWorld(world: World, offset: rl.Vector2) void {
    for (world.hexes) |row| {
        for (row) |hex| {
            drawHex(hex, offset);
        }
    }
}
