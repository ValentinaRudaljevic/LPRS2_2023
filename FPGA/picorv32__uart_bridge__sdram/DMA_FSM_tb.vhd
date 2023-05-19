library ieee;
use ieee.std_logic_1164.all;

entity DMA_FSM_tb is
end DMA_FSM_tb;


architecture Test_tb of DMA_FSM_tb is

	signal s_Clk : std_logic;
	signal s_Rstn : std_logic;
	signal s_Data_Valid_w : std_logic;
	signal s_Data_Valid_r : std_logic;
	signal s_UART_Data : std_logic_vector(7 downto 0);
	signal s_MEM_Data : std_logic_vector(31 downto 0);
	signal so_Data : std_logic_vector(31 downto 0);
	signal s_Address : std_logic_vector(31 downto 0);
	signal s_WE : std_logic;
	
	signal s_TX_Active : std_logic;
	signal s_Byte : std_logic_vector(7 downto 0);

component DMA_FSM is
  port (
    i_Clk       : in  std_logic;	
    i_Rstn 		 : in  std_logic;
    i_Data_Valid: in  std_logic;
	 i_UART_Data : in  std_logic_vector(7 downto 0);
	 i_Mem_Data  : in  std_logic_vector(31 downto 0);
	 i_TX_Active : in  std_logic;
	 o_Data		 : out std_logic_vector(31 downto 0);
	 o_Byte		 : out std_logic_vector(7 downto 0);
	 o_Data_Valid: out std_logic;
	 o_Address	 : out std_logic_vector(31 downto 0);
    o_WE   		 : out std_logic
    );
end component;

	 constant clk_period : time := 80 ns;

begin
-- instanciranje i mapiranje glavnih portova i signala
	 uut : DMA_FSM port map (
		i_Clk 			=> s_Clk,
		i_Rstn		 	=> s_Rstn,
		i_Data_Valid	=> s_Data_Valid_w,
		i_UART_Data	 	=> s_UART_Data,
		i_Mem_Data		=> s_MEM_Data,
		i_TX_Active		=> s_TX_Active,
		o_Data 			=> so_Data,
		o_Byte			=> s_Byte,
		o_Data_Valid	=> s_Data_Valid_r,
		o_Address		=> s_Address,
		o_WE 				=> s_WE
	 );
	 
	clk_process :process
	begin
	  s_Clk <= '0';
	  wait for clk_period/2;  
	  s_Clk <= '1';
	  wait for clk_period/2;  
   end process;

	stimulus : process
	begin
		s_Rstn <= '0';
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
		s_MEM_Data <= x"00000000";
		s_TX_Active <= '0';
		wait for 100 * clk_period;
		
		s_Rstn <= '1';
		wait for 10 * clk_period;
		
---------- start byte ------------------------------
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"80";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
---------- 1st data size byte ------------------------data size 4
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"04";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		-- 2nd data size byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"00";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		-- 3rd data size byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"00";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
---------- 1st address byte -----------------------address 0x0000 0010
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"10";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		-- 2nd address byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"00";
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		-- 3rd address byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"00";
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		-- 4th address byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"00";
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		
---- data are 0123456789ABCDEF
--
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"00";	-- 0
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"01"; -- 1	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"02";	-- 2
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"03";	-- 3
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"04";	-- 4
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"05";	-- 5
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"06";	-- 6
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"07";	-- 7
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"08";	-- 8
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"09";	-- 9
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"0A";	-- A
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"0B";	-- B
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"0C";	-- C
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"0D";	-- D
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"0E";	-- E
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= x"0F";	-- F
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= x"00";
--		wait for 980 * clk_period;
		
--		------------------------------------------------------------
--		
--		wait for 1980 * clk_period;		-- break before next request
--		
--		------------------------------------------------------------
--
--		-------- start byte ------------------------------
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "10000000";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
---------- 1st data size byte ------------------------data size 4
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000100";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		-- 2nd data size byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000000";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		-- 3rd data size byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000000";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--	-------- 1st address byte -----------------------address 0x0000 0020
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00100000";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		-- 2nd address byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000000";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		-- 3rd address byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000000";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		-- 4th address byte
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000000";	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;	
--		
---- data are 0123456789ABCDEF
--
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000000";	-- 0
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000001"; -- 1	
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000010";	-- 2
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000011";	-- 3
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000100";	-- 4
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000101";	-- 5
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000110";	-- 6
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00000111";	-- 7
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00001000";	-- 8
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00001001";	-- 9
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00001010";	-- A
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00001011";	-- B
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00001100";	-- C
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00001101";	-- D
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00001110";	-- E
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		s_Data_Valid_w <= '1';
--		s_UART_Data <= "00001111";	-- F
--		wait for 1 * clk_period;
--		
--		s_Data_Valid_w <= '0';
--		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
--		
--		------------------------------------------------------------
--		
--		wait for 1980 * clk_period;		-- break before next request
--		
--		------------------------------------------------------------
--		
-- read
		s_MEM_Data <= x"BABADEDA";

---------- start byte ------------------------------
		s_Data_Valid_w <= '1';
		s_UART_Data <= "01000000";	
		wait for 1 * clk_period;
		
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
		wait for 980 * clk_period;
			
-------- 1st data size byte ------------------------data size8
		s_Data_Valid_w <= '1';
		s_UART_Data <= "00001000";	
		wait for 1 * clk_period;
		
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
		wait for 980 * clk_period;
		
		-- 2nd data size byte
		s_Data_Valid_w <= '1';
		s_UART_Data <= "00000000";	
		wait for 1 * clk_period;
		
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
		wait for 980 * clk_period;
		
		-- 3rd data size byte
		s_Data_Valid_w <= '1';
		s_UART_Data <= "00000000";	
		wait for 1 * clk_period;
		
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
		wait for 980 * clk_period;
		
-------- 1st address byte -----------------------address 0x0000 0010
		s_Data_Valid_w <= '1';
		s_UART_Data <= "00010000";	
		wait for 1 * clk_period;
		
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
		wait for 980 * clk_period;
		
		-- 2nd address byte
		s_Data_Valid_w <= '1';
		s_UART_Data <= "00000000";	
		wait for 1 * clk_period;
		
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
		wait for 980 * clk_period;
		
		-- 3rd address byte
		s_Data_Valid_w <= '1';
		s_UART_Data <= "00000000";	
		wait for 1 * clk_period;
		
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
		wait for 980 * clk_period;
		
		-- 4th address byte
		s_Data_Valid_w <= '1';
		s_UART_Data <= "00000000";	
		wait for 1 * clk_period;
		
		s_Data_Valid_w <= '0';
		s_UART_Data <= "00000000";
--		wait for 980 * clk_period;
			
---- transmision
		wait until (s_Data_Valid_r = '1');
		
		s_MEM_Data <= x"FEEDBEEF";
		
		s_TX_Active <= '1';
--		wait for 980 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '0';
--		wait for 10 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '1';
--		wait for 980 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '0';
--		wait for 10 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '1';
--		wait for 980 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '0';
--		wait for 10 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '1';
--		wait for 980 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '0';
		wait for 4 * clk_period;


		
--		wait until (s_Data_Valid_r = '1');

		s_TX_Active <= '1';
--		wait for 980 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '0';
--		wait for 10 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '1';
--		wait for 980 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '0';
--		wait for 10 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '1';
--		wait for 980 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '0';
--		wait for 10 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '1';
--		wait for 980 * clk_period;
		wait for 4 * clk_period;
		
		s_TX_Active <= '0';
		wait for 10 * clk_period;
		
		wait;
	end process;
	
end architecture; 