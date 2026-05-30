pub const WindowConfig = struct {
    width: i32 = 1000,
    height: i32 = 1000,
    title: [:0]const u8 = "Veil",
    fps: i32 = 60
 };

pub const GameConfig = struct {
    window: WindowConfig = .{}
};

pub const default: GameConfig = .{};
