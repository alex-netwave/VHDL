--this code generates a pixel clock signal: 50% duty cycle, pixel frequency = 0.1 * frequency_of_clock
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity px_clk_gen is
   port (clk : in std_logic;
        px_clk: out std_logic);
end px_clk_gen;

architecture Behavior of px_clk_gen is
begin

   process(clk)
      type px_clk_statetype is (px_clk_LOW, px_clk_HIGH);
      variable px_clk_State : px_clk_statetype;
        variable count : integer := 9; --counter for low time
        variable countZ : integer := 9; --counter for high time
   begin
      if (falling_edge(clk)) then

            if (count /= 0) then
					count := count - 1;
            -- Initial state - LOW
            px_clk_State := px_clk_LOW;
				elsif (countZ /= 0) then
					countZ := countZ - 1;
            -- State transition - LOW TO HIGH
                px_clk_State := px_clk_HIGH;
            else
					count := 10;	--counter for low time
					countZ := 9; --counter for high time
         end if;

         -- State actions - setting the values of the output at each state name
         case px_clk_State is
            when px_clk_LOW =>
              px_clk<= '0';

            when px_clk_HIGH =>
              px_clk<= '1';
         end case;
      end if;
   end process;

end Behavior;