const rl = @import("raylib");

// camera constants
const min_zoom: f32 = 0.2;
const max_zoom: f32 = 3.0;
const zoom_speed: f32 = 0.1;
const pan_speed_factor: f32 = 300;

pub const Camera = struct {
    inner: rl.Camera2D,

    // // initialize screen
    pub fn init(screen_width: f32, screen_height: f32) Camera {
        return .{
            .inner = rl.Camera2D{
                .offset = rl.Vector2{.x = screen_width / 2, .y = screen_height / 2},
                .target = rl.Vector2{.x = 0.0, .y = 0.0},
                .rotation = 0.0,
                .zoom = 1.0
            },
        };
    }

    // update camera
    pub fn update(self: *Camera) void {

        // catch left mouse button to pan
        if (rl.isMouseButtonDown(.left)) {
            const delta = rl.getMouseDelta();
            self.inner.target.x -= delta.x / self.inner.zoom;
            self.inner.target.y -= delta.y / self.inner.zoom;
        }

        // catch wsad and up/down/left/right keys to pan 
        if (rl.isKeyDown(.w) or rl.isKeyDown(.up))  self.inner.target.y -= pan_speed_factor * rl.getFrameTime();
        if (rl.isKeyDown(.s) or rl.isKeyDown(.down))  self.inner.target.y += pan_speed_factor * rl.getFrameTime();
        if (rl.isKeyDown(.a) or rl.isKeyDown(.left))  self.inner.target.x -= pan_speed_factor * rl.getFrameTime();
        if (rl.isKeyDown(.d) or rl.isKeyDown(.right))  self.inner.target.x += pan_speed_factor * rl.getFrameTime();

        const scroll = rl.getMouseWheelMove();
        if (scroll != 0) {
            const mouse_world = rl.getScreenToWorld2D(rl.getMousePosition(), self.inner);

            self.inner.zoom += scroll * zoom_speed;
            self.inner.zoom = @max(min_zoom, @min(self.inner.zoom, max_zoom));

            const mouse_world_new = rl.getScreenToWorld2D(rl.getMousePosition(), self.inner);
            self.inner.target.x += mouse_world.x - mouse_world_new.x;
            self.inner.target.y += mouse_world.y - mouse_world_new.y;
        }
    }
};


