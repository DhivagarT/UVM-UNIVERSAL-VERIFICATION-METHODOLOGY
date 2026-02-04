`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class env extends uvm_env;
  `uvm_component_utils(env)

  agent            ag;
  counter_coverage cvg;
  scoreboard       sb;

  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    ag  = agent::type_id::create("ag", this);
    cvg = counter_coverage::type_id::create("cvg", this);
    sb  = scoreboard::type_id::create("sb", this);

    `uvm_info("ENV", "Environment build_phase complete", UVM_MEDIUM)
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (ag.mon != null) begin
      ag.mon.ap.connect(sb.ap_imp);
      ag.mon.ap.connect(cvg.analysis_export);
    end
    else begin
      `uvm_fatal("ENV", "Monitor not created in agent")
    end

    `uvm_info("ENV", "Environment connect_phase complete", UVM_MEDIUM)
  endfunction

endclass

`endif



