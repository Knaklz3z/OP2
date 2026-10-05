UNIT DateTools;

INTERFACE

TYPE
  Month = (NoMonth, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec);
  DayNum = 1..31;
  Date = RECORD
           Mo: Month;
           Day: DayNum
         END;
  FileOfDate = FILE OF Date;       

PROCEDURE WriteDate(VAR FOut: TEXT; VAR Res: Date);
PROCEDURE ReadDate(VAR FIn: TEXT; VAR Res: Date);
FUNCTION Less(VAR D1, D2: Date): BOOLEAN;
PROCEDURE CopyOut(VAR DateFile: FileOfDate);

IMPLEMENTATION

PROCEDURE ReadMonth(VAR FIn: TEXT; VAR Mo: Month);
{ Считывание месяца по символам }
VAR
  Ch1, Ch2, Ch3: CHAR;
BEGIN { ReadMonth }
  READ(FIn, Ch1, Ch2, Ch3);
  Mo := NoMonth;
  IF (Ch1 = 'J') AND (Ch2 = 'A') AND (Ch3 = 'N') THEN Mo := Jan ELSE
  IF (Ch1 = 'F') AND (Ch2 = 'E') AND (Ch3 = 'B') THEN Mo := Feb ELSE
  IF (Ch1 = 'M') AND (Ch2 = 'A') AND (Ch3 = 'R') THEN Mo := Mar ELSE
  IF (Ch1 = 'A') AND (Ch2 = 'P') AND (Ch3 = 'R') THEN Mo := Apr ELSE
  IF (Ch1 = 'M') AND (Ch2 = 'A') AND (Ch3 = 'Y') THEN Mo := May ELSE
  IF (Ch1 = 'J') AND (Ch2 = 'U') AND (Ch3 = 'N') THEN Mo := Jun ELSE
  IF (Ch1 = 'J') AND (Ch2 = 'U') AND (Ch3 = 'L') THEN Mo := Jul ELSE
  IF (Ch1 = 'A') AND (Ch2 = 'U') AND (Ch3 = 'G') THEN Mo := Aug ELSE
  IF (Ch1 = 'S') AND (Ch2 = 'E') AND (Ch3 = 'P') THEN Mo := Sep ELSE
  IF (Ch1 = 'O') AND (Ch2 = 'C') AND (Ch3 = 'T') THEN Mo := Oct ELSE
  IF (Ch1 = 'N') AND (Ch2 = 'O') AND (Ch3 = 'V') THEN Mo := Nov ELSE
  IF (Ch1 = 'D') AND (Ch2 = 'E') AND (Ch3 = 'C') THEN Mo := Dec
END; { ReadMonth }

PROCEDURE WriteMonth(VAR FOut: TEXT; VAR Mo: Month);
{ Вывод месяца }
VAR
  Ch1, Ch2, Ch3: CHAR;
BEGIN { WriteMonth }
  IF Mo = JAN THEN WRITE(FOut, 'JAN') ELSE
  IF Mo = FEB THEN WRITE(FOut, 'FEB') ELSE
  IF Mo = MAR THEN WRITE(FOut, 'MAR') ELSE
  IF Mo = APR THEN WRITE(FOut, 'APR') ELSE
  IF Mo = MAY THEN WRITE(FOut, 'MAY') ELSE
  IF Mo = JUN THEN WRITE(FOut, 'JUN') ELSE
  IF Mo = JUL THEN WRITE(FOut, 'JUL') ELSE
  IF Mo = AUG THEN WRITE(FOut, 'AUG') ELSE
  IF Mo = SEP THEN WRITE(FOut, 'SEP') ELSE
  IF Mo = OCT THEN WRITE(FOut, 'OCT') ELSE
  IF Mo = NOV THEN WRITE(FOut, 'NOV') ELSE
  IF Mo = DEC THEN WRITE(FOut, 'DEC')
  ELSE WRITE(FOut, 'NoMonth')
END; { WriteMonth }

PROCEDURE WriteDate(VAR FOut: TEXT; VAR Res: Date);
{ Вывод даты в FOut }
BEGIN { WriteDate }
  WriteMonth(FOut, Res.Mo);
  WRITE(FOut, Res.Day:3)
END; { WriteDate }

PROCEDURE ReadDate(VAR FIn: TEXT; VAR Res: Date);
{ Считывание даты из FIn }
BEGIN{ ReadDate }
  ReadMonth(FIn, Res.Mo);
  READ(FIn, Res.Day)
END;{ ReadDate }

FUNCTION Less(VAR D1, D2: Date): BOOLEAN;
{ Less := D1 < D2 }
BEGIN { Less }
  IF D1.Mo < D2.Mo
  THEN
    Less := TRUE
  ELSE
    IF D1.Mo > D2.Mo
      THEN
        Less := FALSE
      ELSE { D1.Mo = D2.Mo }
        Less := (D1.Day < D2.Day)
END; { Less }

PROCEDURE CopyOut(VAR DateFile: FileOfDate);
{ Вывод дат в OUTPUT }
VAR
  VarDate: Date;
BEGIN { CopyOut }
  WHILE NOT EOF(DateFile)
  DO
    BEGIN
      READ(DateFile, VarDate);
      WriteDate(OUTPUT, VarDate);
      WRITELN
    END
END; { CopyOut }

BEGIN { DateTools }
END. { DateTools }
