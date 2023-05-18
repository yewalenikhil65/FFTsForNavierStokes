## lets plan ffts and iffts first
ℱ = plan_fft(zeros(Nx,Nz))      # accepts real-spaced inputs
ℱ⁻¹ = plan_ifft(ℱ*zeros(Nx,Nz))