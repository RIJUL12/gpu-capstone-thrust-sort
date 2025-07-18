# CUDA settings
CUDA_PATH ?= /usr/local/cuda
NVCC := $(CUDA_PATH)/bin/nvcc

# Source and target
TARGET     := thrustSort
SRC        := $(TARGET).cu
OBJ        := $(TARGET).o
EXE        := $(TARGET).exe

# GPU architectures to support (modern only)
SMS        := 60 61 70 72 75 80 86
GENCODE_FLAGS := $(foreach sm,$(SMS),-gencode arch=compute_$(sm),code=sm_$(sm))
GENCODE_FLAGS += -gencode arch=compute_86,code=compute_86

# Compilation flags
CCFLAGS    := -m64 --std=c++14 -Wno-deprecated-gpu-targets
LDFLAGS    :=

# Build rules
all: build

build: $(EXE)

$(OBJ): $(SRC)
	$(NVCC) $(CCFLAGS) $(GENCODE_FLAGS) -c $< -o $@

$(EXE): $(OBJ)
	$(NVCC) $(CCFLAGS) $(GENCODE_FLAGS) $^ -o $@ $(LDFLAGS)

run: build
	./$(EXE) > output.log

clean:
	rm -f $(OBJ) $(EXE) output.log
