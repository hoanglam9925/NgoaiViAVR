
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _uartIndex=R4
	.DEF _uartIndex_msb=R5
	.DEF _nhietdo=R7
	.DEF _tram=R6
	.DEF _chuc=R9
	.DEF _dvi=R8

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0

_0x0:
	.DB  0x53,0x31,0x4C,0x31,0x30,0x0,0x53,0x31
	.DB  0x4C,0x31,0x31,0x0,0x53,0x31,0x4C,0x32
	.DB  0x30,0x0,0x53,0x31,0x4C,0x32,0x31,0x0
	.DB  0x53,0x31,0x4C,0x33,0x30,0x0,0x53,0x31
	.DB  0x4C,0x33,0x31,0x0,0x53,0x31,0x4C,0x34
	.DB  0x30,0x0,0x53,0x31,0x4C,0x34,0x31,0x0
	.DB  0x53,0x32,0x4C,0x31,0x30,0x0,0x53,0x32
	.DB  0x4C,0x31,0x31,0x0,0x53,0x32,0x4C,0x32
	.DB  0x30,0x0,0x53,0x32,0x4C,0x32,0x31,0x0
	.DB  0x53,0x32,0x4C,0x33,0x30,0x0,0x53,0x32
	.DB  0x4C,0x33,0x31,0x0,0x53,0x32,0x4C,0x34
	.DB  0x30,0x0,0x53,0x32,0x4C,0x34,0x31,0x0
	.DB  0x4E,0x68,0x69,0x65,0x74,0x20,0x64,0x6F
	.DB  0x3A,0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x06
	.DW  _0x2E
	.DW  _0x0*2

	.DW  0x06
	.DW  _0x2E+6
	.DW  _0x0*2+6

	.DW  0x06
	.DW  _0x2E+12
	.DW  _0x0*2+12

	.DW  0x06
	.DW  _0x2E+18
	.DW  _0x0*2+18

	.DW  0x06
	.DW  _0x2E+24
	.DW  _0x0*2+24

	.DW  0x06
	.DW  _0x2E+30
	.DW  _0x0*2+30

	.DW  0x06
	.DW  _0x2E+36
	.DW  _0x0*2+36

	.DW  0x06
	.DW  _0x2E+42
	.DW  _0x0*2+42

	.DW  0x06
	.DW  _0x2E+48
	.DW  _0x0*2+48

	.DW  0x06
	.DW  _0x2E+54
	.DW  _0x0*2+54

	.DW  0x06
	.DW  _0x2E+60
	.DW  _0x0*2+60

	.DW  0x06
	.DW  _0x2E+66
	.DW  _0x0*2+66

	.DW  0x06
	.DW  _0x2E+72
	.DW  _0x0*2+72

	.DW  0x06
	.DW  _0x2E+78
	.DW  _0x0*2+78

	.DW  0x06
	.DW  _0x2E+84
	.DW  _0x0*2+84

	.DW  0x06
	.DW  _0x2E+90
	.DW  _0x0*2+90

	.DW  0x0A
	.DW  _0x4D
	.DW  _0x0*2+96

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 5/22/2021
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <string.h>
;// Declare your global variables here
;
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;
;#define RS PORTA.0
;#define RW PORTA.1
;#define E PORTA.2
;#define DATA PORTC
;#define Slave1 PORTB.0
;#define Slave2 PORTB.1
;
;int uartIndex = 0;
;unsigned char uartReceive[6];
;unsigned char uartSend[6];
;unsigned char nhietdo;
;unsigned char tram,chuc,dvi;
;
;void khoidong(char x)
; 0000 0031 {

	.CSEG
_khoidong:
; .FSTART _khoidong
; 0000 0032     RW=RS=E=0;
	ST   -Y,R26
;	x -> Y+0
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
; 0000 0033     DATA=x;
	CALL SUBOPT_0x0
; 0000 0034     //delay_ms(5);
; 0000 0035     E=1;
; 0000 0036     //delay_ms(5);
; 0000 0037     E=0;
; 0000 0038     delay_ms(20);
; 0000 0039 }
	RJMP _0x2080001
; .FEND
;void hienthi(char x)
; 0000 003B {
_hienthi:
; .FSTART _hienthi
; 0000 003C     RW=E=0;
	ST   -Y,R26
;	x -> Y+0
	CBI  0x1B,2
	CBI  0x1B,1
; 0000 003D     RS=1;
	SBI  0x1B,0
; 0000 003E     DATA=x;
	CALL SUBOPT_0x0
; 0000 003F     //delay_ms(5);
; 0000 0040     E=1;
; 0000 0041     //delay_ms(5);
; 0000 0042     E=0;
; 0000 0043     delay_ms(20);
; 0000 0044 }
	RJMP _0x2080001
; .FEND
;void hienchuoi(char *data)
; 0000 0046 {
_hienchuoi:
; .FSTART _hienchuoi
; 0000 0047     int n,i;
; 0000 0048     n = strlen(data);
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
;	*data -> Y+4
;	n -> R16,R17
;	i -> R18,R19
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL _strlen
	MOVW R16,R30
; 0000 0049     for(i = 0; i < n; i++)
	__GETWRN 18,19,0
_0x18:
	__CPWRR 18,19,16,17
	BRGE _0x19
; 0000 004A     {
; 0000 004B         hienthi(data[i]);
	MOVW R30,R18
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RCALL _hienthi
; 0000 004C     }
	__ADDWRN 18,19,1
	RJMP _0x18
_0x19:
; 0000 004D }
	CALL __LOADLOCR4
	ADIW R28,6
	RET
; .FEND
;void uart_char_send(unsigned char chr){
; 0000 004E void uart_char_send(unsigned char chr){
_uart_char_send:
; .FSTART _uart_char_send
; 0000 004F     while (!(UCSRA & (1<<UDRE))) {}; //cho den khi bit UDRE=1
	ST   -Y,R26
;	chr -> Y+0
_0x1A:
	SBIS 0xB,5
	RJMP _0x1A
; 0000 0050             UDR=chr;
	LD   R30,Y
	OUT  0xC,R30
; 0000 0051 }
	RJMP _0x2080001
; .FEND
;
;void uart_string_send(unsigned char *txt){   //"hello"
; 0000 0053 void uart_string_send(unsigned char *txt){
_uart_string_send:
; .FSTART _uart_string_send
; 0000 0054     unsigned char n, i;
; 0000 0055     n=strlen(txt); //Dem so ky tu
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	*txt -> Y+2
;	n -> R17
;	i -> R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL _strlen
	MOV  R17,R30
; 0000 0056           for (i=0; i<n; i++){
	LDI  R16,LOW(0)
_0x1E:
	CP   R16,R17
	BRSH _0x1F
; 0000 0057             uart_char_send(txt[i]);    //phat du lieu
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CLR  R30
	ADD  R26,R16
	ADC  R27,R30
	LD   R26,X
	RCALL _uart_char_send
; 0000 0058             }
	SUBI R16,-1
	RJMP _0x1E
_0x1F:
; 0000 0059 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
; .FEND
;char uart_char_receive(void)
; 0000 005B {
_uart_char_receive:
; .FSTART _uart_char_receive
; 0000 005C     while (!(UCSRA & (1<<UDRE))) {};
_0x20:
	SBIS 0xB,5
	RJMP _0x20
; 0000 005D     return UDR;
	IN   R30,0xC
	RET
; 0000 005E }
; .FEND
;void SPI_Write(char data)		/* SPI write data function */
; 0000 0060 {
_SPI_Write:
; .FSTART _SPI_Write
; 0000 0061 	SPDR = data;			/* Write data to SPI data register */
	ST   -Y,R26
;	data -> Y+0
	LD   R30,Y
	OUT  0xF,R30
; 0000 0062 	while(!(SPSR & (1<<SPIF)));	/* Wait till transmission complete */
_0x23:
	SBIS 0xE,7
	RJMP _0x23
; 0000 0063 
; 0000 0064 }
	RJMP _0x2080001
; .FEND
;char SPI_Read()				/* SPI read data function */
; 0000 0066 {
; 0000 0067 //	SPDR = 0xFF;
; 0000 0068 	while(!(SPSR & (1<<SPIF)));	/* Wait till reception complete */
; 0000 0069 	return(SPDR);			/* Return received data */
; 0000 006A }
;char SPI_tranceiver(char data)		/* SPI write data function */
; 0000 006C {
_SPI_tranceiver:
; .FSTART _SPI_tranceiver
; 0000 006D 	SPDR = data;			/* Write data to SPI data register */
	ST   -Y,R26
;	data -> Y+0
	LD   R30,Y
	OUT  0xF,R30
; 0000 006E 	while(!(SPSR & (1<<SPIF)));	/* Wait till transmission complete */
_0x29:
	SBIS 0xE,7
	RJMP _0x29
; 0000 006F     return(SPDR);
	IN   R30,0xF
_0x2080001:
	ADIW R28,1
	RET
; 0000 0070 }
; .FEND
;void UARTSetup(char chuc, char donvi)
; 0000 0072 {
_UARTSetup:
; .FSTART _UARTSetup
; 0000 0073     uartSend[0] = 'L';
	ST   -Y,R26
;	chuc -> Y+1
;	donvi -> Y+0
	LDI  R30,LOW(76)
	STS  _uartSend,R30
; 0000 0074     uartSend[1] = 'M';
	LDI  R30,LOW(77)
	__PUTB1MN _uartSend,1
; 0000 0075     uartSend[2] = chuc;
	LDD  R30,Y+1
	__PUTB1MN _uartSend,2
; 0000 0076     uartSend[3] = donvi;
	LD   R30,Y
	__PUTB1MN _uartSend,3
; 0000 0077     uartSend[4] = '\n';
	LDI  R30,LOW(10)
	__PUTB1MN _uartSend,4
; 0000 0078 }
	ADIW R28,2
	RET
; .FEND
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 007B {
_usart_rx_isr:
; .FSTART _usart_rx_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 007C 
; 0000 007D     uartReceive[uartIndex] = uart_char_receive();
	MOVW R30,R4
	SUBI R30,LOW(-_uartReceive)
	SBCI R31,HIGH(-_uartReceive)
	PUSH R31
	PUSH R30
	RCALL _uart_char_receive
	POP  R26
	POP  R27
	ST   X,R30
; 0000 007E     uartIndex++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 007F     //SxLxx //S1L11
; 0000 0080     if(uartIndex == 5)
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R4
	CPC  R31,R5
	BREQ PC+2
	RJMP _0x2C
; 0000 0081     {
; 0000 0082         uartIndex = 0;
	CLR  R4
	CLR  R5
; 0000 0083         //khoidong(0x80);
; 0000 0084         uartReceive[5] = '\0';
	LDI  R30,LOW(0)
	__PUTB1MN _uartReceive,5
; 0000 0085         //hienchuoi(uartReceive);
; 0000 0086         if(strcmp(uartReceive,"S1L10") == 0)
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,0
	CALL _strcmp
	CPI  R30,0
	BRNE _0x2D
; 0000 0087         {
; 0000 0088             PORTB &=0b11111110;
	CBI  0x18,0
; 0000 0089             SPI_Write('1');
	LDI  R26,LOW(49)
	RCALL _SPI_Write
; 0000 008A             PORTB |=0b00000001;
	SBI  0x18,0
; 0000 008B         }
; 0000 008C         else if(strcmp(uartReceive,"S1L11") == 0)
	RJMP _0x2F
_0x2D:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,6
	CALL _strcmp
	CPI  R30,0
	BRNE _0x30
; 0000 008D         {
; 0000 008E             PORTB &=0b11111110;
	CBI  0x18,0
; 0000 008F             SPI_Write('2');
	LDI  R26,LOW(50)
	RCALL _SPI_Write
; 0000 0090             PORTB |=0b00000001;
	SBI  0x18,0
; 0000 0091         }
; 0000 0092         else if(strcmp(uartReceive,"S1L20") == 0)
	RJMP _0x31
_0x30:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,12
	CALL _strcmp
	CPI  R30,0
	BRNE _0x32
; 0000 0093         {
; 0000 0094             PORTB &=0b11111110;
	CBI  0x18,0
; 0000 0095             SPI_Write('3');
	LDI  R26,LOW(51)
	RCALL _SPI_Write
; 0000 0096             PORTB |=0b00000001;
	SBI  0x18,0
; 0000 0097         }
; 0000 0098         else if(strcmp(uartReceive,"S1L21") == 0)
	RJMP _0x33
_0x32:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,18
	CALL _strcmp
	CPI  R30,0
	BRNE _0x34
; 0000 0099         {
; 0000 009A             PORTB &=0b11111110;
	CBI  0x18,0
; 0000 009B             SPI_Write('4');
	LDI  R26,LOW(52)
	RCALL _SPI_Write
; 0000 009C             PORTB |=0b00000001;
	SBI  0x18,0
; 0000 009D         }
; 0000 009E         else if(strcmp(uartReceive,"S1L30") == 0)
	RJMP _0x35
_0x34:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,24
	CALL _strcmp
	CPI  R30,0
	BRNE _0x36
; 0000 009F         {
; 0000 00A0             PORTB &=0b11111110;
	CBI  0x18,0
; 0000 00A1             SPI_Write('5');
	LDI  R26,LOW(53)
	RCALL _SPI_Write
; 0000 00A2             PORTB |=0b00000001;
	SBI  0x18,0
; 0000 00A3         }
; 0000 00A4         else if(strcmp(uartReceive,"S1L31") == 0)
	RJMP _0x37
_0x36:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,30
	CALL _strcmp
	CPI  R30,0
	BRNE _0x38
; 0000 00A5         {
; 0000 00A6             PORTB &=0b11111110;
	CBI  0x18,0
; 0000 00A7             SPI_Write('6');
	LDI  R26,LOW(54)
	RCALL _SPI_Write
; 0000 00A8             PORTB |=0b00000001;
	SBI  0x18,0
; 0000 00A9         }
; 0000 00AA         else if(strcmp(uartReceive,"S1L40") == 0)
	RJMP _0x39
_0x38:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,36
	CALL _strcmp
	CPI  R30,0
	BRNE _0x3A
; 0000 00AB         {
; 0000 00AC             PORTB &=0b11111110;
	CBI  0x18,0
; 0000 00AD             SPI_Write('7');
	LDI  R26,LOW(55)
	RCALL _SPI_Write
; 0000 00AE             PORTB |=0b00000001;
	SBI  0x18,0
; 0000 00AF         }
; 0000 00B0         else if(strcmp(uartReceive,"S1L41") == 0)
	RJMP _0x3B
_0x3A:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,42
	CALL _strcmp
	CPI  R30,0
	BRNE _0x3C
; 0000 00B1         {
; 0000 00B2             PORTB &=0b11111110;
	CBI  0x18,0
; 0000 00B3             SPI_Write('8');
	LDI  R26,LOW(56)
	RCALL _SPI_Write
; 0000 00B4             PORTB |=0b00000001;
	SBI  0x18,0
; 0000 00B5         }       /************/
; 0000 00B6         else if(strcmp(uartReceive,"S2L10") == 0)
	RJMP _0x3D
_0x3C:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,48
	CALL _strcmp
	CPI  R30,0
	BRNE _0x3E
; 0000 00B7         {
; 0000 00B8             PORTB &=0b11111101;
	CBI  0x18,1
; 0000 00B9             SPI_Write('1');
	LDI  R26,LOW(49)
	RJMP _0x52
; 0000 00BA             PORTB |=0b00000010;
; 0000 00BB         }
; 0000 00BC         else if(strcmp(uartReceive,"S2L11") == 0)
_0x3E:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,54
	CALL _strcmp
	CPI  R30,0
	BRNE _0x40
; 0000 00BD         {
; 0000 00BE             PORTB &=0b11111101;
	CBI  0x18,1
; 0000 00BF             SPI_Write('2');
	LDI  R26,LOW(50)
	RJMP _0x52
; 0000 00C0             PORTB |=0b00000010;
; 0000 00C1         }
; 0000 00C2         else if(strcmp(uartReceive,"S2L20") == 0)
_0x40:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,60
	CALL _strcmp
	CPI  R30,0
	BRNE _0x42
; 0000 00C3         {
; 0000 00C4             PORTB &=0b11111101;
	CBI  0x18,1
; 0000 00C5             SPI_Write('3');
	LDI  R26,LOW(51)
	RJMP _0x52
; 0000 00C6             PORTB |=0b00000010;
; 0000 00C7         }
; 0000 00C8         else if(strcmp(uartReceive,"S2L21") == 0)
_0x42:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,66
	CALL _strcmp
	CPI  R30,0
	BRNE _0x44
; 0000 00C9         {
; 0000 00CA             PORTB &=0b11111101;
	CBI  0x18,1
; 0000 00CB             SPI_Write('4');
	LDI  R26,LOW(52)
	RJMP _0x52
; 0000 00CC             PORTB |=0b00000010;
; 0000 00CD         }
; 0000 00CE         else if(strcmp(uartReceive,"S2L30") == 0)
_0x44:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,72
	CALL _strcmp
	CPI  R30,0
	BRNE _0x46
; 0000 00CF         {
; 0000 00D0             PORTB &=0b11111101;
	CBI  0x18,1
; 0000 00D1             SPI_Write('5');
	LDI  R26,LOW(53)
	RJMP _0x52
; 0000 00D2             PORTB |=0b00000010;
; 0000 00D3         }
; 0000 00D4         else if(strcmp(uartReceive,"S2L31") == 0)
_0x46:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,78
	CALL _strcmp
	CPI  R30,0
	BRNE _0x48
; 0000 00D5         {
; 0000 00D6             PORTB &=0b11111101;
	CBI  0x18,1
; 0000 00D7             SPI_Write('6');
	LDI  R26,LOW(54)
	RJMP _0x52
; 0000 00D8             PORTB |=0b00000010;
; 0000 00D9         }
; 0000 00DA         else if(strcmp(uartReceive,"S2L40") == 0)
_0x48:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,84
	CALL _strcmp
	CPI  R30,0
	BRNE _0x4A
; 0000 00DB         {
; 0000 00DC             PORTB &=0b11111101;
	CBI  0x18,1
; 0000 00DD             SPI_Write('7');
	LDI  R26,LOW(55)
	RJMP _0x52
; 0000 00DE             PORTB |=0b00000010;
; 0000 00DF         }
; 0000 00E0         else if(strcmp(uartReceive,"S2L41") == 0)
_0x4A:
	CALL SUBOPT_0x1
	__POINTW2MN _0x2E,90
	CALL _strcmp
	CPI  R30,0
	BRNE _0x4C
; 0000 00E1         {
; 0000 00E2             PORTB &=0b11111101;
	CBI  0x18,1
; 0000 00E3             SPI_Write('8');
	LDI  R26,LOW(56)
_0x52:
	RCALL _SPI_Write
; 0000 00E4             PORTB |=0b00000010;
	SBI  0x18,1
; 0000 00E5         }
; 0000 00E6 
; 0000 00E7 
; 0000 00E8     }
_0x4C:
_0x3D:
_0x3B:
_0x39:
_0x37:
_0x35:
_0x33:
_0x31:
_0x2F:
; 0000 00E9 }
_0x2C:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND

	.DSEG
_0x2E:
	.BYTE 0x60
;
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// SPI functions
;#include <spi.h>
;
;void main(void)
; 0000 00F3 {

	.CSEG
_main:
; .FSTART _main
; 0000 00F4 // Declare your local variables here
; 0000 00F5 
; 0000 00F6 // Input/Output Ports initialization
; 0000 00F7 // Port A initialization
; 0000 00F8 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 00F9 DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 00FA // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 00FB PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 00FC 
; 0000 00FD // Port B initialization
; 0000 00FE // Function: Bit7=Out Bit6=In Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=Out Bit0=Out
; 0000 00FF DDRB=(1<<DDB7) | (0<<DDB6) | (1<<DDB5) | (1<<DDB4) | (0<<DDB3) | (0<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(179)
	OUT  0x17,R30
; 0000 0100 // State: Bit7=0 Bit6=T Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=0 Bit0=0
; 0000 0101 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0102 
; 0000 0103 // Port C initialization
; 0000 0104 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0105 DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 0106 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0107 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0108 
; 0000 0109 // Port D initialization
; 0000 010A // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 010B DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 010C // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 010D PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 010E 
; 0000 010F // Timer/Counter 0 initialization
; 0000 0110 // Clock source: System Clock
; 0000 0111 // Clock value: Timer 0 Stopped
; 0000 0112 // Mode: Normal top=0xFF
; 0000 0113 // OC0 output: Disconnected
; 0000 0114 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0115 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0116 OCR0=0x00;
	OUT  0x3C,R30
; 0000 0117 
; 0000 0118 // Timer/Counter 1 initialization
; 0000 0119 // Clock source: System Clock
; 0000 011A // Clock value: Timer1 Stopped
; 0000 011B // Mode: Normal top=0xFFFF
; 0000 011C // OC1A output: Disconnected
; 0000 011D // OC1B output: Disconnected
; 0000 011E // Noise Canceler: Off
; 0000 011F // Input Capture on Falling Edge
; 0000 0120 // Timer1 Overflow Interrupt: Off
; 0000 0121 // Input Capture Interrupt: Off
; 0000 0122 // Compare A Match Interrupt: Off
; 0000 0123 // Compare B Match Interrupt: Off
; 0000 0124 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0125 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0126 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0127 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0128 ICR1H=0x00;
	OUT  0x27,R30
; 0000 0129 ICR1L=0x00;
	OUT  0x26,R30
; 0000 012A OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 012B OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 012C OCR1BH=0x00;
	OUT  0x29,R30
; 0000 012D OCR1BL=0x00;
	OUT  0x28,R30
; 0000 012E 
; 0000 012F // Timer/Counter 2 initialization
; 0000 0130 // Clock source: System Clock
; 0000 0131 // Clock value: Timer2 Stopped
; 0000 0132 // Mode: Normal top=0xFF
; 0000 0133 // OC2 output: Disconnected
; 0000 0134 ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0135 TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 0136 TCNT2=0x00;
	OUT  0x24,R30
; 0000 0137 OCR2=0x00;
	OUT  0x23,R30
; 0000 0138 
; 0000 0139 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 013A TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 013B 
; 0000 013C // External Interrupt(s) initialization
; 0000 013D // INT0: Off
; 0000 013E // INT1: Off
; 0000 013F // INT2: Off
; 0000 0140 MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 0141 MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 0142 
; 0000 0143 // USART initialization
; 0000 0144 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0145 // USART Receiver: On
; 0000 0146 // USART Transmitter: On
; 0000 0147 // USART Mode: Asynchronous
; 0000 0148 // USART Baud Rate: 9600
; 0000 0149 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	OUT  0xB,R30
; 0000 014A UCSRB=(1<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0000 014B UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 014C UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 014D UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 014E 
; 0000 014F // Analog Comparator initialization
; 0000 0150 // Analog Comparator: Off
; 0000 0151 // The Analog Comparator's positive input is
; 0000 0152 // connected to the AIN0 pin
; 0000 0153 // The Analog Comparator's negative input is
; 0000 0154 // connected to the AIN1 pin
; 0000 0155 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0156 SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 0157 
; 0000 0158 // ADC initialization
; 0000 0159 // ADC disabled
; 0000 015A ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 015B 
; 0000 015C // SPI initialization
; 0000 015D // SPI Type: Master
; 0000 015E // SPI Clock Rate: 2000.000 kHz
; 0000 015F // SPI Clock Phase: Cycle Start
; 0000 0160 // SPI Clock Polarity: Low
; 0000 0161 // SPI Data Order: MSB First
; 0000 0162 SPCR=(0<<SPIE) | (1<<SPE) | (0<<DORD) | (1<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	LDI  R30,LOW(80)
	OUT  0xD,R30
; 0000 0163 SPSR=(0<<SPI2X);
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 0000 0164 
; 0000 0165 // TWI initialization
; 0000 0166 // TWI disabled
; 0000 0167 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 0168 
; 0000 0169 // Global enable interrupts
; 0000 016A #asm("sei")
	sei
; 0000 016B     khoidong(0x0C);
	LDI  R26,LOW(12)
	RCALL _khoidong
; 0000 016C     khoidong(0x38);
	LDI  R26,LOW(56)
	RCALL _khoidong
; 0000 016D     hienchuoi("Nhiet do:");
	__POINTW2MN _0x4D,0
	RCALL _hienchuoi
; 0000 016E while (1)
_0x4E:
; 0000 016F       {
; 0000 0170       // Place your code here
; 0000 0171         PORTB |= 0x02;
	SBI  0x18,1
; 0000 0172         PORTB &= ~0x01;
	CBI  0x18,0
; 0000 0173         nhietdo = SPI_tranceiver(0x00);
	LDI  R26,LOW(0)
	RCALL _SPI_tranceiver
	MOV  R7,R30
; 0000 0174         PORTB |= 0x01;
	SBI  0x18,0
; 0000 0175         chuc = nhietdo/10 + 48;
	MOV  R26,R7
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	SUBI R30,-LOW(48)
	MOV  R9,R30
; 0000 0176         dvi = nhietdo%10 + 48;
	MOV  R26,R7
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	SUBI R30,-LOW(48)
	MOV  R8,R30
; 0000 0177         khoidong(0x89);
	LDI  R26,LOW(137)
	RCALL _khoidong
; 0000 0178 
; 0000 0179         hienthi(chuc);
	MOV  R26,R9
	RCALL _hienthi
; 0000 017A         hienthi(dvi);
	MOV  R26,R8
	RCALL _hienthi
; 0000 017B         hienthi(223);
	LDI  R26,LOW(223)
	RCALL _hienthi
; 0000 017C         hienthi('C');
	LDI  R26,LOW(67)
	RCALL _hienthi
; 0000 017D         UARTSetup(chuc, dvi);
	ST   -Y,R9
	MOV  R26,R8
	RCALL _UARTSetup
; 0000 017E         uart_string_send(uartSend);
	LDI  R26,LOW(_uartSend)
	LDI  R27,HIGH(_uartSend)
	RCALL _uart_string_send
; 0000 017F         PORTB &= ~0x02;
	CBI  0x18,1
; 0000 0180         SPI_Write(nhietdo);
	MOV  R26,R7
	RCALL _SPI_Write
; 0000 0181         PORTB |= 0x02;
	SBI  0x18,1
; 0000 0182         delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 0183       }
	RJMP _0x4E
; 0000 0184 }
_0x51:
	RJMP _0x51
; .FEND

	.DSEG
_0x4D:
	.BYTE 0xA

	.CSEG
_strcmp:
; .FSTART _strcmp
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
strcmp0:
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    brne strcmp1
    tst  r22
    brne strcmp0
strcmp3:
    clr  r30
    ret
strcmp1:
    sub  r22,r23
    breq strcmp3
    ldi  r30,1
    brcc strcmp2
    subi r30,2
strcmp2:
    ret
; .FEND
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.DSEG
_uartReceive:
	.BYTE 0x6
_uartSend:
	.BYTE 0x6

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LD   R30,Y
	OUT  0x15,R30
	SBI  0x1B,2
	CBI  0x1B,2
	LDI  R26,LOW(20)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(_uartReceive)
	LDI  R31,HIGH(_uartReceive)
	ST   -Y,R31
	ST   -Y,R30
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
