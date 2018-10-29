library ieee;
use ieee.std_logic_1164.all;
entity d_cache is
  port(
  reset: in std_logic;
  clk: in std_logic;
  data_write: in std_logic;
  a_in: in std_logic_vector(4 downto 0);
  din: in std_logic_vector(31 downto 0);
  d_out: out std_logic_vector(31 downto 0)
  );
end d_cache;

architecture behav of d_cache is
  begin
    process(reset,clk)
    begin
      if (reset='1') then
      elsif (clk'event and clk='1') then
      if (data_write='1') then
      end if;
      end if;
    end process;
end behav;
