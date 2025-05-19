#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Tu Nombre");
MODULE_DESCRIPTION("Un modulo simple del kernel que imprime un mensaje.");
MODULE_VERSION("1.0");

static int __init hola_inicio(void) {
    printk(KERN_INFO "Hola Mundo! Modulo cargado.\n");
    return 0;
}

static void __exit hola_salida(void) {
    printk(KERN_INFO "Adiós Mundo! Modulo descargado.\n");
}

module_init(hola_inicio);
module_exit(hola_salida);
