// syscalls.zig
const std = @import("std");
const builtin = @import("builtin");

pub const Syscalls = struct {
    write: usize,
    exit: usize,
    read: usize,
    open: usize,
    close: usize,
};

pub fn getSyscalls() Syscalls {
    comptime {
        if (builtin.os.tag != .linux) {
            @compileError("This syscall table is only for Linux");
        }
    }

    return comptime switch (builtin.cpu.arch) {
        .x86_64 => return Syscalls{
            .write = @intFromEnum(std.os.linux.syscalls.X64.write),
            .exit = @intFromEnum(std.os.linux.syscalls.X64.exit),
            .read = @intFromEnum(std.os.linux.syscalls.X64.read),
            .open = @intFromEnum(std.os.linux.syscalls.X64.open),
            .close = @intFromEnum(std.os.linux.syscalls.X64.close),
        },
        .x86 => return Syscalls{
            .write = @intFromEnum(std.os.linux.syscalls.X86.write),
            .exit = @intFromEnum(std.os.linux.syscalls.X86.exit),
            .read = @intFromEnum(std.os.linux.syscalls.X86.read),
            .open = @intFromEnum(std.os.linux.syscalls.X86.open),
            .close = @intFromEnum(std.os.linux.syscalls.X86.close),
        },
        .arm => return Syscalls{
            .write = @intFromEnum(std.os.linux.syscalls.ARM.write),
            .exit = @intFromEnum(std.os.linux.syscalls.ARM.exit),
            .read = @intFromEnum(std.os.linux.syscalls.ARM.read),
            .open = @intFromEnum(std.os.linux.syscalls.ARM.open),
            .close = @intFromEnum(std.os.linux.syscalls.ARM.close),
        },
        .aarch64 => return Syscalls{
            .write = @intFromEnum(std.os.linux.syscalls.AARCH64.write),
            .exit = @intFromEnum(std.os.linux.syscalls.AARCH64.exit),
            .read = @intFromEnum(std.os.linux.syscalls.AARCH64.read),
            .open = @intFromEnum(std.os.linux.syscalls.AARCH64.open),
            .close = @intFromEnum(std.os.linux.syscalls.AARCH64.close),
        },
        else => @compileError("Unsupported architecture"),
    };
}
