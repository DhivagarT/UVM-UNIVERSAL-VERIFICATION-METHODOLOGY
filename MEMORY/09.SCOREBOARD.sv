import uvm_pkg::*;
`include "uvm_macros.svh"

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  virtual intf vif;
  uvm_analysis_imp#(transaction,scoreboard) scb_ap;
//   transaction trans;
  bit [7:0]exp_mem[3:0];
  bit [7:0]exp_out;
  int total_trans;
  int mismatch;
  
  function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
      total_trans=0;
    mismatch=0;
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual intf)::get(this,"*","vif",vif))begin
      `uvm_fatal("SCB","BUILD PHASE FOR SCOREBOARD IS NOT CREATED")
    end
    
    scb_ap=new("scb_ap",this);

  endfunction
  
  function void write(transaction trans);
    total_trans++;
    exp_out=exp_mem[trans.addr];
    
    if(trans.wr_enb)begin
      exp_mem[trans.addr]=trans.data_in;
    $display("WRITE ---  wr_enb=%d data_in=%d addr_in=%d",trans.wr_enb,trans.data_in,trans.addr);
    end
//     exp_out=exp_mem[trans.addr];
   
    
    if(exp_out==trans.data_out)
      $display("PASS ---  wr_enb=%d data_in=%d addr_in=%d EXP=%d ACTUAL=%d",trans.wr_enb,trans.data_in,trans.addr,exp_out,trans.data_out);
    else
      $display("FAIL ---  wr_enb=%d data_in=%d addr_in=%d EXP=%d ACTUAL=%d",trans.wr_enb,trans.data_in,trans.addr,exp_out,trans.data_out);
  endfunction
    
    function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SB_REPORT", $sformatf("Total Trans: %0d | Mismatches: %0d", total_trans, mismatch), UVM_LOW)
  endfunction

endclass
   
      
