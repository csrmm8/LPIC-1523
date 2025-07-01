#!/usr/bin/env python3
#######################
# Ejemplos de uso
# Solo memoria
# python3 stress_tool.py -m 1

# Memoria y CPU
# python3 stress_tool.py -m 1 -c 60

# Memoria, CPU y Disco
# python3 stress_tool.py -m 1 -c 60 -d 60
import sys
import time
import argparse
import threading
import os
import math
import random
import string

def consume_memory(size_gb):
    print(f"[+] Consumiendo {size_gb} GB de memoria...")
    # 1 GB = 1 * 1024 * 1024 * 1024 bytes
    block_size = 1024 * 1024 * 1024
    blocks = [bytearray(block_size) for _ in range(size_gb)]
    input("[*] Memoria consumida. Presiona Enter para liberar...")

def cpu_stress(duration_sec):
    print("[+] Generando carga del 50% en CPU...")
    end_time = time.time() + duration_sec
    while time.time() < end_time:
        # Calcular algo sin usar todo el CPU
        x = 0
        for _ in range(100000):
            x += math.sqrt(math.pi)
        time.sleep(0.01)  # Breve pausa para mantener uso en ~50%

def disk_stress(duration_sec, temp_file="stress_test.tmp"):
    print("[+] Iniciando acceso intensivo al disco...")
    end_time = time.time() + duration_sec
    chunk_size = 1024 * 1024 * 10  # 10 MB por bloque
    data = bytearray(os.urandom(chunk_size))

    try:
        with open(temp_file, "wb") as f:
            while time.time() < end_time:
                f.write(data)
                f.flush()
                os.fsync(f.fileno())
                # Leer también para generar tráfico de E/S
                f.seek(0)
                f.read(chunk_size)
                # Limpiar archivo para la próxima escritura
                f.seek(0)
                f.truncate()
    finally:
        if os.path.exists(temp_file):
            os.remove(temp_file)

def main():
    parser = argparse.ArgumentParser(description="Herramienta de estrés para CPU, Memoria y Disco.")
    parser.add_argument("-m", "--memoria", type=int, help="Consumir N GB de memoria")
    parser.add_argument("-c", "--cpu", type=int, help="Ejecutar carga en CPU por N segundos")
    parser.add_argument("-d", "--disco", type=int, help="Realizar operaciones intensivas en disco por N segundos")
    args = parser.parse_args()

    if not any(vars(args).values()):
        parser.print_help()
        return

    threads = []

    if args.memoria:
        t = threading.Thread(target=consume_memory, args=(args.memoria,))
        t.start()
        threads.append(t)

    if args.cpu:
        t = threading.Thread(target=cpu_stress, args=(args.cpu,))
        t.start()
        threads.append(t)

    if args.disco:
        t = threading.Thread(target=disk_stress, args=(args.disco,))
        t.start()
        threads.append(t)

    for t in threads:
        t.join()

if __name__ == "__main__":
    main()
