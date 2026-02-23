zig cc -static -fno-stack-protector -O2 -s -fuse-ld=lld -Wl,--build-id=none  -Wl,--build-id=none -fno-asynchronous-unwind-tables -fno-unwind-tables -fno-ident hello.zig -o hello
strip --remove-section=.eh_frame --remove-section=.comment hello
