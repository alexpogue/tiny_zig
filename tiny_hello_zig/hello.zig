pub export fn _start() callconv(.naked) noreturn {
    asm volatile (
        \\ movq $1, %rax
        \\ movq $1, %rdi
        \\ leaq message(%rip), %rsi
        \\ movq $14, %rdx
        \\ syscall
        \\ movq $60, %rax
        \\ xorq %rdi, %rdi
        \\ syscall
        \\ message:
        \\ .ascii "Hello, world!\n"
    );
    unreachable;
}
