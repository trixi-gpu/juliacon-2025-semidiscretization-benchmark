# juliacon-2025-semidiscretization-benchmark
This repository provides the source code and instructions to reproduce the CPU and GPU semidiscretization performance benchmarks presented in the JuliaCon 2025 talk [TrixiCUDA.jl: CUDA Support for Solving Hyperbolic PDEs on GPU](https://pretalx.com/juliacon-2025/talk/EFYUBD/).

## Reproduce the Benchmarks
First, clone the repository to your local machine:
```
git clone https://github.com/trixi-gpu/juliacon-2025-semidiscretization-benchmark.git
```

Once the clone completes, move into the source directory:
```
cd juliacon-2025-semidiscretization-benchmark/code
```

Next, start Julia with the project environment and install all required packages:
```
julia --project=.
] instantiate
```

After dependencies have been fetched, precompile the core module:
```
include("src/TrixiCUDA.jl")
```

With the module precompiled, run the full benchmark suite:
```
include("benchmark/benchmark.jl")
```
You'll see progress and information printed to the terminal as each example runs, for example:
```
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
Sample benchmark results and their key takeaways are available [here](https://trixi-gpu.github.io/benchmark/).


## Acknowledgment
Many thanks to the following professors for their guidance on this project:

[Prof. Hendrik Ranocha](https://github.com/ranocha) (Johannes Gutenberg University Mainz, Germany) \
[Prof. Jesse Chan](https://github.com/jlchan) (University of Texas at Austin, U.S.) \
[Prof. Michael Schlottke-Lakemper](https://github.com/sloede) (University of Augsburg, Germany)

If you have any questions or find any issues, please contact the author, [Huiyu Xie](https://github.com/huiyuxie).
