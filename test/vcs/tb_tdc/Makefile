VHEADERS = ""
VSOURCES =  \
    ../../../src/tdc/pop_count/pop_count_simple.sv \
    ../../../src/tdc/*.sv \
    ../../../src/tt_um_hsc_tdc.sv
    ./tb_tdc.sv
VCS_VFLAGS   += -M -L -ntb_opts tb_timescale=1ps/1ps -lca
VCS_VFLAGS   += -timescale=1ps/1ps -sverilog -full64 -licqueue -q
VCS_VFLAGS   += -assert svaext -undef_vcs_macro
VCS_VFLAGS   += +warn=noLCA_FEATURES_ENABLED
VCS_VFLAGS   += +warn=noMC-FCNAFTMI
VCS_VFLAGS   += +lint=all,TFIPC-L,noSVA-UA,noSVA-NSVU,noVCDE,noSVA-AECASR
VLDFLAGS     += -Wl,--no-as-needed
VCS_LDFLAGS  += $(foreach def,$(VLDFLAGS),-LDFLAGS "$(def)")
VCS_INCLUDES += $(foreach inc,$(VINCLUDES),+incdir+"$(inc)")
VCS_DEFINES  += $(foreach def,$(VDEFINES),+define+"$(def)")
VCS_FLAGS     = $(VCS_LDFLAGS) $(VCS_VFLAGS) $(VCS_INCLUDES) $(VCS_DEFINES)
VCS_FLAGS    += +plusarg_save +vcs+vcdpluson +vcs+vcdplusmemon +memcbk -debug_pp -assert enable_diag

VCS_VSOURCES  = $(VHEADERS) $(VSOURCES)

VCS_TOP       = tb_pop_count

.PHONY: sim
.PHONY: compile
.PHONY: simv
.PHONY: clean

sim: clean simv compile
	./simv -assert report+quiet+success

compile: clean
	vcs +define+ASSERT_ON -top $(VCS_TOP) $(VCS_VSOURCES) $(VCS_FLAGS)

clean:
	rm -rf ucli.key
	rm -rf .cxl* *.jou
	rm -rf *.daidir *.tmp
	rm -rf *.jou
	rm -rf *.vcs.log
	rm -rf vc_hdrs.h
	rm -rf *.debug *.profile
	rm -rf *.vcd
	rm -rf *.report
	rm -rf *.vpd
	rm -rf simv*
	rm -rf csrc
	rm -rf *.disablelog

