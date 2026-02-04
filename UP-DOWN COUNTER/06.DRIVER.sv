`ifndef DRIVER_SV
`define DRIVER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_driver extends uvm_driver #(transaction);
  `uvm_component_utils(counter_driver)

  virtual intf vif;
  transaction trans;

  function new(string name="counter_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual intf)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(),
                 "Failed to get virtual interface in driver")
  endfunction

   task run_phase(uvm_phase phase);   
    super.run_phase(phase);

    trans = transaction::type_id::create("trans");

    forever begin
      seq_item_port.get_next_item(trans);   //get the data from sequence 
      drive_item(trans);                    //here is the pin-level transition occurs
      seq_item_port.item_done();//acknowledging the sequencer the transaction is completed send next
    end
  endtask
//   bit clk;  

  task drive_item(transaction trans);
    @(posedge vif.clk);               // wait for clock edge
    vif.rst <= trans.rst;
    vif.enb <= trans.enb;
  endtask

endclass

`endif
