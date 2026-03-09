import uvm_pkg::*;
`include "uvm_macros.svh"

class coverage extends uvm_subscriber#(transaction);
  `uvm_component_utils(coverage)
  
  bit rst;
  bit wr_enb;
  bit [7:0]data_in;
  bit [3:0]addr;
  
  covergroup covergb();
  
    value_2:coverpoint wr_enb{
      bins high_wr_enb={1};
      bins low_wr_enb={0};
    }
    value_3:coverpoint data_in{
      bins data_range={[0:255]};
    }
    value_4:coverpoint addr{
      bins addr_range={[0:15]};
    }
    
    cross value_2,value_3,value_4;
    
  endgroup
  
  function new(string name="coverage",uvm_component parent=null);
    super.new(name,parent);
    covergb=new();
  endfunction
  
  function void write(transaction tr);
    wr_enb=tr.wr_enb;
    data_in=tr.data_in;
    addr=tr.addr;
    
    covergb.sample();
  endfunction
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_full_name(),$sformatf("Coverage is %0.2f %%", covergb.get_coverage()),UVM_MEDIUM);
  endfunction
endclass
