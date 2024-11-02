CC := gcc
CFLAGS := -Wall -Werror -g -std=c11
TARGET := zuma
DEPS   := src/zuma.c src/zuma.h
SCRIPT := script

all: $(TARGET)

judge-case: all
	bash $(SCRIPT)/$@.sh

judge-random: all
	bash $(SCRIPT)/$@.sh

$(TARGET): $(DEPS)
	$(CC) $(CFLAGS) -o $@ $<

clean:
	-rm -rf $(TARGET) *.in *.out

.PHONY: all clean judge-case judge-random
