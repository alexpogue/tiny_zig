void _start() {
    __asm__ __volatile__(
        "movq $1, %rax\n"              // sys_write
        "movq $1, %rdi\n"              // stdout
        "leaq message(%rip), %rsi\n"
        "movq $14, %rdx\n"
        "syscall\n"

        "movq $60, %rax\n"             // sys_exit
        "xorq %rdi, %rdi\n"
        "syscall\n"

        "message:\n"
        ".ascii \"Hello, world!\\n\"\n"
    );
}
