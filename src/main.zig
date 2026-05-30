// library imports
const std = @import("std");
const rl = @import("raylib");

// Game imports
const Map = @import("models/map.zig").Map;
const config = @import("config.zig");
const World = @import("models/world.zig").World;
const world_generator = @import("models/world.zig").generator;

pub fn main() !void {
 
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var world = try world_generator(allocator, 10, 10);
    defer world.deinit(allocator);

    const cfg = config.default;
    rl.initWindow(cfg.window.width, cfg.window.height, cfg.window.title);
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        rl.drawText("Congrats! You created your first window", 100, 100, 20, .light_gray);
    }

}
