
PWD = STM8S_StdPeriph_Driver
_SRC_DIR = $(PWD)/src

SRC_DIRS += $(_SRC_DIR)
INCS += $(PWD)/inc

_SRCS := stm8s_awu.c \
		 stm8s_beep.c \
		 stm8s_clk.c \
		 stm8s_exti.c \
         stm8s_flash.c \
         stm8s_gpio.c \
         stm8s_i2c.c \
         stm8s_itc.c \
         stm8s_iwdg.c \
         stm8s_rst.c \
         stm8s_spi.c \
         stm8s_tim1.c \
         stm8s_wwdg.c

mcu = $(findstring $(MCU), STM8S105 STM8S005 STM8S103 STM8S003 STM8S903 STM8AF626x STM8AF622x)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_adc1.c
endif

mcu = $(findstring $(MCU), STM8S208 STM8S007 STM8AF52Ax STM8AF62Ax)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_adc2.c
endif

mcu = $(findstring $(MCU), STM8S208 STM8AF52Ax)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_can.c
endif

mcu = $(findstring $(MCU), STM8S903 STM8AF622x)
ifneq ($(mcu), $(MCU))
	_SRCS += stm8s_tim2.c
endif

mcu = $(findstring $(MCU), STM8S208 STM8S207 STM8S007 STM8S105 STM8S005 STM8AF52Ax STM8AF62Ax STM8AF626x)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_tim3.c
endif

mcu = $(findstring $(MCU), STM8S903 STM8AF622x)
ifneq ($(mcu), $(MCU))
	_SRCS += stm8s_tim4.c
endif

mcu = $(findstring $(MCU), STM8S903 STM8AF622x)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_tim5.c
	_SRCS += stm8s_tim6.c
endif

mcu = $(findstring $(MCU), STM8S208 STM8S207 STM8S007 STM8S103 STM8S003 STM8S903 STM8AF52Ax STM8AF62Ax)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_uart1.c
endif

mcu = $(findstring $(MCU), STM8S105 STM8S005 STM8AF626x)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_uart2.c
endif

mcu = $(findstring $(MCU), STM8S208 STM8S207 STM8S007 STM8AF52Ax STM8AF62Ax)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_uart3.c
endif

mcu = $(findstring $(MCU), STM8AF622x)
ifeq ($(mcu), $(MCU))
	_SRCS += stm8s_uart4.c
endif   

SRCS += $(foreach src, $(_SRCS), $(_SRC_DIR)/$(src))
