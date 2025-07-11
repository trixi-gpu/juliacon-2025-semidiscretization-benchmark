# juliacon-2025-semidiscretization-benchmark
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT) [![DOI](https://zenodo.org/badge/1017467245.svg)](https://doi.org/10.5281/zenodo.15864940)

This repository provides the source code and instructions to reproduce the CPU and GPU semidiscretization performance benchmarks presented in the JuliaCon 2025 talk [TrixiCUDA.jl: CUDA Support for Solving Hyperbolic PDEs on GPU](https://pretalx.com/juliacon-2025/talk/EFYUBD/).

## Reproduce the Benchmarks
First, clone the repository to your local machine:
```bash
git clone https://github.com/trixi-gpu/juliacon-2025-semidiscretization-benchmark.git
```

Once the clone completes, move into the source directory:
```bash
cd juliacon-2025-semidiscretization-benchmark/code
```

Next, start Julia with the project environment and install all required packages:
```bash
julia --project=.
] instantiate
```

After dependencies have been fetched, precompile the core module:
```bash
include("src/TrixiCUDA.jl")
```

With the module precompiled, run the full benchmark suite:
```bash
include("benchmark/benchmark.jl")
```

You'll see progress and information printed to the terminal as each example runs, for example:
```bash
julia> include("benchmark/benchmark.jl")
=============== Mode: Fixed DOFs Approach ===============
[1] Linear Advection Equation (Basic), running examples_fixed_dofs\advection_basic_1d.jl
[ Info: Benchmarking rhs! on CPU
[ Info: Benchmarking rhs! on GPU
[2] Linear Advection Equation (Basic), running examples_fixed_dofs\advection_basic_2d.jl
[ Info: Benchmarking rhs! on CPU
[ Info: Benchmarking rhs! on GPU
[3] Linear Advection Equation (Basic), running examples_fixed_dofs\advection_basic_3d.jl
[ Info: Benchmarking rhs! on CPU
[ Info: Benchmarking rhs! on GPU
Saved: ..\plots\fixed_dofs_approach_linear_advection_equation_basic.png
...
=============== Mode: Variable DOFs Approach ===============
[1] Linear Advection Equation (Basic), running examples_variable_dofs\advection_basic_1d.jl
[ Info: Benchmarking rhs! on CPU
[ Info: Benchmarking rhs! on GPU
[2] Linear Advection Equation (Basic), running examples_variable_dofs\advection_basic_2d.jl
[ Info: Benchmarking rhs! on CPU
[ Info: Benchmarking rhs! on GPU
[3] Linear Advection Equation (Basic), running examples_variable_dofs\advection_basic_3d.jl
[ Info: Benchmarking rhs! on CPU
[ Info: Benchmarking rhs! on GPU
Saved: ..\plots\variable_dofs_approach_linear_advection_equation_basic.png
...
```
Note that benchmarks are conducted using two approaches: (1) fixed DOFs and (2) variable DOFs.

Once it finishes, all generated figures will be saved in the plots directory. 

## Sample Benchmark Results
Sample benchmark figures are available in the [figures](https://github.com/trixi-gpu/juliacon-2025-semidiscretization-benchmark/tree/main/figures) directory, and a complete report can be found [here](https://trixi-gpu.github.io/benchmark/). 

Sample benchmarks were conducted on an NVIDIA RTX 4060 (Ada architecture). The software environment was as follows:
```bash
# Julia version information
julia> versioninfo()
Julia Version 1.10.9
Commit 5595d20a28 (2025-03-10)
Platform Info:
  OS: Windows (x86_64-w64-mingw32)
  CPU: 20× 13th Gen Intel® Core™ i9-13900H
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-15.0.7 (ORCJIT, goldmont)

# CUDA version information
julia> using CUDA; CUDA.versioninfo()
CUDA runtime 12.6 (artifact installation)
CUDA driver 12.8
NVIDIA driver 572.42.0

CUDA libraries:
  CUBLAS    12.6.4
  CURAND    10.3.7
  CUFFT     11.3.0
  CUSOLVER  11.7.1
  CUSPARSE  12.5.4
  CUPTI     2024.3.2 (API 24.0.0)
  NVML      12.0.0+572.42

Julia packages:
  CUDA             5.6.1
  CUDA_Driver_jll  0.10.4+0
  CUDA_Runtime_jll 0.15.5+0

Toolchain:
  Julia  1.10.9
  LLVM   15.0.7

Device:
  0: NVIDIA GeForce RTX 4060 Laptop GPU (sm_89, 6.706 GiB / 7.996 GiB available)
```
Note that results may vary on different GPU models, Julia releases, and CUDA versions. Please take these benchmark results for reference only.

## Acknowledgment
Many thanks to the following professors for their guidance on this project:

[Prof. Hendrik Ranocha](https://github.com/ranocha) (Johannes Gutenberg University Mainz, Germany) \
[Prof. Jesse Chan](https://github.com/jlchan) (University of Texas at Austin, U.S.) \
[Prof. Michael Schlottke-Lakemper](https://github.com/sloede) (University of Augsburg, Germany)

If you have any questions or find any issues, please contact the author, [Huiyu Xie](https://github.com/huiyuxie).
