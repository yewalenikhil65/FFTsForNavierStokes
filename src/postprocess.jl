using Plots
using DelimitedFiles

path = pwd()*"/src/vorticity"

cd(path)

files = ["w_$(i).0.csv" for i in 0:15]

# files_to_keep = readdir()
# files_to_act_on = filter(t -> t in files_to_keep, readdir())

for (iter,file) in enumerate(files)
    ω = readdlm(file,',',Float64)
    contour((0:512-1)*(1/512), (0:512-1)*(1/512), ω, size = (500,600),  color=:turbo, lw=4)
    xlabel!("x")
	ylabel!("z")
    annotate!(xtickfontsize=12,ytickfontsize=12, xguidefontsize=18,
            yguidefontsize=18, legendfontsize=12,title = "ω(x,z,t = $(iter-1))")
    savefig("./w_contour_$(iter-1).pdf")
    heatmap((0:512-1)*(1/512), (0:512-1)*(1/512), ω, size = (500,600), color=:turbo, lw=4)
    annotate!(xtickfontsize=12,ytickfontsize=12, xguidefontsize=18,
            yguidefontsize=18, legendfontsize=12,title = "ω(x,z,t = $(iter-1))")
    xlabel!("x")
	ylabel!("z")
    savefig("./w_surf_$(iter-1).pdf")
end
 
println("Export Contours of vorticity !")
