-- 32 x 32 register file
-- two read ports, one write port with write enable
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity regfile is
port( din : in std_logic_vector(31 downto 0);
reset : in std_logic;
clk : in std_logic;
reg_write : in std_logic;
read_a : in std_logic_vector(4 downto 0);
read_b : in std_logic_vector(4 downto 0);
write_address : in std_logic_vector(4 downto 0);
out_a : out std_logic_vector(31 downto 0);
out_b : out std_logic_vector(31 downto 0));
end regfile ;

architecture behav of regfile is
type registerfile is array(0 to 31) of std_logic_vector(31 downto 0);
signal registers : registerfile := (others=>(others=>'0'));
begin
process(reset,clk)          -- write
begin
if (reset='1') then
registers<=(others=>(others=>'0'));
elsif (clk'event and clk='1') then
if (reg_write='1') then
registers(conv_integer(write_address))<=din;
end if;
end if;
end process;
out_a<=registers(conv_integer(read_a));   -- read
out_b<=registers(conv_integer(read_b));
end behav;
