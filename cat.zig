const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}).init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var stdout_buffer: [1024]u8 = undefined;
    var stderr_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writerStreaming(&stdout_buffer);
    var stderr_writer = std.fs.File.stderr().writerStreaming(&stderr_buffer);

    const stdout = &stdout_writer.interface;
    const stderr = &stderr_writer.interface;

    const cwd = std.fs.cwd();

    // The first item in the slice is the program name
    for (args[1..]) |filepath| {
        const file = cwd.openFile(filepath, .{}) catch {
            stderr.print("Could not open: {s}\n", .{filepath}) catch {}; 
            stderr.flush() catch {};
            continue;
        };
        defer file.close();

        var file_buffer: [1024]u8 = undefined;
        var file_reader = file.reader(&file_buffer);
        const reader = &file_reader.interface;

        _ = try reader.streamRemaining(stdout);
    }

    try stdout.flush();
}
