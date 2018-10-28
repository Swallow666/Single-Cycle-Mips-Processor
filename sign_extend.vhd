library ieee;
use ieee.std_logic_1164.all;
entity sign_extend is
  port(
  input_16: in std_logic_vector(15 downto 0);
  func: in std_logic_vector(1 downto 0);
  output_32: out std_logic_vector(31 downto 0)
  );
end sign_extend;

architecture behav of sign_extend is
  signal extend_bits: std_logic_vector(15 downto 0);
  begin
    process(input_16,func,extend_bits)
    begin
      case func is
        when "00"=>
        extend_bits<=(others=>'0');
        output_32<=input_16&extend_bits;
        when "01"|"10"=>
        extend_bits<=(others=>input_16(15));
        output_32<=extend_bits&input_16;
        when "11"=>
        extend_bits<=(others=>'0');
        output_32<=extend_bits&input_16;
        when others=>
        null;
      end case;
    end process;
end behav;
