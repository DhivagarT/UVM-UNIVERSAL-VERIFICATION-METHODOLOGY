import uvm_pkg::*;
`include "uvm_macros.svh"

class coverage extends uvm_subscriber#(transaction);
  `uvm_component_utils(coverage)
  
  bit cv_rst;
  bit cv_d;
  
  covergroup my_coverage;
    value_1 : coverpoint cv_rst{
      bins low_rst={0};
      bins high_rst={1};
    }
    value_2 : coverpoint cv_d{
      bins low_d={0};
      bins high_d={1};
    }
    
    comb:cross value_1,value_2;
    
  endgroup
  
  function new(string name="coverage",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info(get_type_name(),"COVERAGE CONSTRUCTOR",UVM_MEDIUM)
    my_coverage=new();
  endfunction
  
  function void write(transaction tr);
    cv_rst=tr.rst;
    cv_d=tr.d;
    my_coverage.sample();
  endfunction
  
  function void report_phase(uvm_phase phase);
    `uvm_info(get_full_name(),$sformatf("Coverage is %0.2f %%", my_coverage.get_coverage()),UVM_MEDIUM);
  endfunction
  
endclass
  
  
    
    
