PROGRAM RunRCopy(INPUT, OUTPUT);

PROCEDURE RCopy(VAR InFile: TEXT);
VAR
  Ch: CHAR;
BEGIN {RCopy}
  IF NOT EOLN(InFile)
  THEN
    BEGIN
      READ(InFile, Ch);
      WRITE(Ch);
      RCopy(InFile)
    END
END; {RCopy}

BEGIN {RunRCopy}
  RCopy(INPUT);
  WRITELN
END. {RunRCopy}
