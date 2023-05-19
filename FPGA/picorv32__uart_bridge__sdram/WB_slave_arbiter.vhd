library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity wb_slave_arbiter is
  port (
	 -- master 2 slave signals
	 i_wb_cyc			: in	std_logic;
	 i_wb_stb			: in	std_logic;
	 i_wb_we			: in	std_logic;
	 i_wb_addr			: in	std_logic_vector(31 downto 0);
	 i_wb_data			: in	std_logic_vector(31 downto 0);
	 i_wb_sel			: in	std_logic_vector( 3 downto 0);
	 o_wb_stall			: out std_logic;
	 o_wb_ack			: out std_logic;
	 o_wb_data			: out std_logic_vector(31 downto 0);
	 -- BRAM
	 o_wb_bram_cyc		: out std_logic;
	 o_wb_bram_stb		: out std_logic;
	 o_wb_bram_we		: out std_logic;
--	 o_wb_bram_addr		: out std_logic_vector(13 downto 0);		--changed
	 o_wb_bram_addr		: out std_logic_vector(31 downto 0);
	 o_wb_bram_data		: out std_logic_vector(31 downto 0);
	 o_wb_bram_sel		: out std_logic_vector( 3 downto 0);
	 i_wb_bram_stall	: in  std_logic;
	 i_wb_bram_ack		: in  std_logic;
	 i_wb_bram_data		: in  std_logic_vector(31 downto 0);
	 -- SDRAM
	 o_wb_sdram_cyc		: out std_logic;
	 o_wb_sdram_stb		: out std_logic;
	 o_wb_sdram_we		: out std_logic;
	 o_wb_sdram_addr	: out std_logic_vector(20 downto 0);
	 o_wb_sdram_data	: out std_logic_vector(31 downto 0);
	 o_wb_sdram_sel		: out std_logic_vector( 3 downto 0);
	 i_wb_sdram_stall	: in  std_logic;
	 i_wb_sdram_ack		: in  std_logic;
	 i_wb_sdram_data	: in  std_logic_vector(31 downto 0);
	 -- MM REG
	 o_wb_mmreg_cyc		: out std_logic;
	 o_wb_mmreg_stb		: out std_logic;
	 o_wb_mmreg_we		: out std_logic;
	 o_wb_mmreg_addr	: out std_logic_vector(31 downto 0);
	 o_wb_mmreg_data	: out std_logic_vector(31 downto 0);
	 o_wb_mmreg_sel		: out std_logic_vector( 3 downto 0);
	 i_wb_mmreg_stall	: in  std_logic;
	 i_wb_mmreg_ack		: in  std_logic;
	 i_wb_mmreg_data	: in  std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of wb_slave_arbiter is
	
	signal s_select_output : std_logic_vector(1 downto 0);
	
begin

	-- BRAM addresses should be from 	0x00000000 to 0x00003fff
	-- SDRAM addresses should be from 	0x00400000 to 0x004fffff
	-- MM REG address is 0x10000000

--	s_select_output <= "00" when i_wb_addr(31 downto 14) = 0 else		-- BRAM
	s_select_output <= "00" when i_wb_addr(31 downto 15) = 0 else		-- BRAM
					   "01" when i_wb_addr(31 downto 22) = 1 else		-- SDRAM
					   "10" when i_wb_addr = x"10000000" else
					   "11";											-- seg fault
	process(s_select_output, 
	i_wb_cyc, i_wb_stb, i_wb_we, i_wb_addr, i_wb_data, i_wb_sel, 
	i_wb_bram_stall, i_wb_bram_ack, i_wb_bram_data, 
	i_wb_sdram_stall, i_wb_sdram_ack, i_wb_sdram_data,
	i_wb_mmreg_stall, i_wb_mmreg_ack, i_wb_mmreg_data)
	begin
		if(s_select_output = "00") then	-- BRAM selected
			--	BRAM
			o_wb_bram_cyc	<= i_wb_cyc;
			o_wb_bram_stb	<= i_wb_stb;
			o_wb_bram_we	<= i_wb_we;
			o_wb_bram_addr	<= x"0000" & "00" & i_wb_addr(13 downto 0);
			o_wb_bram_data	<= i_wb_data;
			o_wb_bram_sel	<= i_wb_sel;
			-- Slave 2 master outputs
			o_wb_stall		<= i_wb_bram_stall;
			o_wb_ack		<= i_wb_bram_ack;
			o_wb_data		<= i_wb_bram_data;
			--	SDRAM
			o_wb_sdram_cyc	<= '0';				-- should this be high Z?
			o_wb_sdram_stb	<= '0';
			o_wb_sdram_we	<= '0';
			o_wb_sdram_addr <= (others => '0');
			o_wb_sdram_data <= (others => '0');
			o_wb_sdram_sel	<= (others => '0');
			-- MM REG
			o_wb_mmreg_cyc	<= '0';				
			o_wb_mmreg_stb	<= '0';
			o_wb_mmreg_we	<= '0';
			o_wb_mmreg_addr <= (others => '0');
			o_wb_mmreg_data <= (others => '0');
			o_wb_mmreg_sel  <= (others => '0');
		elsif(s_select_output = "01") then	-- SDRAM selected
			--	BRAM
			o_wb_bram_cyc	<= '0';
			o_wb_bram_stb	<= '0';
			o_wb_bram_we	<= '0';
			o_wb_bram_addr	<= (others => '0');
			o_wb_bram_data	<= (others => '0');
			o_wb_bram_sel	<= (others => '0');
			-- Slave 2 master outputs
			o_wb_stall		<= i_wb_sdram_stall;
			o_wb_ack		<= i_wb_sdram_ack;
			o_wb_data		<= i_wb_sdram_data;
			--	SDRAM
			o_wb_sdram_cyc	<= i_wb_cyc;				-- should this be high Z?
			o_wb_sdram_stb	<= i_wb_stb;
			o_wb_sdram_we	<= i_wb_we;
			o_wb_sdram_addr <= i_wb_addr(20 downto 0);
			o_wb_sdram_data <= i_wb_data;
			o_wb_sdram_sel	<= i_wb_sel;
			-- MM REG
			o_wb_mmreg_cyc	<= '0';				
			o_wb_mmreg_stb	<= '0';
			o_wb_mmreg_we	<= '0';
			o_wb_mmreg_addr <= (others => '0');
			o_wb_mmreg_data <= (others => '0');
			o_wb_mmreg_sel  <= (others => '0');
		elsif(s_select_output = "10") then	-- MM REG selected
			--	BRAM
			o_wb_bram_cyc	<= '0';
			o_wb_bram_stb	<= '0';
			o_wb_bram_we	<= '0';
			o_wb_bram_addr	<= (others => '0');
			o_wb_bram_data	<= (others => '0');
			o_wb_bram_sel	<= (others => '0');
			-- Slave 2 master outputs
			o_wb_stall		<= i_wb_mmreg_stall;
			o_wb_ack			<= i_wb_mmreg_ack;
			o_wb_data		<= i_wb_mmreg_data;
			--	SDRAM
			o_wb_sdram_cyc	<= '0';				-- should this be high Z?
			o_wb_sdram_stb	<= '0';
			o_wb_sdram_we	<= '0';
			o_wb_sdram_addr <= (others => '0');
			o_wb_sdram_data <= (others => '0');
			o_wb_sdram_sel	<= (others => '0');
			-- MM REG
			o_wb_mmreg_cyc	<= i_wb_cyc;				
			o_wb_mmreg_stb	<= i_wb_stb;
			o_wb_mmreg_we	<= i_wb_we;
			o_wb_mmreg_addr <= i_wb_addr;
			o_wb_mmreg_data <= i_wb_data;
			o_wb_mmreg_sel  <= i_wb_sel;		
		else
			-- BRAM
			o_wb_bram_cyc	<= '0';
			o_wb_bram_stb	<= '0';
			o_wb_bram_we	<= '0';
			o_wb_bram_addr	<= (others => '0');
			o_wb_bram_data	<= (others => '0');
			o_wb_bram_sel	<= (others => '0'); 
			-- Slave 2 master outputs
			o_wb_stall		<= '1';
			o_wb_ack		<= '0';
			o_wb_data		<= (others => '0');
			--	SDRAM
			o_wb_sdram_cyc	<= '0';				-- should this be high Z?
			o_wb_sdram_stb	<= '0';
			o_wb_sdram_we	<= '0';
			o_wb_sdram_addr <= (others => '0');
			o_wb_sdram_data <= (others => '0');
			o_wb_sdram_sel  <= (others => '0'); 
			-- MM REG
			o_wb_mmreg_cyc	<= '0';				
			o_wb_mmreg_stb	<= '0';
			o_wb_mmreg_we	<= '0';
			o_wb_mmreg_addr <= (others => '0');
			o_wb_mmreg_data <= (others => '0');
			o_wb_mmreg_sel  <= (others => '0');
		end if;
	end process;

end architecture;
