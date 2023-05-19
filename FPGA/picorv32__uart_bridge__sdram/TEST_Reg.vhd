library ieee;
use ieee.std_logic_1164.all;

entity TEST_Reg is					--this reg is for testing signals
  port (									--should be removed later in design
    i_Clk       : in  std_logic;
    i_Rstn 		 : in  std_logic;
	 i_WE 		 : in  std_logic;
	 o_Data		 : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of TEST_Reg is
	
	signal s_data : std_logic_vector(31 downto 0);
	
begin

	reg : process(i_Clk, i_Rstn) 
	begin
		if(i_Rstn = '0') then
			s_data <= (others => '0');
		elsif(rising_edge(i_Clk)) then
			if(i_WE = '1') then
--			if(i_Address = x"00001000") then
				s_data <= (others => '1');
--			else
--				s_data <= s_data;
			end if;
		end if;
	end process;

	o_Data <= s_data(7 downto 0);
	
end architecture;