PROGRAM TestDateIO(INPUT, OUTPUT);
USES
  DateIO;
VAR
  M1: Month;
BEGIN
  ReadMonth(INPUT, M1);
  WriteMonth(OUTPUT, M1)
END.
