#include <linux/kernel.h>
#include <linux/syscalls.h>

extern void connect_port_priority(int priority, int port);
extern void disconnect_port_priority(int port);
extern void add_tid_priority(int tid, int priority);
extern void remove_tid_priority(int tid);

SYSCALL_DEFINE2(connect_pp_syscall, int, priority, int, port) {
        if(port % 2 == 1)
                connect_port_priority(priority, port);
        //printk("Connect_port_priority system call\n");
        return 0;
}

SYSCALL_DEFINE1(disconnect_pp_syscall, int, port) {
    disconnect_port_priority(port);
    //printk("Disconnect_port_priority system call\n");
    return 0;
}

// System call for adding a tid-priority mapping
SYSCALL_DEFINE2(add_tp_syscall, int, tid, int, priority) {
    add_tid_priority(tid, priority);
    return 0;
}

// System call for removing a tid-priority mapping
SYSCALL_DEFINE1(remove_tp_syscall, int, tid) {
    remove_tid_priority(tid);
    return 0;
}
