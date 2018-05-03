

PROJECT = test
MCU = STM8S103
SRC_DIRS := 
INCS := .
#BUILD=Debug

CC = sdcc
LD = sdld
CFLAGS := -mstm8
LDFLAGS := -lstm8 --out-fmt-ihx


ifndef BUILD
	BUILD=Debug
endif

ifeq ($(BUILD), Debug)
	CFLAGS += --debug
else
	CFLAGS += --opt-code-size
endif

BUILD_PATH = $(BUILD)

SRCS := $(wildcard *.c)


-include lib/subdir.mk
-include STM8S_StdPeriph_Driver/subdir.mk

OBJS := $(patsubst %.c, $(BUILD_PATH)/%.rel, $(SRCS))
DEPS := $(patsubst %.c, $(BUILD_PATH)/%.d, $(SRCS))

CFLAGS += $(foreach i, $(INCS), -I"$(i)") -D$(MCU)

TARGET = $(BUILD)/$(PROJECT).ihx
BUILD_DIRS = $(BUILD) $(foreach d, $(SRC_DIRS), $(BUILD)/$(d))

.PHONY: all clean MKDIR

all: $(TARGET)

MKDIR:
	@${foreach d, $(BUILD_DIRS), $(shell test -d $(d) || mkdir -p $(d))}
	
$(DEPS):$(BUILD_PATH)/%.d:%.c | MKDIR
	$(CC) -MM $(CFLAGS) $< > $@

-include $(DEPS)

$(BUILD_PATH)/%.rel:%.c
	$(CC) -c $(CFLAGS) $< -o $@

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

clean:
	$(foreach d, $(BUILD_DIRS), rm -f $(d)/*.*)
