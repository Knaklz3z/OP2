PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 6;
  ClassSize = 1;
  Base = 100;
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  Ave, TotalScore, ClassTotal: INTEGER;
  
BEGIN { AverageScore }
  ClassTotal := 0;
  WRITELN('Student averages:');
  Student := 1;
  WHILE Student <= ClassSize
  DO 
    BEGIN
      TotalScore := 0;
      WhichScore := 1;
      WHILE WhichScore <= NumberOfScores
      DO
        BEGIN
          READ(NextScore);
          TotalScore := TotalScore + NextScore;
          WhichScore := WhichScore + 1
        END;
      READLN;
      TotalScore := TotalScore * Base;
      Ave := TotalScore DIV NumberOfScores;
      IF Ave MOD Base >= (Base DIV 2)
      THEN
        WRITELN(Ave DIV Base + 1)
      ELSE
        WRITELN(Ave DIV Base);
      ClassTotal := ClassTotal + TotalScore;
      Student := Student + 1
    END;
  WRITELN;
  WRITELN('Class average:');
  ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
  WRITELN(ClassTotal DIV Base, '.', ClassTotal MOD Base:2)
END. { AverageScore }
