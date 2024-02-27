# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# defaults
SRC_DIR = $(PWD)/../../src
PROJECT_SOURCES = tdc_wrapper_pkg.sv tt_tdc_pg_tdl.sv

ifneq ($(GATES),yes)

# RTL simulation:
SIM_BUILD = sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))
COMPILE_ARGS += -I$(SRC_DIR)

else

# Gate level simulation:
SIM_BUILD = sim_build/gl
COMPILE_ARGS += -DGL_TEST
COMPILE_ARGS += -DFUNCTIONAL
COMPILE_ARGS += -DUSE_POWER_PINS
COMPILE_ARGS += -DSIM
COMPILE_ARGS += -DUNIT_DELAY=\#1
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

# this gets copied in by the GDS action workflow
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

endif

# Include the testbench sources:
VERILOG_SOURCES += $(PWD)/tb_top.sv $(SRC_DIR)/tdc_ifc_pkg.sv

compile:
	vcs -sverilog -full64 -timescale=1ns/1ns $(VERILOG_SOURCES) -LDFLAGS -Wl,--no-as-needed

sim: compile
	./simv

clean:
	rm -rf ./simv

