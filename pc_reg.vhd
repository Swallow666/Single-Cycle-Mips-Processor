library ieee;
use ieee.std_logic_1164.all;
entity pc_reg is
  port(
  reset: in std_logic;
  clk: in std_logic;
  pc_reg_in: in std_logic_vector(31 downto 0);
  pc_reg_out: out std_logic_vector(31 downto 0)
  );
end pc_reg;

architecture behav of pc_reg is
  signal hook: std_logic_vector(31 downto 0);
  begin
    process(clk,reset)
    begin
      if(reset='1')then
        hook<=(others=>'0');
      elsif(clk'event and clk='1')then
        hook<=pc_reg_in;
      end if;
    end process;
    pc_reg_out<=hook;
end behav;
