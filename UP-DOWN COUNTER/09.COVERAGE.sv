class counter_coverage extends uvm_subscriber#(transaction);
  `uvm_component_utils(counter_coverage)

  bit tx_enb;
  bit tx_rst;

  covergroup my_cover;
    value_1 : coverpoint tx_enb {
      bins low_enb  = {0};
      bins high_enb = {1};
    }
    value_2 : coverpoint tx_rst {
      bins low_rst = {0};
      bins high_rst = {1};
    }
    combi:cross value_1,value_2;
    
  endgroup

  function new(string name="counter_coverage", uvm_component parent);
    super.new(name, parent);
    my_cover = new;
  endfunction

  function void write(transaction tr);
    tx_enb = tr.enb;
    tx_rst = tr.rst;
    my_cover.sample();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_full_name(),
      $sformatf("Coverage = %0.2f %%", my_cover.get_coverage()),
      UVM_MEDIUM)
  endfunction
endclass
