LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;

-- entity declaration for your testbench.Dont declare any ports here
entity CompareUnit_TB is 
end CompareUnit_TB;

architecture Behavioral of CompareUnit_TB is
  
   -- Component Declaration for the Unit Under Test (UUT)
    component COMPARE_Unit 

    port( POSITION	: in std_logic_vector(10 downto 0);
			    SAD		: in std_logic_vector(15 downto 0);
			    LOAD_EN	: in std_logic;
			    CLK		: in std_logic;
			    RESET		: in std_logic;
			    MINPOS	: out std_logic_vector(10 downto 0)
			   );
    end component;
    
   --declare inputs and initialize them
   
   --Control
   signal clk_i: std_logic;
   signal rst_i: std_logic;
   signal load_en: std_logic;
   
   --Data
   signal pos: std_logic_vector(10 downto 0);
   
   signal sad: std_logic_vector(15 downto 0);
   signal minpos: std_logic_vector(10 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin
   -- Instantiate the Unit Under Test (UUT)
   uut: COMPARE_Unit port map (pos, sad, load_en, clk_i, rst_i, minpos);
     
   -- Clock process definitions( clock with 50% duty cycle is generated here).
   clk_process :process
   begin
        clk_i <= '1';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk_i <= '0';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process;
           
   -- Stimulus process
  stim_proc: process
   begin
        --Reset system             
        wait for 7 ns;
        rst_i <= '1';
        wait for 3 ns;
        rst_i <='0';
        
        --Enable comparator
        wait for 10 ns;
        load_en <= '1';
        
        --Start data bombing
        wait for 10 ns;
        sad <= "1010111101101101";
        pos <= "10101111011";
        wait for 10 ns;
        sad <= "1010111101101111";
        pos <= "10101100001";
        wait for 10 ns;
        sad <= "0000000000000000";
        pos <= "10101111111";


        wait; -- Wait forever.
  end process;

end;

