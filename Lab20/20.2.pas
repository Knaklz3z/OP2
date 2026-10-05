PROGRAM XPrint(INPUT, OUTPUT);
CONST
  Size = 5;
  MaxLetters = 10;
  SymbolLetter = 'X';
  SymbolSpace = ' ';
  MatrixesFile = 'MATRIX.TXT';
  MatrixSize = Size * Size;
  TotalPoints = MaxLetters * MatrixSize; 
TYPE
  TypePoints = SET OF 1..TotalPoints;
  TypeMatrix = SET OF 1..MatrixSize;

FUNCTION GetMatrix(Ch: CHAR): TypeMatrix;
{ Принимает символ Ch - возвращает соответствующую матрицу,
если символа нет в файле - возвращает квадрат 5x5 }
VAR
  F: TEXT;
  FileChar: CHAR;
  Value: INTEGER;
  CurrentMatrix: TypeMatrix;
  Found: BOOLEAN;
BEGIN { GetMatrix }
  Found := FALSE;
  GetMatrix := [1..MatrixSize];
  ASSIGN(F, MatrixesFile);
  RESET(F);
  WHILE NOT EOF(F) AND NOT Found 
  DO
    BEGIN
      READ(F, FileChar);
      CurrentMatrix := [];
      WHILE NOT EOLN(F) 
      DO
        BEGIN
          READ(F, Value);
          IF (Value >= 1) AND (Value <= MatrixSize) 
          THEN
            CurrentMatrix := CurrentMatrix + [Value]
        END;
      READLN(F);
      Found := FileChar = Ch
    END;
  IF Found 
  THEN 
    GetMatrix := CurrentMatrix
END; { GetMatrix } 

PROCEDURE AddSymbolPoints(VAR GlobalSet: TypePoints; Matrix: TypeMatrix; SymbolIndex: INTEGER);
{ Добавляет точки одного символа в общее множество точек }
VAR
  Pos, GlobalIndex: INTEGER;
BEGIN { AddSymbolPoints }
  FOR Pos := 1 TO MatrixSize 
  DO
    IF Pos IN Matrix 
    THEN
      BEGIN
        GlobalIndex := (SymbolIndex - 1) * MatrixSize + Pos;
        GlobalSet := GlobalSet + [GlobalIndex]
      END
END; { AddSymbolPoints }

PROCEDURE WritePoint(SymIndex, RowIndex: INTEGER; GlobalSet: TypePoints);
{ Вывод одной точки }                                                                        
VAR
  Col, LocalPoint, GlobalIndex: INTEGER;
BEGIN { WritePoint }
  FOR Col := 1 TO Size 
  DO
    BEGIN
      LocalPoint := RowIndex * Size + Col;
      GlobalIndex := ((SymIndex - 1) * MatrixSize) + LocalPoint;
      IF GlobalIndex IN GlobalSet 
      THEN
        WRITE(SymbolLetter)
      ELSE
        WRITE(SymbolSpace)
    END
END; { WritePoint }
  
PROCEDURE OutputLine(GlobalSet: TypePoints; RowIndex: INTEGER; Count: INTEGER);
{ Печатает одну горизонтальную строку для всех введенных символов }
VAR
  SymIndex: INTEGER;
BEGIN { PrintScreenLine }
  FOR SymIndex := 1 TO Count 
  DO
    BEGIN
      WritePoint(SymIndex, RowIndex, GlobalSet);
      IF SymIndex < Count 
      THEN
        WRITE(SymbolSpace)
    END;  
  WRITELN
END; { PrintScreenLine }

PROCEDURE GetInputPoints(VAR AllPoints: TypePoints; VAR Count: INTEGER);
{ Считывает символы из INPUT и формирует общее множество точек }
VAR
  Ch: CHAR;
  Matrix: TypeMatrix;
BEGIN { CollectInputPoints }
  AllPoints := [];
  Count := 0;
  WHILE NOT EOLN(INPUT) AND (Count < MaxLetters) 
  DO
    BEGIN
      READ(INPUT, Ch);
      Count := Count + 1;
      Matrix := GetMatrix(Ch);
      AddSymbolPoints(AllPoints, Matrix, Count)
    END
END; { CollectInputPoints }

PROCEDURE OutputResult(AllPoints: TypePoints; Count: INTEGER);
{ Выводит результат в OUTPUT или сообщает об ошибке }
VAR
  Row: INTEGER;
BEGIN { DisplayResult }
  IF Count = 0 
  THEN
    WRITELN('Ошибка: отсутствуют символы')
  ELSE    
    FOR Row := 0 TO Size - 1 
    DO
      OutputLine(AllPoints, Row, Count)
END; { DisplayResult }

PROCEDURE RunXPrint;
{ Управляющая процедура }
VAR
  AllPoints: TypePoints;
  Count: INTEGER;
BEGIN { RunXPrint }
  GetInputPoints(AllPoints, Count);
  OutputResult(AllPoints, Count)
END; { RunXPrint }

BEGIN { XPrint }
  RunXPrint
END. { XPrint }
