clang -nostdlib -static -fno-builtin -fno-stack-protector -O2 -s -fuse-ld=lld -Wl,--omagic -Wl,--build-id=none -Wl,--omagic -Wl,--build-id=none -fno-asynchronous-unwind-tables -fno-unwind-tables -fno-ident hello.c -o hello
strip --remove-section=.eh_frame --remove-section=.comment hello
