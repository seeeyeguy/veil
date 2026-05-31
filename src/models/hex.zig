const std = @import("std");

// -- enums -------------------------------------------
pub const Terrain = enum {
    fresh_water,
    forest,
    seawater,
    coastal,
    desert,
    plains,
    jungle,
    ocean,
    arctic
};

pub const ResourceType = enum {
    gold,
    silicon,
    fresh_water,
    copper,
    iron,
    rare_earth,
    uranium,
    biomass
};

pub const HumanPresence = enum {
    none,
    sparse,
    nomadic,
    settled,
    urban,
    dense
};

pub const AlienPresence = enum {
    none,
    shadow,
    cover,
    overt
};

// -- Supporting structs -------------------------------------------

pub const HexCoord = struct {
    q: i32,
    r: i32
};

pub const ResourceDeposit = struct {
    resource_type: ResourceType,
    deposity: i32,
    depeleted: bool
};

// Main model for a hex tile
pub const Hex = struct {
    terrain: Terrain,
    hex_coord: HexCoord,

    resources: []ResourceDeposit,

    // Human state
    faction_id: ?i32 = null,
    human_presence: HumanPresence = .none,
    population: i32 = 0,
    development: i32 = 0,


    // Alien state
    alien_presence: AlienPresence = .none,
    surveilled: bool = false,
    infiltrated: bool = false,

    // Human-alien interaction
    local_exposure: f32 = 0.0,
    local_awareness: f32 = 0.0,

    // -- Methods -----------------------------------

    // Check if a hex has a non-depleted resource by resource_type
    pub fn hasResource(self: Hex, resource_type: ResourceType) bool {
        for (self.Resources) |deposit| {
            if (self.Resources == resource_type and !deposit.depeleted) {
                return true;
            } 
        }
        return false; 
    }

    // Calculate exposure risk
    // TODO: recalculate this in the future.
    //          should tune for better consideration related to
    //          exposure vs awareness.  Higher awareness means
    //          exposure is more relevant
    pub fn exposureRisk(self: Hex) f32 {
        return (self.local_exposure + self.local_awareness) / 2;
    }
};
