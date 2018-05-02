

PROJECT=test

#BUILD=Debug

ifndef BUILD
	BUILD=Debug
endif

CC = sdcc
LD = sdld
CFLAGS = -mstm8  
LDFLAGS = -lstm8 --out-fmt-ihx

SRCS := $(wildcard *.c)
OBJS := $(patsubst %.c,$(BUILD)/%.rel,$(SRCS))
DEPS := $(patsubst %.c,$(BUILD)/%.d,$(SRCS))

TARGET=$(BUILD)/$(PROJECT).ihx

.PHONY: all clean

all:MKDIR  $(TARGET)

MKDIR:
	@test -d $(BUILD) || mkdir -p $(BUILD)

$(DEPS):$(BUILD)/%.d:%.c
	$(CC) -MM $< > $@

-include $(DEPS)

$(BUILD)/%.rel:%.c
	$(CC) -c $(CFLAGS) $< -o $@

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

clean:
	@rm -f $(BUILD)/*
