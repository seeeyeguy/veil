// library imports
const std = @import("std");
const rl = @import("raylib");

// Game imports
const Map = @import("entities/map.zig").Map;

pub fn main() !void {
    std.debug.print("Test",.{});
    rl.initWindow(1000,1000, "raylib");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        rl.drawText("Congrats! You created your first window", 100, 100, 20, .light_gray);

    }

}
 
