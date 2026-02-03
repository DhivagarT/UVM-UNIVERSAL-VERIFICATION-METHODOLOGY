class my_cov extends uvm_subscriber#(seq_item);
  `uvm_component_utils(my_cov)
  
  seq_item tr;
  
  covergroup my_coverage;
    
    option.comment="Coverage for an Adder";
    
    val_A: coverpoint(tr.a)
    { 
      bins low_a  = {0};
      bins high_a = {1};
    }
    
    val_B: coverpoint(tr.b)
    { 
      bins low_b  = {0};
      bins high_b = {1};
    } 
    
    
    val_c: coverpoint(tr.c)
    { 
      bins low_b  = {0};
      bins high_b = {1};
    } 
    
    val_sum: coverpoint(tr.sum)
    { 
      bins low_b  = {0};
      bins high_b = {1};
    } 
    val_carry: coverpoint(tr.carry)
    { 
      bins low_b  = {0};
      bins high_b = {1};
    } 
  
    combi: cross val_A, val_B,val_c;
  endgroup: my_coverage
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
    my_coverage=new();
  endfunction: new
  
  function void write(seq_item t);
    tr=t;
    my_coverage.sample();
  endfunction
  
  function void report_phase(uvm_phase phase);
    `uvm_info(get_full_name(),$sformatf("Coverage is %0.2f %%", my_coverage.get_coverage()),UVM_MEDIUM);
  endfunction
endclass
    
