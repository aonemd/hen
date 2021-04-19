SOURCE_NAME = fitch.scm
BUILD_NAME = fitch

default: clean build run

build:
	chicken-csc $(SOURCE_NAME)
run:
	./$(BUILD_NAME)
clean:
	rm -f $(BUILD_NAME)
