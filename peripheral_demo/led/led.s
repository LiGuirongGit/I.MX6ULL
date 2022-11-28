/*  
    汇编程序入口是 _start
    本次的IO是GPIO1_IO03
*/

.global _start  /*全局编号 */

_start:
    /*初始化所有外设时钟 */
    ldr r0, =0x020c4068     @CCM_CCGR0寄存器的地址赋值给r0
    ldr r1, =0xffffffff     @在r1中存放0xffffffff
    str r1, [r0]            @将0xffffffff写入到CCM_CCGR0寄存器中

    ldr r0, =0x020c406c     @CCM_CCGR1
    str r1, [r0]

    ldr r0, =0x020c4070     @CCM_CCGR2
    str r1, [r0]

    ldr r0, =0x020c4074     @CCM_CCGR3
    str r1, [r0]

    ldr r0, =0x020c4078     @CCM_CCGR4
    str r1, [r0]

    ldr r0, =0x020c407c    @CCM_CCGR5
    str r1, [r0]

    ldr r0, =0x020c4080     @CCM_CCGR6
    str r1, [r0]

    /* 
        IO复用：
        设置IOMUXC_SW_MUX_CTL_PAD_GPIO1_IO03寄存器
        第0-3位为：0101
        寄存器的地址是：0x020e0068
    */
    ldr r0, =0x020e0068
    ldr r1, =0x5
    str r1, [r0]

    /*
        配置电气属性
        设置IOMUXC_SW_PAD_CTL_PAD_GPIO1_IO03寄存器
        寄存器的地址是：0x020e02f4
        第0位：SRE，摇摆率；设置为0，即低摇摆率
        第1-2位：保留
        第3-5位：选择驱动能力。设置110，也就是R0/6
        第6-7位：设置速度。设置10，也就是100MHz
        第8-10位：保留
        第11位：开路输出。关闭开路输出，设置位0
        第12位：使能上下拉状态保持器。设置为1
        第13位：使用上下拉还是使用状态保持器。设置为0，即使用状态保持器
        第14-15位：选择上下拉的电阻阻值。设置00，使用默认下拉，100K下拉
        第16位：是否使用迟滞器(波形整形)。设置为0，不使用迟滞器
        
        结果：1 0000 1011 0000，也就是10b0
     */
     ldr r0, =0x020e02f4
     ldr r1, =0x10b0
     str r1, [r0]

    /* 
        设置GPIO的方向
        寄存器是GPIO1_GDIR
        寄存器地址：0x0209c004
        GPIO1_IO03对应该寄存器的第3位，将该位置1，也就是将这个IO口设置为输出方向
        1000 == 0x8
     */
    ldr r0, =0x0209c004
    ldr r1, =0x8
    str r1, [r0]

    /*
        亮灯
        设置GPIO为低电平
        寄存器是GPIO1_DR
        寄存器地址是0x0209c000
     */
     ldr r0, =0x0209c000
     ldr r1, =0x0
     str r1, [r0]

/*
    死循环
*/
loop:
    b loop

