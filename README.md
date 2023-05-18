# FFTsForNavierStokes
Code based on a course project ([CM501, Advanced Computational Methods 
for 
Turbulent Incompressible Flow](https://sites.google.com/view/iitb-sravichandran/teaching/cm501)) at IIT Bombay. Course Instructor : [Prof. S. Ravichandran](https://www.climate.iitb.ac.in/en/employee-profile/prof-s-ravichandran)

The repository contains a 2D FFT based pseudospectral code written in Julia language for simulating vortex-merger of two co-rotating gaussian vortices inspired from the journal paper in 
Journal of Fluid Mechanics, [LAURA K. BRANDT and KEIKO K. NOMURA, The physics of vortex merger and the effects of ambient stable stratification](https://www.cambridge.org/core/journals/journal-of-fluid-mechanics/article/physics-of-vortex-merger-and-the-effects-of-ambient-stable-stratification/E4355A389F2F13798B7290A5B50C2A15)
## Caveats
- Serial implementation. Parallelisation in progress!
- Non-robust
- Needs rigourous validation

## Steps to proceed
#### Download Julia from official Julia Programming language website

#### Add necessary packages as dependency (FFTW.jl, Plots.jl, LazyGrids.jl)
```julia
using Pkg
Pkg.add("Plots.jl")
Pkg.add("LazyGrids.jl")
Pkg.add("FFTW.jl")
```
This should take a while for the first time.

#### run following bash command to go to appropriate directory
```bash
cd /path_to_folder/FFTsForNavierStokes
```
#### run following bash command to go to run julia-script for generating results
```bash
julia src/run.jl
```
This takes a while on laptop since this is a serial-code. Efforts to parallelise it are on-going
#run following bash command to go to run julia-script for generating contour/heatmap of vorticity fields
```bash
julia src/postprocess.jl
```


#### change input parameters to play with the code!
