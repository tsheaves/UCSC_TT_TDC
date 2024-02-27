package tdc_ifc_pkg;

  typedef enum logic[0:0]{
    "IPIN",
    "TOGGLE"
  } ctrl_pulse_src_t;

  typedef enum logic[0:0]{
    "TOG_FWD",
    "TOG_REG"
  } ctrl_tog_t;

  typedef enum logic[1:0]{
    "ADD",
    "BUF",
    "MUX",
    "AND"
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

endpackage : tdc_ifc_pkg