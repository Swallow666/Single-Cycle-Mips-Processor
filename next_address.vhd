library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity next_address is
port(rt, rs : in std_logic_vector(31 downto 0);
 -- two register inputs
 pc : in std_logic_vector(31 downto 0);
 target_address : in std_logic_vector(25 downto 0);
 branch_type : in std_logic_vector(1 downto 0);
 pc_sel : in std_logic_vector(1 downto 0);
 next_pc : out std_logic_vector(31 downto 0));
end next_address ;

architecture behav of next_address is
  signal offset: std_logic_vector(15 downto 0):=target_address(15 downto 0);
  begin
  process(pc_sel,branch_type,pc,rs,rt,offset,target_address)     --pc_sel, branch_type
  begin
  case pc_sel is
    when "00"=>
    case branch_type is
      when "00"=>
      next_pc<=std_logic_vector(unsigned(pc)+1);
      when "01"=>
      if (rs=rt)then
        next_pc<=std_logic_vector(signed(unsigned(pc)+1)+signed(offset));
      else next_pc<=std_logic_vector(unsigned(pc)+1);
      end if;
      when "10"=>
      if (rs/=rt)then
        next_pc<=std_logic_vector(signed(unsigned(pc)+1)+signed(offset));
      else next_pc<=std_logic_vector(unsigned(pc)+1);
      end if;
      when "11"=>
      if (signed(rs)<0)then
        next_pc<=std_logic_vector(signed(unsigned(pc)+1)+signed(offset));
      else next_pc<=std_logic_vector(unsigned(pc)+1);
      end if;
      when others=>
      null;
    end case;
    when "01"=>
    next_pc<="000000"&target_address;
    when "10"=>
    next_pc<=rs;
    when others=>
    null;
  end case;
  end process;
end behav;
