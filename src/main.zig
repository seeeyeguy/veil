// library imports
const std = @import("std");
const rl = @import("raylib");

// Game imports
const Map = @import("entities/map.zig").Map;

pub fn main() !void {
    std.debug.print("Test",.{});
    rl.initWindow(100,100, "raylib");
}
 
