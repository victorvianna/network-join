# Project settings

HEADER_DIR = include
SRC_DIR = src
BUILD_DIR = build
LIB_DIR = lib
BIN_DIR = bin
BIN_NAME = decide_later # name of the final file

# Create build directories
$(shell mkdir -p $(BUILD_DIR)) #create directories for building
$(shell mkdir -p $(BIN_DIR)) 

# Gather filenames

SOURCES = $(shell find $(SRC_DIR) -name '*.cpp') # cpp files 
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o) # regex treatment to switch .cpp for .o
LIB_FILES = $(shell find $(LIB_DIR) -name '*.*') 

# Compiler settings

CXX := mpic++ 
CXX_FLAGS := -std=c++11 -I $(HEADER_DIR) -Llib -lboost_mpi -lboost_serialization # switch to static libs for portability?

# Recipes

#all: $(BIN_DIR)/$(BIN_NAME) #compile main executable and create a shortcut in root directory
#	@$(RM) $(BIN_NAME)
#	@ln -s $(BIN_DIR)/$(BIN_NAME) $(BIN_NAME) 

#$(BIN_DIR)/$(BIN_NAME): $(OBJECTS) # main executable
#	$(CXX) $(CXX_FLAGS) $^ -o $@

test_%: $(OBJECTS) tests/**/test_%.cpp 
	$(CXX) $(CXX_FLAGS) $^ -o $(BIN_DIR)/$@	

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp # source files
	$(CXX) $(CXX_FLAGS) -c $^ -o $@

.PRECIOUS: $(BUILD_DIR)/%.o  # dont delete intermediary object files

clean:
	@$(RM) -r $(BUILD_DIR)
	@$(RM) $(BIN_NAME)
	@$(RM) -r $(BIN_DIR)
