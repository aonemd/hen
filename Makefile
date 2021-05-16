SOURCE_NAME = hen.scm
BUILD_PATH = hen

default: clean build run

build:
	chicken-csc $(SOURCE_NAME)
run:
	./$(BUILD_PATH)
install:
	cp $(BUILD_PATH) /usr/local/bin
clean:
	rm -f $(BUILD_PATH)
