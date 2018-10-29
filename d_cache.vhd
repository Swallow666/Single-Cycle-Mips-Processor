library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
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
  type dcache is array(0 to 31) of std_logic_vector(31 downto 0);
  signal datas: dcache:=(others=>(others=>'0'));
  begin
    process(reset,clk)
    begin
      if (reset='1') then
        datas<=(others=>(others=>'0'));
      elsif (clk'event and clk='1') then
      if (data_write='1') then
        datas(conv_integer(a_in))<=din;
      end if;
      end if;
    end process;
    d_out<=datas(conv_integer(a_in));
end behav;
