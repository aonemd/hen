SOURCE_NAME = hen.scm
BUILD_NAME = hen

default: clean build run

build:
	chicken-csc $(SOURCE_NAME)
run:
	./$(BUILD_NAME)
clean:
	rm -f $(BUILD_NAME)
