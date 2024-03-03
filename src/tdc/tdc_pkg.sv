package tdc_pkg;

  typedef enum logic[0:0]{
    PG_IN=1'b0;
    PG_TOG=1'b1;
  } ctrl_pulse_src_t;

  typedef enum logic[0:0]{
    BYPASS=1'b0;
    REG=1'b1;
  } ctrl_bypass_t;

  typedef enum logic[0:0]{
    ADD=2'b1;
    // Add more as needed
  } ctrl_delay_line_t;

  typedef struct{
    ctrl_pulse_src_t ctl_pls_src;
    ctrl_bypass_t ctl_bypass;
  } ctrl_lines;

  function void print_ctl_line_status(
    ctrl_lines ctl_lines
  );
    $display(" * Control CSR state @time %0t:", $time());
    $display("   * Pulse source : ", ctl_lines.ctl_pls_src.name());
    $display("   * Toggle mode  : ", ctl_lines.ctl_tog.name());
  endfunction : print_ctl_line_status

endpackage : tdc_pkg
