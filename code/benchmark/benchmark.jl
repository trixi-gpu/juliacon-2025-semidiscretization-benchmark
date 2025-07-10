# This benchmark script runs all examples and plots the results in batch.
using Plots

# Figures will be saved in plots directory
mkdir("../plots")

# We have two approaches to run the examples:
# 1. Fixed DOFs: Total DOFs are held constant across dimensions by varying the per-dimension resolution.
# 2. Variable DOFs: Per-dimension resolution is held constant, so total DOFs vary with dimensions.
modes = [
    ("Fixed DOFs Approach", "examples_fixed_dofs"),
    ("Variable DOFs Approach", "examples_variable_dofs"),
]

# Name sanitizer for figure saving
function sanitize(s)
    t = replace(lowercase(s), r"[ \(\)\.,]" => "_")
    t = replace(t, r"_+" => "_")
    strip(t, '_')
end

# Benchmark examples
examples = [
    ("Linear Advection Equation (Basic)", [
        "advection_basic_1d.jl",
        "advection_basic_2d.jl",
        "advection_basic_3d.jl"
    ]),
    ("Linear Advection Equation (Mortar)", [
        "advection_mortar_2d.jl",
        "advection_mortar_3d.jl"
    ]),
    ("Euler Equations (Entropy Conservative)", [
        "euler_ec_1d.jl",
        "euler_ec_2d.jl",
        "euler_ec_3d.jl"
    ]),
    ("Euler Equations (Shock Capturing)", [
        "euler_shock_1d.jl",
        "euler_shock_2d.jl",
        "euler_shock_3d.jl"
    ]),
    ("MHD Equations (Entropy Conservative)", [
        "mhd_ec_1d.jl",
        "mhd_ec_2d.jl",
        "mhd_ec_3d.jl"
    ]),
    ("MHD Equations (Alfven Wave)", [
        "mhd_alfven_wave_1d.jl",
        "mhd_alfven_wave_2d.jl",
        "mhd_alfven_wave_3d.jl"
    ]),
    ("MHD Equations (Alfven Wave Mortar)", [
        "mhd_alfven_wave_mortar_2d.jl",
        "mhd_alfven_wave_mortar_3d.jl"
    ]),
    ("Hyperbolic Diffusion (Non-periodic)", [
        "hypdiff_nonperiodic_1d.jl",
        "hypdiff_nonperiodic_2d.jl",
        "hypdiff_nonperiodic_3d.jl"
    ]),
    ("Shallow Water (Entropy Conservative)", [
        "shallowwater_ec_1d.jl",
        "shallowwater_ec_2d.jl",
    ]),
    ("Shallow water (Source Terms)", [
        "shallowwater_source_terms_1d.jl",
        "shallowwater_source_terms_2d.jl",
    ])
]

# Loop over benchmark modes
for (mode, dir) in modes
    println("=============== Mode: $mode ===============")

    # Loop over benchmark examples
    for (i, (name, scripts)) in enumerate(examples)

        # Extract dimensions
        raw_dims = [match(r"_(\d)d\.jl$", script).captures[1] for script in scripts]
        dims = [uppercase(s) * "D" for s in raw_dims]

        # Initialize arrays for results
        cpu_medians = zeros(length(examples), length(dims))
        gpu_medians = zeros(length(examples), length(dims))
        cpu_means = zeros(length(examples), length(dims))
        gpu_means = zeros(length(examples), length(dims))
        dofs_array = zeros(length(examples), length(dims))

        for (j, script) in enumerate(scripts)
            # Build full paths by joining the directory
            full_script = joinpath.(dir, script)
            println("[$j] $name, running $full_script")

            include(full_script)

            # Convert to μs
            cpu_medians[i, j] = median(cpu_trial.times) * 10^-3
            gpu_medians[i, j] = median(gpu_trial.times) * 10^-3
            cpu_means[i, j] = mean(cpu_trial.times) * 10^-3
            gpu_means[i, j] = mean(gpu_trial.times) * 10^-3

            # Convert to log DOFs
            dofs_array[i, j] = log10(dofs)
        end

        # Extract results
        cpu_mean_vals = cpu_means[i, :]
        gpu_mean_vals = gpu_means[i, :]
        cpu_median_vals = cpu_medians[i, :]
        gpu_median_vals = gpu_medians[i, :]
        log_dofs_vals = dofs_array[i, :]

        # Determine x‐limits only when plotting two dimensions
        xlims_arg = length(dims) == 2 ? (-0.1, 2.1) : :nothing

        # Plot DOFs
        plt = plot(dims, log_dofs_vals;
            seriestype=:line,
            fillrange=0,
            fillalpha=0.2,
            linewidth=0,
            label="log₁₀(DOFs)",
            ylabel="log₁₀(DOFs)",
            xlabel="Dimension",
            legend=:bottomright,
            title=name,
            size=(500, 500),
            xlims=xlims_arg
        )

        plt2 = twinx(plt)

        # Plot mean with deviation - CPU
        plot!(plt2, dims, cpu_mean_vals;
            # yerror=cpu_stdev_vals,
            seriestype=:line,
            marker=:circle,
            label="Mean time CPU",
            ylabel="Time (μs)",
            legend=:topleft,
            linewidth=1.5,
            linestyle=:solid,
            color=:darkorange2,
            xlims=xlims_arg
        )

        # Plot mean mith deviation - GPU
        plot!(plt2, dims, gpu_mean_vals;
            # yerror=gpu_stdev_vals,
            seriestype=:line,
            marker=:circle,
            label="Mean time GPU",
            linewidth=1.5,
            linestyle=:solid,
            color=:green
        )

        # Plot median - CPU
        plot!(plt2, dims, cpu_median_vals;
            marker=:diamond,
            seriestype=:line,
            label="Median time CPU",
            linewidth=1.5,
            linestyle=:dash,
            color=:orange
        )

        # Plot median - GPU
        plot!(plt2, dims, gpu_median_vals;
            marker=:diamond,
            seriestype=:line,
            label="Median time GPU",
            linewidth=1.5,
            linestyle=:dash,
            color=:yellowgreen
        )

        # Save figures to plots directory
        safe_mode = sanitize(mode)
        safe_name = sanitize(name)
        fname = joinpath(
            "..", "plots",
            "$(safe_mode)_$(safe_name).png"
        )
        savefig(plt, fname)
        println("Saved: ", fname)
    end
end