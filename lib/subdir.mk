
PWD = lib
_SRC_DIR = $(PWD)

SRC_DIRS += $(_SRC_DIR)
INCS += $(PWD)

_SRCS = uart.c

SRCS += $(foreach src, $(_SRCS), $(_SRC_DIR)/$(src))