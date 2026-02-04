`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
// `include "sequence_item.sv"

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  bit [2:0]expected_count;
  
  function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
 // virtual intf vif;
  uvm_analysis_imp#(transaction,scoreboard)ap_imp;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    ap_imp=new("ap_imp",this);
  endfunction
  
  function void write(transaction tx);
    if(tx.rst)begin
      expected_count=0;
    end
    else if(tx.enb) begin
      expected_count=expected_count+1'b1;
      end
      else
        expected_count=expected_count;
    
     // Compare expected vs actual
    if (tx.count !== expected_count) begin
      `uvm_info("SCOREBOARD",
        $sformatf("FAIL: Expected=%0d, Actual=%0d",
                  expected_count, tx.count),UVM_MEDIUM)
    end
    else begin
      `uvm_info("SCOREBOARD",
        $sformatf("PASS: Count matched = %0d", tx.count),
        UVM_MEDIUM)
    end
  endfunction
endclass
`endif
