LD_ADDR = 0x87800000
BURN_TOOL_PATH = ../../tool/imxdownload
SD_PATH = /dev/sdc

all:
	#编程.s生成.o
	arm-linux-gnueabihf-gcc -g -c led.s -o led.o
	#把所有.o链接成elf文件
	arm-linux-gnueabihf-ld -Ttext $(LD_ADDR) led.o -o led.elf
	#elf生成bin文件
	arm-linux-gnueabihf-objcopy -O binary -S -g led.elf led.bin
	#反汇编
	arm-linux-gnueabihf-objdump -D led.elf > led.dis

burn:
	$(BURN_TOOL_PATH) led.bin $(SD_PATH)

clean:
	rm -rf *.o led.bin led.elf led.dis led.imx load.imx