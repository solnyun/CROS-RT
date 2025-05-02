#include <linux/kernel.h>
#include <linux/syscalls.h>

SYSCALL_DEFINE2(trace_syscall, int, option, char __user*, num) {
    char buffer[256];

    long copied = copy_from_user(buffer, num, sizeof(buffer) - 1);
    if (copied < 0 || copied == sizeof(buffer) - 1)
        return -EFAULT;

    buffer[sizeof(buffer) - 1] = '\0';

    if (option == 1)
        printk(KERN_INFO "[Start] Executor: %s pid: %d prio: %d\n", buffer, current->pid, current->rt_priority);

    else if (option == 2)
        printk(KERN_INFO "[End] Executor: %s pid: %d prio: %d\n", buffer, current->pid, current->rt_priority);

    else if (option == 3)
        printk(KERN_INFO "[Start] DDS: %s pid: %d prio: %d\n", buffer, current->pid, current->rt_priority);

    else if (option == 4)
        printk(KERN_INFO "[End] DDS: %s pid: %d prio: %d\n", buffer, current->pid, current->rt_priority);

    else
        printk(KERN_INFO "error\n");

    return 0;
}
