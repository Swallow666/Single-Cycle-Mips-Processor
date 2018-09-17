library IEEE;
use IEEE.std_logic_1164.all;
entity alu is
port(x, y : in std_logic_vector(31 downto 0); -- two input operands
 add_sub : in std_logic; -- 0 = add , 1 = sub
 logic_func : in std_logic_vector(1 downto 0 ); -- 00 = AND, 01 = OR , 10 = XOR , 11 = NOR
 func : in std_logic_vector(1 downto 0 ); -- 00 = lui, 01 = setless , 10 = arith , 11 = logic
 output : out std_logic_vector(31 downto 0);
 overflow : out std_logic;
 zero : out std_logic);
end alu;

architecture behav of alu is
  signal logic_unit_out : std_logic_vector(31 downto 0);
begin
  process(x,y,logic_func)   -- logic unit
  begin
    case logic_func is
      when "00"=>
      logic_unit_out<=x and y;
      when "01"=>
      logic_unit_out<=x or y;
      when "10"=>
      logic_unit_out<=x xor y;
      when "11"=>
      logic_unit_out<=x nor y;
      when others=>
      null;
    end case;
  end process;

end behav;
