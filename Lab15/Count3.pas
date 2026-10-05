UNIT Count3;

INTERFACE

PROCEDURE Start; { Сбрасывает счетчик в 0 }
PROCEDURE Bump; { Увеличивает счетчик на 1 }
PROCEDURE Value (VAR V100, V10, V1: CHAR); { Возвращает содержимое счетчика }

IMPLEMENTATION

VAR
  Ones, Tens, Hundreds: CHAR;

PROCEDURE Start;
{ Сбрасывает переменные Ones, Tens, Hundreds в '0' }
BEGIN{ Start }
  Ones := '0';
  Tens := '0';
  Hundreds := '0'
END;{ Start }

PROCEDURE NextDigit(VAR Digit: CHAR);
{ Увеличиваем Digit на 1 }
BEGIN { NextDigit }
  IF Digit = '0' THEN Digit := '1' ELSE
  IF Digit = '1' THEN Digit := '2' ELSE
  IF Digit = '2' THEN Digit := '3' ELSE
  IF Digit = '3' THEN Digit := '4' ELSE
  IF Digit = '4' THEN Digit := '5' ELSE
  IF Digit = '5' THEN Digit := '6' ELSE
  IF Digit = '6' THEN Digit := '7' ELSE
  IF Digit = '7' THEN Digit := '8' ELSE
  IF Digit = '8' THEN Digit := '9' ELSE
  IF Digit = '9' THEN Digit := '0'
END; { NextDigit }

PROCEDURE Bump;
{ Увеличивает 3-цифровой счетчик определенный Ones, Tens, Hundreds
на единицу, если он находится в диапaзоне от 0 до 999 }  
BEGIN { Bump }
  NextDigit(Ones);
  IF Ones = '0'
  THEN
    BEGIN
      NextDigit(Tens);
      IF Tens = '0'
      THEN
        BEGIN
          NextDigit(Hundreds);
          IF Hundreds = '0'
          THEN
            BEGIN
              Ones := '9';
              Tens := '9';
              Hundreds := '9'
            END
        END
    END
END; { Bump }
    
PROCEDURE Value(VAR V100, V10, V1: CHAR);
{ Возвращает значение счетчика за счет
полученных переменных Ones, Tens, Hundreds }
BEGIN { Value }
  V100 := Hundreds;
  V10 := Tens;
  V1 := Ones
END { Value };
      
BEGIN {UNIT Count3}
  Start
END. {UNIT Count3}
