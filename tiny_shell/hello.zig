const std = @import("std");
const sys = @import("./syscalls.zig").getSyscalls();

//fn eq(a: []const u8, b: []const u8) bool {
//    if (a.len != b.len) return false;
//    var i: usize = 0;
//    while (i < a.len) : (i += 1) {
//        if (a[i] != b[i]) return false;
//    }
//    return true;
//}

//comptime inline fn eq4(a: []const u8, b: []const u8) bool {
//    return a[0] == b[0] and a[1] == b[1] and a[2] == b[2] and a[3] == b[3];
//}

pub export fn _start() noreturn {
    //const msg = "Hello, world!\n";
    var buf: [128]u8 = undefined;

    while (true) {
        const prompt = "# ";
        _ = std.os.linux.syscall3(@enumFromInt(sys.write), 1, @intFromPtr(prompt.ptr), prompt.len);
        const nread = std.os.linux.syscall3(@enumFromInt(sys.read), 0, @intFromPtr(&buf[0]), buf.len);

        if (nread == 0) {
            _ = std.os.linux.syscall1(@enumFromInt(sys.exit), 0);
        }

        // Trim newline
        var len: usize = @intCast(nread);
        if (len > 0 and buf[len - 1] == 10) {
            len -= 1;
        }

        // Match command
        if (len == 4 and std.mem.eql(u8, buf[0..len], "echo")) {
            //if (len == 4 and
            //    buf[0] == 'e' and
            //    buf[1] == 'c' and
            //    buf[2] == 'h' and
            //    buf[3] == 'o')
            //{
            const msg = "Echoed!\n";
            _ = std.os.linux.syscall3(@enumFromInt(sys.write), 1, @intFromPtr(msg.ptr), msg.len);
        } else if (len == 4 and std.mem.eql(u8, buf[0..len], "exit")) {
            //} else if (len == 4 and
            //     buf[0] == 'e' and
            //    buf[1] == 'x' and
            //    buf[2] == 'i' and
            //    buf[3] == 't')
            //{
            _ = std.os.linux.syscall1(@enumFromInt(sys.exit), 0);
        } else {
            const msg = "Unknown command\n";
            _ = std.os.linux.syscall3(@enumFromInt(sys.write), 1, @intFromPtr(msg.ptr), msg.len);
        }
    }

    // Linux x86_64 syscall convention: rax = syscall number, rdi/rsi/rdx/... = args
    //_ = std.os.linux.syscall3(@enumFromInt(sys.write), 1, @intFromPtr(msg.ptr), @intCast(msg.len));
    //_ = std.os.linux.syscall1(@enumFromInt(sys.exit), 0);

    unreachable;
}
