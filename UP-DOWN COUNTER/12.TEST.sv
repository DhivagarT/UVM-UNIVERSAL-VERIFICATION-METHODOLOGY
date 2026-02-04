`ifndef TEST_SV
`define TEST_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "package.sv"

class test extends uvm_test;
  `uvm_component_utils(test)

  env              env_h;
  counter_sequence seqb;

  function new(string name="test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_h = env::type_id::create("env_h", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    repeat(10)begin

    seqb = counter_sequence::type_id::create("seqb");
    seqb.start(env_h.ag.seqr);
    end
    
    phase.drop_objection(this);
    `uvm_info(get_type_name(), "Test completed", UVM_MEDIUM);
    
  endtask

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

endclass

`endif
