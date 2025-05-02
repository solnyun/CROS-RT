#include <linux/percpu.h>
#include <linux/kernel.h>
#include <linux/syscalls.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/interrupt.h>
#include <linux/percpu.h>
#include <linux/cpu.h>
#include <linux/kthread.h>
#include <linux/sched.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/timekeeping.h>
#include <linux/seq_file.h>
#include <linux/delay.h>
#include <linux/sched.h>
#include <uapi/linux/sched/types.h>

MODULE_LICENSE("Dual BSD/GPL");

struct task_struct *knonrtd;
extern void net_non_rt_handler_action(void);

static int run_non_rt_handler(void* arg)
{
	unsigned long flags;
	for (;;) {
	    net_non_rt_handler_action();

	    set_current_state(TASK_INTERRUPTIBLE);
	    schedule();
	    set_current_state(TASK_RUNNING);

	    if (kthread_should_stop())
		break;
	}

	return 0;
}

static int non_rt_handler_init(void)
{
	cpumask_t mask;
	struct sched_param param;
	printk("non_rt_handler background init start\n");
	
	//create kernel thread
	knonrtd = kthread_run(run_non_rt_handler, NULL ,"knonrtd-bg");
	if (!knonrtd) {
		printk(KERN_ERR "knonrtd background create failed\n");
		return 0;
	}
	
	//pin cpu 0
	cpumask_clear(&mask);
	cpumask_set_cpu(0, &mask);
	if (set_cpus_allowed_ptr(knonrtd, &mask)){
		printk(KERN_ERR "knonrtd background fail to pinning\n");
		return 0;
	}
	
	printk("module init end\n");
	return 0;
}

static void non_rt_handler_exit(void)
{
	kthread_stop(knonrtd);
	printk("non_rt_handler background exit\n");
}

module_init(non_rt_handler_init);
module_exit(non_rt_handler_exit);
