library ieee;
use ieee.std_logic_1164.all;
entity i_cache is
  port(
  a_in: in std_logic_vector(4 downto 0);
  d_out: out std_logic_vector(31 downto 0)
  );
end i_cache;

architecture behav of i_cache is
  begin
    process(a_in)
    begin
      case a_in is
        when "00000"=>
        when "00001"=>
        when "00010"=>
        when "00011"=>
        when "00100"=>
        when "00101"=>
        when "00110"=>
        when "00111"=>
        when "01000"=>
        when "01001"=>
        when "01010"=>
        when "01011"=>
        when "01100"=>
        when "01101"=>
        when "01110"=>
        when "01111"=>
        when "10000"=>
        when "10001"=>
        when "10010"=>
        when "10011"=>
        when "10100"=>
        when "10101"=>
        when "10110"=>
        when "10111"=>
        when "11000"=>
        when "11001"=>
        when "11010"=>
        when "11011"=>
        when "11100"=>
        when "11101"=>
        when "11110"=>
        when "11111"=>
        when others=>
        null;
      end case;
    end process;
end behav;
