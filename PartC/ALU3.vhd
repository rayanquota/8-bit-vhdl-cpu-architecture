LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU3 IS
    PORT (
        clk, reset       : IN  std_logic;
        opcode         : IN  std_logic_vector(7 DOWNTO 0);
        student_id     : IN  std_logic_vector(3 DOWNTO 0); -- added for parity check
        Result         : BUFFER std_logic_vector(7 DOWNTO 0);
        Upper4         : OUT std_logic_vector(3 DOWNTO 0);
        Lower4         : OUT std_logic_vector(3 DOWNTO 0);
        MSB_lower      : OUT std_logic;
        MSB_upper      : OUT std_logic
    );
END ALU3;

ARCHITECTURE calculation OF ALU3 IS

    -- Function to calculate odd parity
    FUNCTION odd_parity(x : std_logic_vector) RETURN std_logic IS
        VARIABLE count : integer := 0;
    BEGIN
        FOR i IN x'range LOOP
            IF x(i) = '1' THEN
            count := count + 1;
            END IF;
        END LOOP;
        IF (count MOD 2) = 1 THEN
        RETURN '1';
        ELSE
        RETURN '0';
        END IF;
    END;

BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '0' THEN
            Result <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            CASE opcode IS
                WHEN "00000001" =>  -- Check parity
                    IF odd_parity(student_id) = '1' THEN
                        Result <= "10110110";  -- 'Y'
                    ELSE
                        Result <= "10010101";  -- 'N'
                    END IF;
                WHEN OTHERS =>
                    NULL;
            END CASE;
        END IF;
    END PROCESS;

    -- Output slices
    Upper4    <= Result(7 DOWNTO 4);
    Lower4    <= Result(3 DOWNTO 0);
    MSB_upper <= Result(7);
    MSB_lower <= Result(3);

END calculation;
