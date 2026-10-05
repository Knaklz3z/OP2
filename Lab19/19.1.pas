PROGRAM Prime(INPUT, OUTPUT);
{ Находит простые числа в диапазоне методом "Решето Эратосфена" }
CONST
  MinNum = 2;
  MaxNum = 100;
  Step = 1;
TYPE
  PrimeRange = MinNum .. MaxNum;
  PrimeSet = SET OF PrimeRange;
VAR
  Numbers: PrimeSet;
  
PROCEDURE Start;
{ Начало программы }
BEGIN { Start }
  Numbers := [MinNum .. MaxNum];
  WRITE('Простые числа в диапазоне до ', MaxNum, ':')
END; { Start } 

PROCEDURE FindPrimeNum(VAR Numbers: PrimeSet);
{ Получение простых чисел и вывод }
VAR
  CurrentNumber, NumToDel: INTEGER;
BEGIN { FindPrimeNum }
  CurrentNumber := MinNum;
  WHILE CurrentNumber <= MaxNum
  DO
    BEGIN
      IF CurrentNumber IN Numbers
      THEN
        BEGIN
          WRITE(' ', CurrentNumber);
          NumToDel := CurrentNumber;
          WHILE NumToDel <= MaxNum
          DO
            BEGIN
              Numbers := Numbers - [NumToDel];
              NumToDel := NumToDel + CurrentNumber
            END
        END;
      CurrentNumber := CurrentNumber + Step  
    END
END; { FindPrimeNum }
  
BEGIN { Prime }
  Start;
  FindPrimeNum(Numbers);
  WRITELN  
END. { Prime }   
