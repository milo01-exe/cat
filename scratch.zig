const std = @import("std");

pub fn main() !void {
    const produce = [_][]const u8{ "carrots", "brocoli", "avocados", "apples", "lettuce" };
    const counts = [_]u8{ 32, 20, 12, 3, 100 };

    for (produce, counts) |name, count| {
        std.debug.print("{s}: {}\n", .{name, count});
    }
}
