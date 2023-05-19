library ieee;
use ieee.std_logic_1164.ALL;

entity FSM is
  port (
    i_Clk       : in std_logic;
	 i_Rst		 : in std_logic;
    i_Data		 : in std_logic_vector(7 downto 0);
    i_Data_Valid: in std_logic;
	 o_WE			 : out std_logic_vector(3 downto 0)
    );
end FSM;

architecture rtl of FSM is 

	type t_state is (IDLE, ADDRESS, DATA, FINISH);
	
	signal s_State : t_state := IDLE;
	signal s_Next_state : t_state;
	signal s_Address : std_logic_vector(31 downto 0);
	signal s_Data : std_logic_vector(31 downto 0);
	signal s_Cnt : std_logic_vector(1 downto 0);

begin

	p_FSM_reg: process(i_Clk, i_Rst) 
	begin
		if(i_Rst = '1') then							--or '0'???
			s_State <= IDLE;
		elsif(rising_edge(i_Clk)) then
			s_State <= s_Next_state;
		end if;
	end process;
	
	p_FSM_Trans: process(s_State, i_Data, i_Data_Valid)
	begin
	
		case s_State is
			
			when IDLE =>
				if(i_Data_Valid = '1') then
					if(i_Data(7) = '1') then	--write request
						s_State <= ADDRESS;
					else
						s_Next_state <= IDLE;
					end if;
				else
					s_Next_state <= IDLE;
				end if;
				
			when ADDRESS =>
				-- add byte to address
				-- check counter
				-- read 4 bytes
				-- create address
				-- transition to data
				
			when DATA =>
				-- check counter
				-- read 4 bytes
				-- create data 
				-- transition to finish
				
			when others =>
				-- set we
				-- tranisition to IDLE
	
		end case;
	end process;



end rtl;