fn getSec(timer: *std.time.Timer) u64 {
    return timer.read() / std.time.ns_per_s;
}
fn getMsec(timer: *std.time.Timer) u64 {
    return timer.read() / std.time.ns_per_ms;
}
fn getPos(timer: *std.time.Timer, end_time_s: u64, width: u64) u64 {
    return (getMsec(timer) * width / end_time_s) / std.time.ms_per_s;
}
pub fn main() !void {
    const end_time_s: u64 = 10;
    const width: u64 = 172 ;

    const stdout_file = std.io.getStdOut().writer();
    var field: [width]u8 = undefined;
    @memset(&field, ' ');
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    var timer = try std.time.Timer.start();

    while (getSec(&timer) < end_time_s) {
        const position = getPos(&timer, end_time_s, width);
        field[position] = '@';
            if (position != 0) {
                field[position - 1] = ' ';
            } 
        for (field) |ch| {
            try stdout.print("{c}", .{ch});
        }
        std.Thread.sleep(1 * std.time.ns_per_ms);
        try bw.flush();
        try stdout.print("\r", .{});
    }
    std.Thread.sleep(1 * std.time.ns_per_s);
}

test "print" {

    std.debug.print("\x5413", .{});
}

const std = @import("std");
const lib = @import("evo_lib");
