package tdc_wrapper_pkg;

  typedef enum logic[0:0]{
    PG_IN=1'b0,
    PG_TOG=1'b1
  } ctrl_pulse_src_t;

  typedef enum logic[0:0]{
    TOG_BYP=1'b0,
    TOG_REG=1'b1
  } ctrl_tog_t;

  typedef enum logic[1:0]{
    MUX=2'b0,
    ADD=2'b1
    // Add more as needed
  } ctrl_delay_line_t;

  typedef struct{
    ctrl_pulse_src_t ctl_pls_src,
    ctrl_tog_t ctl_tog,
    ctrl_delay_line_t ctl_delay_line
  } ctrl_csr;

  function void print_ctl_csr_status(
    ctrl_csr csr
  );
    $display(" * Control CSR state @time %0t:", $time());
    $display("   * Pulse source: ", csr.ctl_pls_src.name());
    $display("   *  Toggle mode: ", csr.ctl_tog.name());
    $display("   *   Delay line: ", csr.ctl_tog.name());
  endfunction : print_ctl_csr_status

endpackage : tdc_wrapper_pkg