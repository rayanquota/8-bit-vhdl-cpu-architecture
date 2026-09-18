LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY sseg IS
PORT (
    bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    neg : IN STD_LOGIC;
    leds, ledn : OUT STD_LOGIC_VECTOR(0 TO 6)
);
END sseg;

ARCHITECTURE Behavior OF sseg IS
BEGIN
PROCESS (bcd, neg)
BEGIN
    -- Sign logic
    IF (neg = '1') THEN
        ledn <= "1111110";  -- Show minus sign
    ELSE
        ledn <= "1111111";  -- Blank
    END IF;

    -- Character display logic
    CASE bcd IS  -- a b c d e f g
        WHEN "0000" => leds <= "0110110";  -- Y
        WHEN "0001" => leds <= "0010101";  -- N
        WHEN OTHERS => leds <= "0000000";  -- All off
    END CASE;
END PROCESS;
END Behavior;
