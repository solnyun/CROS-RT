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
extern void net_non_rt_pl_handler_action(int period, int util);

static int period = 100; // msecs
module_param(period, int, 0644); 
static int util = 50; // percent
module_param(util, int, 0644); 

static int run_non_rt_handler(void* arg)
{
	unsigned long flags;
	int sleep_time;
	for (;;) {
	    net_non_rt_pl_handler_action(period, util);

	    sleep_time = period * (100 - util) / 100;
	    msleep(sleep_time);

	    if (kthread_should_stop())
		break;
	}

	return 0;
}

static int non_rt_handler_init(void)
{
	cpumask_t mask;
	struct sched_param param;
	printk("non_rt_handler polling init start\n");
	
	//create kernel thread
	knonrtd = kthread_run(run_non_rt_handler, NULL ,"knonrtd-pl");
	if (!knonrtd) {
		printk(KERN_ERR "knonrtd polling create failed\n");
		return 0;
	}

	//if polling server
	param.sched_priority = 99;
	if (sched_setscheduler(knonrtd, SCHED_FIFO, &param)) {
                printk(KERN_ERR "Failed to set kmond priority\n");
                kthread_stop(knonrtd);
		printk(KERN_ERR "knonrtd polling created failed\n");
		return 0;
        }
	
	//pin cpu 0
	cpumask_clear(&mask);
	cpumask_set_cpu(0, &mask);
	if (set_cpus_allowed_ptr(knonrtd, &mask)){
		printk(KERN_ERR "knonrtd polling fail to pinning\n");
		return 0;
	}
	
	printk("module init end\n");
	return 0;
}

static void non_rt_handler_exit(void)
{
	kthread_stop(knonrtd);
	printk("non_rt_handler exit\n");
}

module_init(non_rt_handler_init);
module_exit(non_rt_handler_exit);
