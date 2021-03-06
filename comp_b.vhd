--comparador de 1 bit
library IEEE;
use IEEE.std_logic_1164.all;

entity comp1bit is

  port(

    ena : in std_logic ;
    a : in std_logic ;
    b : in std_logic ;

    s1 : out std_logic ; -- a>b
    s2 : out std_logic ; -- a=b
    s3 : out std_logic   -- a<b

  );

end;

architecture comp1bit_arq of comp1bit is

  signal out_xnor : std_logic ;

  begin

    s1 <= ena and a and not(b) ;
    out_xnor <= a xnor b ;
    s2 <= ena and out_xnor ;
    s3 <= ena and not(a) and b ;

end;
