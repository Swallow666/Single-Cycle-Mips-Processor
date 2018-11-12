library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity cpu is
  port(
  reset: in std_logic;
  clk: in std_logic;
  rs_out, rt_out: out std_logic_vector(3 downto 0);
  pc_out: out std_logic_vector(3 downto 0);
  overflow, zero: out std_logic
  );
end cpu;

architecture behav of cpu is

  component alu
  port(
  x, y : in std_logic_vector(31 downto 0);
  add_sub : in std_logic;
  logic_func : in std_logic_vector(1 downto 0 );
  func       : in std_logic_vector(1 downto 0 );
  alu_output     : out std_logic_vector(31 downto 0);
  overflow   : out std_logic;
  zero       : out std_logic);
  end component;
  component control
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
  pc_sel: out std_logic_vector(1 downto 0));
  end component;
  component d_cache
  port(
  reset: in std_logic;
  clk: in std_logic;
  data_write: in std_logic;
  a_in: in std_logic_vector(4 downto 0);
  din: in std_logic_vector(31 downto 0);
  d_out: out std_logic_vector(31 downto 0));
  end component;
  component i_cache
  port(
  a_in: in std_logic_vector(4 downto 0);
  d_out: out std_logic_vector(31 downto 0));
  end component;
  component next_address
  port(
  rt, rs : in std_logic_vector(31 downto 0);
  pc : in std_logic_vector(31 downto 0);
  target_address : in std_logic_vector(25 downto 0);
  branch_type : in std_logic_vector(1 downto 0);
  pc_sel : in std_logic_vector(1 downto 0);
  next_pc : out std_logic_vector(31 downto 0));
  end component;
  component pc_reg
  port(
  reset: in std_logic;
  clk: in std_logic;
  pc_reg_in: in std_logic_vector(31 downto 0);
  pc_reg_out: out std_logic_vector(31 downto 0));
  end component;
  component regfile
  port(
  din : in std_logic_vector(31 downto 0);
  reset : in std_logic;
  clk : in std_logic;
  reg_write : in std_logic;
  read_a : in std_logic_vector(4 downto 0);
  read_b : in std_logic_vector(4 downto 0);
  write_address : in std_logic_vector(4 downto 0);
  out_a : out std_logic_vector(31 downto 0);
  out_b : out std_logic_vector(31 downto 0));
  end component;
  component sign_extend
  port(
  input_16: in std_logic_vector(15 downto 0);
  func: in std_logic_vector(1 downto 0);
  output_32: out std_logic_vector(31 downto 0));
  end component;

  signal pc_outer: std_logic_vector(31 downto 0);
  signal next_pc_outer: std_logic_vector(31 downto 0);
  signal i_cache_outer: std_logic_vector(31 downto 0);
  signal mula_outer: std_logic_vector(4 downto 0);
  signal regfile_outera: std_logic_vector(31 downto 0);
  signal regfile_outerb: std_logic_vector(31 downto 0);
  signal sign_extend_outer: std_logic_vector(31 downto 0);
  signal mulb_outer: std_logic_vector(31 downto 0);
  signal alu_outer: std_logic_vector(31 downto 0);
  signal d_cache_outer: std_logic_vector(31 downto 0);
  signal mulc_outer: std_logic_vector(31 downto 0);
  signal ctrl_reg_write: std_logic;
  signal ctrl_reg_dst: std_logic;
  signal ctrl_reg_in_src: std_logic;
  signal ctrl_alu_src: std_logic;
  signal ctrl_add_sub: std_logic;
  signal ctrl_data_write: std_logic;
  signal ctrl_logic_func: std_logic_vector(1 downto 0);
  signal ctrl_func: std_logic_vector(1 downto 0);
  signal ctrl_branch_type: std_logic_vector(1 downto 0);
  signal ctrl_pc_sel: std_logic_vector(1 downto 0);

  begin
    unit1: alu
    port map(x=>regfile_outera, y=>mulb_outer, add_sub=>ctrl_add_sub, logic_func=>ctrl_logic_func, func=>ctrl_func, alu_output=>alu_outer, overflow=>overflow, zero=>zero);
    unit2: control
    port map(op=>i_cache_outer(31 downto 26), funct=>i_cache_outer(5 downto 0), reg_write=>ctrl_reg_write, reg_dst=>ctrl_reg_dst, reg_in_src=>ctrl_reg_in_src, alu_src=>ctrl_alu_src, add_sub=>ctrl_add_sub, data_write=>ctrl_data_write, logic_func=>ctrl_logic_func, func=>ctrl_func, branch_type=>ctrl_branch_type, pc_sel=>ctrl_pc_sel);
    unit3: d_cache
    port map(reset=>reset, clk=>clk, data_write=>ctrl_data_write, a_in=>alu_outer(4 downto 0), din=>regfile_outerb, d_out=>d_cache_outer);
    unit4: i_cache
    port map(a_in=>pc_outer(4 downto 0), d_out=>i_cache_outer);
    unit5: next_address
    port map(rt=>regfile_outerb, rs=>regfile_outera, pc=>pc_outer, target_address=>i_cache_outer(25 downto 0), branch_type=>ctrl_branch_type, pc_sel=>ctrl_pc_sel, next_pc=>next_pc_outer);
    unit6: pc_reg
    port map(reset=>reset, clk=>clk, pc_reg_in=>next_pc_outer, pc_reg_out=>pc_outer);
    unit7: regfile
    port map(din=>mulc_outer, reset=>reset, clk=>clk, reg_write=>ctrl_reg_write, read_a=>i_cache_outer(25 downto 21), read_b=>i_cache_outer(20 downto 16), write_address=>mula_outer, out_a=>regfile_outera, out_b=>regfile_outerb);
    unit8: sign_extend
    port map(input_16=>i_cache_outer(15 downto 0), func=>ctrl_func, output_32=>sign_extend_outer);

    process(ctrl_reg_dst,i_cache_outer) --mul a
    begin
      if(ctrl_reg_dst='0')then
        mula_outer<=i_cache_outer(20 downto 16);
      else mula_outer<=i_cache_outer(15 downto 11);
      end if;
    end process;

    process(ctrl_alu_src,regfile_outerb,sign_extend_outer) --mul b
    begin
      if(ctrl_alu_src='0')then
        mulb_outer<=regfile_outerb;
      else mulb_outer<=sign_extend_outer;
      end if;
    end process;

    process(ctrl_reg_in_src,d_cache_outer,alu_outer) --mul c
    begin
      if(ctrl_reg_in_src='0')then
        mulc_outer<=d_cache_outer;
      else mulc_outer<=alu_outer;
      end if;
    end process;

    --negated output for FPGA LED
    rs_out<= not regfile_outera(3 downto 0);
    rt_out<= not regfile_outerb(3 downto 0);
    pc_out<= not pc_outer(3 downto 0);
end behav;
