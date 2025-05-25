
pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Hello world\n", .{});

    try bw.flush(); 
}


const std = @import("std");
const lib = @import("evo_lib");
