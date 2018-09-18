library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
entity alu is
port(x, y : in std_logic_vector(31 downto 0);   -- two input operands
     add_sub : in std_logic;   -- 0 = add , 1 = sub
     logic_func : in std_logic_vector(1 downto 0 );   --  00 = AND, 01 = OR , 10 = XOR , 11 = NOR
     func       : in std_logic_vector(1 downto 0 );   --  00 = lui, 01 = setless , 10 = arith , 11 = logic
     output     : out std_logic_vector(31 downto 0);
     overflow   : out std_logic;
     zero       : out std_logic);
end alu;

architecture behav of alu is
signal logic_unit_out : std_logic_vector(31 downto 0);
signal ari_out : std_logic_vector(31 downto 0);
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

process(x,y,add_sub)   -- arithmetric
begin
if(add_sub='0')then
ari_out<=x + y;
elsif(add_sub='1')then
ari_out<=x - y;
else null;
end if;
end process;

process(ari_out)   -- zero
begin
if(ari_out=0)then
zero<='1';
else zero<='0';
end if;
end process;

process(x,y,add_sub,ari_out)   -- overflow
variable over_out : std_logic;
begin
over_out:='0';
if(add_sub='0')then
if(x(31)='0')and(y(31)='0')and(ari_out(31)='1')then
over_out:='1';
end if;
if(x(31)='1')and(y(31)='1')and(ari_out(31)='0')then
over_out:='1';
end if;
end if;
if(add_sub='1')then
if(x(31)/=y(31))then
over_out:='1';
end if;
end if;
overflow<=over_out;
end process;

process(x,y,ari_out,logic_unit_out,func,add_sub)   -- mul
begin
case func is
when "00"=>
output<=y;
when "01"=>
if(x < y)and(add_sub='1')then
output<=(0=>'1',others=>'0');
else output<=(others=>'0');
end if;
when "10"=>
output<=ari_out;
when "11"=>
output<=logic_unit_out;
when others=>
null;
end case;
end process;

end behav;
