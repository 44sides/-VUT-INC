-- fsm.vhd: Finite State Machine
-- Author(s): Vladyslav Tverdokhlib
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (NUM1, NUM2, NUM3, NUM4, NUM5, NUM6_1, NUM7_1, NUM8_1, NUM9_1, NUM10_1, NUM6_2, NUM7_2, NUM8_2, NUM9_2, NUM10_2, BAD_PASS, CORRECT_PASS, PRINT_DENIED, PRINT_ALLOWED, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= NUM1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when NUM1 =>
      next_state <= NUM1;
      if (KEY(1) = '1') then
         next_state <= NUM2; 
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM2 =>
      next_state <= NUM2;
      if (KEY(1) = '1') then
         next_state <= NUM3;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM3 =>
      next_state <= NUM3;
      if (KEY(7) = '1') then
         next_state <= NUM4;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM4 =>
      next_state <= NUM4;
      if (KEY(2) = '1') then
         next_state <= NUM5;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM5 =>
      next_state <= NUM5;
      if (KEY(6) = '1') then
         next_state <= NUM6_1;
		elsif (KEY(7) = '1') then
         next_state <= NUM6_2;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM6_1 =>
      next_state <= NUM6_1;
      if (KEY(1) = '1') then
         next_state <= NUM7_1;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM7_1 =>
      next_state <= NUM7_1;
      if (KEY(8) = '1') then
         next_state <= NUM8_1;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM8_1 =>
      next_state <= NUM8_1;
      if (KEY(1) = '1') then
         next_state <= NUM9_1;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM9_1 =>
      next_state <= NUM9_1;
      if (KEY(8) = '1') then
         next_state <= NUM10_1;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM10_1 =>
      next_state <= NUM10_1;
      if (KEY(1) = '1') then
         next_state <= CORRECT_PASS;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM6_2 =>
      next_state <= NUM6_2;
      if (KEY(0) = '1') then
         next_state <= NUM7_2;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM7_2 =>
      next_state <= NUM7_2;
      if (KEY(9) = '1') then
         next_state <= NUM8_2;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM8_2 =>
      next_state <= NUM8_2;
      if (KEY(0) = '1') then
         next_state <= NUM9_2;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM9_2 =>
      next_state <= NUM9_2;
      if (KEY(8) = '1') then
         next_state <= NUM10_2;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM10_2 =>
      next_state <= NUM10_2;
      if (KEY(8) = '1') then
         next_state <= CORRECT_PASS;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when BAD_PASS =>
      next_state <= BAD_PASS;
      if (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when CORRECT_PASS =>
      next_state <= CORRECT_PASS;
      if (KEY(15) = '1') then
         next_state <= PRINT_ALLOWED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD_PASS;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_DENIED =>
      next_state <= PRINT_DENIED;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_ALLOWED =>
      next_state <= PRINT_ALLOWED;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= NUM1; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= NUM1;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_DENIED =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
		FSM_MX_MEM     <= '0';
		if (CNT_OF = '0') then
         FSM_LCD_WR     <= '1';
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_ALLOWED =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
		FSM_MX_MEM     <= '1';
		if (CNT_OF = '0') then
         FSM_LCD_WR     <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
		if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      elsif (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   end case;
end process output_logic;

end architecture behavioral;

