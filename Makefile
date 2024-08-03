# Define the compiler
CXX = g++

# Define the compiler flags
CXXFLAGS = -std=c++11 -Wall

# Define the directories
SRC_DIR = src
BUILD_DIR = build

# Default target executable
TARGET = main

# Rule to compile a source file into an object file
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@powershell -Command "if (-not (Test-Path $(BUILD_DIR))) { New-Item -Path $(BUILD_DIR) -ItemType Directory }"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Rule to link the object file into an executable
$(TARGET): $(BUILD_DIR)/$(TARGET).o
	@$(CXX) $(CXXFLAGS) -o $(TARGET).exe $(BUILD_DIR)/$(TARGET).o

# Rule to build the executable and run a specific source file
run-%: 
	@$(MAKE) $(TARGET) SRC=$(SRC_DIR)/$*.cpp
	@./$(TARGET).exe
	@$(MAKE) clean

# Rule to handle building the object file from a source file
$(BUILD_DIR)/$(TARGET).o: $(SRC)
	@powershell -Command "if (-not (Test-Path $(BUILD_DIR))) { New-Item -Path $(BUILD_DIR) -ItemType Directory }"
	@$(CXX) $(CXXFLAGS) -c $(SRC) -o $(BUILD_DIR)/$(TARGET).o

# Rule to clean up generated files
clean:
	@del /q $(BUILD_DIR)\*.o
	@del /q $(TARGET).exe
