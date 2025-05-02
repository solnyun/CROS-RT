obj-y += priority_identifier.o trace.o
obj-m += rt_handler.o non_rt_bg.o non_rt_pl.o
#obj-m += rt_handler.o non_rt_handler.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
