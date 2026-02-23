/* tiny-fixed.ld */
OUTPUT_FORMAT("elf64-x86-64")
ENTRY(_start)

SECTIONS
{
    /* Start at typical ELF load address */
    . = 0x400000;

    .text ALIGN(16) : {
        *(.text)
    }
}
