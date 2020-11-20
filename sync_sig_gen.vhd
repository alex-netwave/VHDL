--this code generates:
--a pixel clock signal: 50% duty cycle, pixel frequency = 0.1 * frequency_of_clock
--an h-sync signal
--a v-sync signal
--a data enable signal


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity sync_sig_gen is
   port (clk : in std_logic;
        px_clk, de_sig, h_sig, v_sig: out std_logic);
end sync_sig_gen;

architecture Behavior of sync_sig_gen is
begin
	--pixel clock generator
   process(clk)
      type px_clk_statetype is (px_clk_LOW, px_clk_HIGH);
      variable px_clk_State : px_clk_statetype;
        variable count : integer := 9; --counter for low time
        variable countZ : integer := 9; --counter for high time
   begin	--begin is essentially a while loop
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
				count := 10;    --counter for low time
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
		--Potential solutions: 
		--1. using the clk instead of px_clk to generate de_sig[another process]
		--2. using px_clk to generate de_sig inside the body of the first begin[same process]
   end process;
	
	--Data Enable Generator
	process(clk)
		 type de_sig_statetype is (de_sig_LOW, de_sig_HIGH);
		 variable de_sig_State : de_sig_statetype;
			variable count : integer := 59; --counter for low time
			variable countZ : integer := 239; --counter for high time
	 begin	--begin is essentially a while loop
		 if (falling_edge(clk)) then
	
				 if (count /= 0) then
							count := count - 1;
				 -- Initial state - LOW
				 de_sig_State := de_sig_LOW;
					  elsif (countZ /= 0) then
							countZ := countZ - 1;
				 -- State transition - LOW TO HIGH
					  de_sig_State := de_sig_HIGH;
				 else
							count := 160;    --counter for low time
							countZ := 239; --counter for high time
			 end if;
	
			 -- State actions - setting the values of the output at each state name
			 case de_sig_State is
				 when de_sig_LOW =>
					de_sig<= '0';
	
				 when de_sig_HIGH =>
					de_sig<= '1';
			 end case;
		 end if;
	end process;
	
	--h-sync generator
	process(clk)
	  type h_sig_statetype is (h_sig_LOW, h_sig_HIGH);
	  variable h_sig_State : h_sig_statetype;
		variable count : integer := 09; --counter for low time
		variable countZ : integer := 389; --counter for high time
	 begin	--begin is essentially a while loop
	  if (falling_edge(clk)) then
		  if (count /= 0) then
			  count := count - 1;
		  -- Initial state - LOW
		  h_sig_State := h_sig_LOW;
		  elsif (countZ /= 0) then
			  countZ := countZ - 1;
		  -- State transition - LOW TO HIGH
			 h_sig_State := h_sig_HIGH;
		  else
			  count := 10;    --counter for low time
			  countZ := 389; --counter for high time
		 end if;
	
		 -- State actions - setting the values of the output at each state name
		 case h_sig_State is
		  when h_sig_LOW =>
			h_sig<= '0';
	
		  when h_sig_HIGH =>
			h_sig<= '1';
		 end case;
	  end if;
	end process;
	
	--v-sync generator
	process(clk)
	  type v_sig_statetype is (v_sig_LOW, v_sig_HIGH);
	  variable v_sig_State : v_sig_statetype;
	  variable count : integer := 09; --counter for low time
	  variable countZ : integer := 390; --counter for high time
	  variable count2 : integer := 10;
	  variable countZ2 : integer := 3190;--1169;
	  variable count3 : integer := 10;
	  variable countZ3 : integer := 1189;--3189;
	 begin	--begin is essentially a while loop
	  if (falling_edge(clk)) then
		 if (count /= 0) then
			count := count - 1;
		 -- Initial state - LOW
		 v_sig_State := v_sig_LOW;
		 elsif (countZ /= 0) then
			countZ := countZ - 1;
		 -- State transition - LOW TO HIGH
		  v_sig_State := v_sig_HIGH;
		 elsif (count2 /= 0) then
			count2 := count2 - 1;
			v_sig_State := v_sig_LOW;
		 elsif (countZ2 /= 0) then
			countZ2 := countZ2 - 1;
			v_sig_State := v_sig_HIGH;
		 elsif (count3 /= 0) then
			count3 := count3 - 1;
			v_sig_State := v_sig_LOW;
		 elsif (countZ3 /= 0) then
			countZ3 := countZ3 - 1;
			v_sig_State := v_sig_HIGH;
		 else
			count := 10;    --counter for low time
			countZ := 390; --counter for high time
			count2 := 10;    --counter for low time
			countZ2 := 3190; --counter for high time
			count3 := 10;    --counter for low time
			countZ3 := 1189; --counter for high time			
		 end if;
	
		-- State actions - setting the values of the output at each state name
		case v_sig_State is
		 when v_sig_LOW =>
		 v_sig<= '0';
	
		 when v_sig_HIGH =>
		 v_sig<= '1';
		end case;
	  end if;
	end process;
end Behavior;