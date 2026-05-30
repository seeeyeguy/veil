// library imports
const std = @import("std");
const rl = @import("raylib");

// Game imports
const Map = @import("entities/map.zig").Map;
const config = @import("config.zig");

pub fn main() !void {
    const cfg = config.default;
    rl.initWindow(cfg.WindowConfig.width, cfg.WindowConfig.height, cfg.WindowConfig.title);
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        rl.drawText("Congrats! You created your first window", 100, 100, 20, .light_gray);
    }

}
 
