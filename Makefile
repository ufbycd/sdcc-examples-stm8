

PROJECT = test
MCU = STM8S103
SRC_DIRS := 
INCS := .
#BUILD=Debug

CC = sdcc
SIZE = size
LD = sdld
CL = sdcclib
CFLAGS := -mstm8
LDFLAGS := -lstm8 --out-fmt-elf -M


ifndef BUILD
	BUILD=Debug
endif

ifeq ($(BUILD), Debug)
	CFLAGS += --debug
else
	CFLAGS += --opt-code-size
endif

BUILD_PATH = $(BUILD)

SRCS := $(filter-out stm8s_it.c, $(wildcard *.c))


-include lib/subdir.mk
-include STM8S_StdPeriph_Driver/subdir.mk

OBJS := $(patsubst %.c, $(BUILD_PATH)/%.rel, $(SRCS))
DEPS := $(patsubst %.c, $(BUILD_PATH)/%.d, $(SRCS))

CFLAGS += ${addprefix -I, $(INCS)} -D$(MCU)

TARGET = $(BUILD)/$(PROJECT).elf
BUILD_DIRS = $(BUILD) ${addprefix $(BUILD)/, $(SRC_DIRS)}
MAIN_OBJ = $(BUILD)/main.rel
LIB = $(BUILD)/liba.lib

.PHONY: all clean MKDIR

all: $(TARGET)

$(BUILD_DIRS):
	 @${shell test -d $@ || mkdir -p $@}
	
$(DEPS):$(BUILD_PATH)/%.d:%.c | $(BUILD_DIRS)
	$(CC) -MM $(CFLAGS) $< > $@

-include $(DEPS)

$(BUILD_PATH)/%.rel:%.c $(BUILD_PATH)/%.d
	$(CC) -c $(CFLAGS) $< -o $@

$(LIB): $(OBJS)
	$(CL) $@ ${filter-out $(MAIN_OBJ), $^}

$(TARGET): $(LIB)
	$(CC) $(CFLAGS) $(LDFLAGS) -l$< -L$(BUILD) $(MAIN_OBJ) -o $@
	$(SIZE) $@

clean:
	$(foreach d, $(BUILD_DIRS), rm -f $(d)/*.*)
