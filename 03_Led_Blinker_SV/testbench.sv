`timescale 1us/1ns  

module tutorial_led_blink_tb;
 
  reg r_CLOCK    = 1'b0;
  reg r_ENABLE   = 1'b0;
  reg r_SWITCH_1 = 1'b0;
  reg r_SWITCH_2 = 1'b0;

  wire w_LED_DRIVE;
  
  // Instancia de la unidad bajo prueba
  tutorial_led_blink UUT 
  (
    .i_clock(r_CLOCK),
    .i_enable(r_ENABLE),
    .i_switch_1(r_SWITCH_1),
    .i_switch_2(r_SWITCH_2),
    .o_led_drive(w_LED_DRIVE)
  );
  
  // Reloj a 25 KHz (Periodo 40us -> Invierte cada 20us)
  always #20 r_CLOCK <= !r_CLOCK;
  
  initial begin
    //esto para qeu se visualice en eda playground
    $dumpfile("dump.vcd");
    $dumpvars(0, tutorial_led_blink_tb);

    // Inicio de la prueba
    r_ENABLE <= 1'b1;
 
    r_SWITCH_1 <= 1'b0;
    r_SWITCH_2 <= 1'b0;
    #200000; // 0.2 segundos
     
    r_SWITCH_1 <= 1'b0;
    r_SWITCH_2 <= 1'b1;
    #200000;
     
    r_SWITCH_1 <= 1'b1;
    r_SWITCH_2 <= 1'b0;
    #500000;
 
    r_SWITCH_1 <= 1'b1;
    r_SWITCH_2 <= 1'b1;
    #2000000;
 
    $display("Test Complete");
    $finish; 
  end
   
endmodule
  