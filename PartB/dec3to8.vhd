LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dec3to8 IS
    PORT (
        x : IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3-bit input
        y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)      -- 8-bit one-hot output
    );
END dec3to8;

ARCHITECTURE Structure OF dec3to8 IS

    COMPONENT dec2to4
        PORT (
            w  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
            En : IN  STD_LOGIC;
            y  : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;

    SIGNAL y_low, y_high : STD_LOGIC_VECTOR(0 TO 3);

BEGIN

    -- Lower half decoder (y0 to y3), active when x(2) = '0'
    DEC_LOW: dec2to4 PORT MAP (
        w  => x(1 DOWNTO 0),
        En => NOT x(2),
        y  => y_low
    );

    -- Upper half decoder (y4 to y7), active when x(2) = '1'
    DEC_HIGH: dec2to4 PORT MAP (
        w  => x(1 DOWNTO 0),
        En => x(2),
        y  => y_high
    );

    -- Combine both halves into final output
    y <= y_low & y_high;

END Structure;