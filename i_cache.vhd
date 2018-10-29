library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity i_cache is
  port(
  a_in: in std_logic_vector(4 downto 0);
  d_out: out std_logic_vector(31 downto 0)
  );
end i_cache;

architecture behav of i_cache is
  type icache is array(0 to 31) of std_logic_vector(31 downto 0);
  signal instructions: icache:=(others=>(others=>'0'));
  begin
    d_out<=instructions(conv_integer(a_in));
end behav;
