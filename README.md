# FFTsForNavierStokes
Code based on a course project (CM501) at IIT Bombay 

# Download Julia from official Julia Programming language website

# Add necessary packages as dependency (FFTW.jl, Plots.jl, LazyGrids.jl)
```julia
using Pkg
Pkg.add("Plots.jl")
Pkg.add("LazyGrids.jl")
Pkg.add("FFTW.jl")
```
This should take a while for the first time.

# run following bash command to go to appropriate directory
```bash
cd /path_to_folder/FFTsForNavierStokes
```
# run following bash command to go to run julia-script for generating results
```bash
julia src/run.jl
```
This takes a while on laptop since this is a serial-code. Efforts to parallelise it are on-going
#run following bash command to go to run julia-script for generating contour/heatmap of vorticity fields
```bash
julia src/postprocess.jl
```


#change input parameters to play with the code!
