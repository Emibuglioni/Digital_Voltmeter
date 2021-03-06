--ROM de caracteres
library IEEE ;
use IEEE.std_logic_1164.all ;
use IEEE.numeric_std.all;


entity rom is

  generic(

    A : integer := 4 ; --address
    F : integer := 3 ; -- fila
    C : integer := 3   -- columna

  ) ;

  port (

    char_address : in std_logic_vector ( A-1 downto 0 ) ;
    sub_fila : in std_logic_vector ( F-1 downto 0 ) ;
    sub_col : in std_logic_vector ( C-1 downto 0 ) ;

    rom_data : out std_logic

  );

end ;

architecture rom_arq of rom is

  -- defino mis sub_filas de la memoria como un sub_tipo de dato para despues meterlos a un vector
  subtype subfila is std_logic_vector ( 0 to 7 ) ;
  -- defino un tipo de variable para definir la memoria.
  --De 104 filas porque tengo 13 caracteres que ocupan 8 filas cada uno.
  type memoria is array ( 0 to 127 ) of subfila ;

  signal ROM : memoria := (
  -- cero
          "01111110",
          "01000010",
          "01000010",
          "01000010",
          "01000010",
          "01000010",
          "01111110",
          "00000000",
  -- uno
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000000",
  -- dos
          "01111110",
          "00000010",
          "00000010",
          "01111110",
          "01000000",
          "01000000",
          "01111110",
          "00000000",
  -- tres
          "01111110",
          "00000010",
          "00000010",
          "00111110",
          "00000010",
          "00000010",
          "01111110",
          "00000000",
  -- cuatro
          "01000010",
          "01000010",
          "01000010",
          "01000010",
          "01111110",
          "00000010",
          "00000010",
          "00000000",
  -- cinco
          "01111110",
          "01000000",
          "01000000",
          "01111110",
          "00000010",
          "00000010",
          "01111110",
          "00000000",
  -- seis
          "01111110",
          "01000000",
          "01000000",
          "01111110",
          "01000010",
          "01000010",
          "01111110",
          "00000000",
  -- siete
          "01111110",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000010",
          "00000000",
  -- ocho
          "00111100",
          "01000010",
          "01000010",
          "01111110",
          "01000010",
          "01000010",
          "00111100",
          "00000000",
  -- nueve
          "01111110",
          "01000010",
          "01000010",
          "01111110",
          "00000010",
          "00000010",
          "01111110",
          "00000000",
  -- punto
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00011000",
          "00011000",
          "00000000",
  -- volt
          "01000010",
          "01000010",
          "01000010",
          "00100100",
          "00100100",
          "00011000",
          "00011000",
          "00000000",
  -- blanco
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",

          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",

          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",

          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000",
          "00000000"

          );

  signal char_addr_aux : unsigned (6 downto 0) ;

  begin

    char_addr_aux <= unsigned(char_address) & unsigned(sub_fila) ;
    rom_data <= ROM(to_integer(char_addr_aux))(to_integer(unsigned(sub_col))) ;

end;
