obj-m += hola_mundo.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

install:
	sudo cp hola_mundo.ko /lib/modules/$(shell uname -r)/extra/
	sudo depmod -a

uninstall:
	sudo rm /lib/modules/$(shell uname -r)/extra/hola_mundo.ko
	sudo depmod -a
