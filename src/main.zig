const std = @import("std");
const rl = @import("raylib");

const config = @import("config.zig");
const World = @import("models/world.zig").World;
const world_generator = @import("models/world.zig").generator;
const Camera = @import("render/camera.zig").Camera;
const Gameboard = @import("render/gameboard.zig");

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var world = try world_generator(allocator, 10, 10);
    defer world.deinit(allocator);

    const cfg = config.default;
    rl.initWindow(cfg.window.width, cfg.window.height, cfg.window.title);
    defer rl.closeWindow();

    var camera = Camera.init(
        @as(f32, @floatFromInt(cfg.window.width)),
        @as(f32, @floatFromInt(cfg.window.height))
    );

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        camera.update();

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.black);

        rl.beginMode2D(camera.inner);
        Gameboard.drawWorld(world, rl.Vector2{ .x = 100.0, .y = 100.0 });
        rl.endMode2D();
    }
}
