const std = @import("std");

const Hex = @import("hex.zig");
const ResourceDeposit = @import("hex.zig").ResourceDeposit;

pub const World = struct {
    width: u32,
    height: u32,
    hexes: [][]Hex,

    // deinitialize our hexes from memory
    pub fn deinit(self: World, allocator: std.mem.Allocator) void {
       for (self.hexes) |row| {
           allocator.free(row);
       } 
       allocator.free(self.hexes);
    }
};

pub fn generator(allocator: std.mem.Allocator, width: u32, height: u32) !World {
    const rows = try allocator.alloc([]Hex, height);

    for (0..height) |row| {
        rows[row] = try allocator.alloc(Hex, width);
        for (0..width) |col| {
            rows[row][col] = Hex{
                .hex_coord = .{ .q = @intCast(col), .r = @intCast(row)},
                .terrain = .plains,
                .resources = &[_]ResourceDeposit{}
            };
        }
    }

    return World{
        .width = width,
        .height = height,
        .hexes = rows
    };
}
