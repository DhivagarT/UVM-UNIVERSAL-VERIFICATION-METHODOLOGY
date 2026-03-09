import uvm_pkg::*;
`include "uvm_macros.svh"
`include "package.sv"

class test extends uvm_test;
  `uvm_component_utils(test)
  
  sequ seqb;
  environment envr;
  
  function new(string name="test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      envr = environment::type_id::create("envr", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
        
    repeat(15) begin 
      seqb = sequ::type_id::create("seqb");
      #5; seqb.start(envr.ag.seqr);
    end
    
    phase.drop_objection(this);
    `uvm_info(get_type_name, "End of testcase", UVM_LOW);
  endtask
  
  virtual function void end_of_elaboration_phase (uvm_phase phase);
uvm_top.print_topology ();
endfunction
endclass

  

    
  
