NAME=befwm
V=0.4
FOLD=~/.julia/v$(V)/$(NAME)

.PHONY: clean

clean:
	- rm src/*cov

test: src/*jl test/*jl
	-julia -e 'Pkg.rm("$(NAME)")'
	-julia -e 'Pkg.clone(pwd())'
	julia --code-coverage test/runtests.jl
	cd $(FOLD); julia -e 'Pkg.add("Coverage"); using Coverage; coverage = process_folder(); covered_lines, total_lines = get_summary(coverage); println(round(covered_lines/total_lines*100,2),"% covered")'

