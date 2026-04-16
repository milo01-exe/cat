const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}).init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var stdout_buffer: [1024]u8 = undefined;
    const stdout_file = std.fs.File.stdout();
    var stdout_writer = stdout_file.writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    const cwd = std.fs.cwd();

    // The first item in the slice is the program name
    for (args[1..]) |filepath| {
        const max_bytes = 16 * 1024 * 1024; // 16 MB
        const text = try cwd.readFileAlloc(allocator, filepath, max_bytes);
        defer allocator.free(text);

        try stdout.writeAll(text);
    }
    
    try stdout.flush();
}
