library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WishboneSlave is
	port (
		clk_i		:  in std_logic;
		rst_i		:  in std_logic;

		adr_i		:  in std_logic_vector(31 downto 0);		-- is 20 downto 0
		dat_i		:  in std_logic_vector(31 downto 0);		
		dat_o		: out std_logic_vector(31 downto 0);
		ack_o		: out std_logic;
		cyc_i		:  in std_logic;	
--		stall_o	: out std_logic;
--		sel_i		:  in std_logic_vector(3 downto 0);			-- 2 masters and 2 slaves -- SDRAM has 3 downto 0
		stb_i		:  in std_logic;	
		we_i		:  in std_logic
	);
end entity;

architecture rtl of WishboneSlave is

--	type state_t is (IDLE, TEST_READ, TEST_WRITE);
	
--	signal state_s 		: state_t;
--	signal next_state_s	: state_t;
	
	signal reg_s1			: std_logic_vector(31 downto 0);
	signal reg_s2			: std_logic_vector(31 downto 0);
	

begin

	-- test reg 1
	process(clk_i) begin
		if(rising_edge(clk_i)) then
			if(rst_i = '0') then
				reg_s1 <= (others => '0');
			elsif(cyc_i = '1' and stb_i = '1' and we_i = '1') then
				if(adr_i(3 downto 0) = "1000") then
					reg_s1 <= dat_i;
				end if;
			end if;
		end if;
	end process;
	

	
	ack_o <= '1' when (cyc_i = '1' and stb_i = '1') else '0';
	
	dat_o <= reg_s1 when (cyc_i = '1' and stb_i = '1' and we_i = '0' and adr_i(3 downto 0) = "0000") else
				(others => '0');
	
	
--	RULE 3.30
--	SLAVE interfaces MAY NOT respond to any SLAVE signals when [CYC_I] is negated.
--	However, SLAVE interfaces MUST always respond to SYSCON signals.

--	RULE 3.35
--	In standard mode the cycle termination signals [ACK_O], [ERR_O], and [RTY_O] must be
--	generated in response to the logical AND of [CYC_I] and [STB_I].

--	RULE 3.50
--	SLAVE interfaces MUST be designed so that the [ACK_O], [ERR_O], and [RTY_O] signals
--	are asserted and negated in response to the assertion and negation of [STB_I].

--	RULE 3.65
--	SLAVE interfaces MUST qualify the following signals with [ACK_O], [ERR_O] or
--	[RTY_O]: [DAT_O()].






end architecture;