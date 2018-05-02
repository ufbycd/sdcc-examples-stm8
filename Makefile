

PROJECT=test
SRC_DIRS := . lib
INCS := $(SRC_DIRS)
#BUILD=Debug

CC = sdcc
LD = sdld
CFLAGS := -mstm8 $(foreach i, $(INCS), -I"$(i)")
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

SRCS := $(wildcard $(foreach d, $(SRC_DIRS), $(d)/*.c))
OBJS := $(patsubst %.c, $(BUILD_PATH)/%.rel, $(SRCS))
DEPS := $(patsubst %.c, $(BUILD_PATH)/%.d, $(SRCS))

#-include lib/subdir.mk

TARGET = $(BUILD)/$(PROJECT).ihx
BUILD_DIRS = $(foreach d, $(SRC_DIRS), $(BUILD)/$(d))

.PHONY: all clean MKDIR

all: $(TARGET)

MKDIR:
	@${foreach d, $(BUILD_DIRS), $(shell test -d $(d) || mkdir -p $(d))}
	
$(DEPS):$(BUILD_PATH)/%.d:%.c | MKDIR
	$(CC) -MM $< > $@

-include $(DEPS)

$(BUILD_PATH)/%.rel:%.c
	$(CC) -c $(CFLAGS) $< -o $@


$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

clean:
	$(foreach d, $(BUILD_DIRS), rm -f $(d)/*.*)
