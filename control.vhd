library ieee;
use ieee.std_logic_1164.all;
entity control is
  port(
  op: in std_logic_vector(5 downto 0);
  funct: in std_logic_vector(5 downto 0);
  reg_write: out std_logic;
  reg_dst: out std_logic;
  reg_in_src: out std_logic;
  alu_src: out std_logic;
  add_sub: out std_logic;
  data_write: out std_logic;
  logic_func: out std_logic_vector(1 downto 0);
  func: out std_logic_vector(1 downto 0);
  branch_type: out std_logic_vector(1 downto 0);
  pc_sel: out std_logic_vector(1 downto 0)
  );
end control;

-- assign random values for all don't care condition
architecture behav of control is
  begin
    process(op,funct)
    begin
      case op is
        when "000000"=>
        case funct is
          when "100000"=> --add
          reg_write<='1';
          reg_dst<='1';
          reg_in_src<='1';
          alu_src<='0';
          add_sub<='0';
          data_write<='0';
          logic_func<="00";
          func<="10";
          branch_type<="00";
          pc_sel<="00";
          when "100010"=> --sub
          reg_write<='1';
          reg_dst<='1';
          reg_in_src<='1';
          alu_src<='0';
          add_sub<='1';
          data_write<='0';
          logic_func<="00";
          func<="10";
          branch_type<="00";
          pc_sel<="00";
          when "101010"=> --slt
          reg_write<='1';
          reg_dst<='1';
          reg_in_src<='1';
          alu_src<='0';
          add_sub<='1';
          data_write<='0';
          logic_func<="00";
          func<="01";
          branch_type<="00";
          pc_sel<="00";
          when "100100"=> --and
          reg_write<='1';
          reg_dst<='1';
          reg_in_src<='1';
          alu_src<='0';
          add_sub<='1';
          data_write<='0';
          logic_func<="00";
          func<="11";
          branch_type<="00";
          pc_sel<="00";
          when "100101"=> --or
          reg_write<='1';
          reg_dst<='1';
          reg_in_src<='1';
          alu_src<='0';
          add_sub<='0';
          data_write<='0';
          logic_func<="01";
          func<="11";
          branch_type<="00";
          pc_sel<="00";
          when "100110"=> --xor
          reg_write<='1';
          reg_dst<='1';
          reg_in_src<='1';
          alu_src<='0';
          add_sub<='0';
          data_write<='0';
          logic_func<="10";
          func<="11";
          branch_type<="00";
          pc_sel<="00";
          when "100111"=> --nor
          reg_write<='1';
          reg_dst<='1';
          reg_in_src<='1';
          alu_src<='0';
          add_sub<='0';
          data_write<='0';
          logic_func<="11";
          func<="11";
          branch_type<="00";
          pc_sel<="00";
          when "001000"=> --jr
          reg_write<='0';
          reg_dst<='1';
          reg_in_src<='1';
          alu_src<='0';
          add_sub<='0';
          data_write<='0';
          logic_func<="00";
          func<="10";
          branch_type<="00";
          pc_sel<="10";
          when others=>
          null;
        end case;
        when "001111"=> --lui
        reg_write<='1';
        reg_dst<='0';
        reg_in_src<='1';
        alu_src<='1';
        add_sub<='0';
        data_write<='0';
        logic_func<="00";
        func<="00";
        branch_type<="00";
        pc_sel<="00";
        when "001000"=> --addi
        reg_write<='1';
        reg_dst<='0';
        reg_in_src<='1';
        alu_src<='1';
        add_sub<='0';
        data_write<='0';
        logic_func<="00";
        func<="10";
        branch_type<="00";
        pc_sel<="00";
        when "001010"=> --slti
        reg_write<='1';
        reg_dst<='0';
        reg_in_src<='1';
        alu_src<='1';
        add_sub<='1';
        data_write<='0';
        logic_func<="00";
        func<="01";
        branch_type<="00";
        pc_sel<="00";
        when "001100"=> --andi
        reg_write<='1';
        reg_dst<='0';
        reg_in_src<='1';
        alu_src<='1';
        add_sub<='0';
        data_write<='0';
        logic_func<="00";
        func<="11";
        branch_type<="00";
        pc_sel<="00";
        when "001101"=> --ori
        reg_write<='1';
        reg_dst<='0';
        reg_in_src<='1';
        alu_src<='1';
        add_sub<='0';
        data_write<='0';
        logic_func<="01";
        func<="11";
        branch_type<="00";
        pc_sel<="00";
        when "001110"=> --xori
        reg_write<='1';
        reg_dst<='0';
        reg_in_src<='1';
        alu_src<='1';
        add_sub<='0';
        data_write<='0';
        logic_func<="10";
        func<="11";
        branch_type<="00";
        pc_sel<="00";
        when "100011"=> --lw
        reg_write<='1';
        reg_dst<='0';
        reg_in_src<='0';
        alu_src<='1';
        add_sub<='0';
        data_write<='0';
        logic_func<="10";
        func<="10";
        branch_type<="00";
        pc_sel<="00";
        when "101011"=> --sw
        reg_write<='0';
        reg_dst<='1';
        reg_in_src<='1';
        alu_src<='1';
        add_sub<='0';
        data_write<='1';
        logic_func<="00";
        func<="10";
        branch_type<="00";
        pc_sel<="00";
        when "000010"=> --j
        reg_write<='0';
        reg_dst<='1';
        reg_in_src<='1';
        alu_src<='0';
        add_sub<='0';
        data_write<='0';
        logic_func<="00";
        func<="10";
        branch_type<="00";
        pc_sel<="01";
        when "000001"=> --bltz
        reg_write<='0';
        reg_dst<='1';
        reg_in_src<='1';
        alu_src<='0';
        add_sub<='0';
        data_write<='0';
        logic_func<="00";
        func<="10";
        branch_type<="11";
        pc_sel<="00";
        when "000100"=> --beq
        reg_write<='0';
        reg_dst<='0';
        reg_in_src<='0';
        alu_src<='0';
        add_sub<='0';
        data_write<='0';
        logic_func<="00";
        func<="00";
        branch_type<="01";
        pc_sel<="00";
        when "000101"=> --bne
        reg_write<='0';
        reg_dst<='1';
        reg_in_src<='1';
        alu_src<='0';
        add_sub<='0';
        data_write<='0';
        logic_func<="00";
        func<="10";
        branch_type<="10";
        pc_sel<="00";
        when others=>
        null;
      end case;
    end process;
end behav;
