UNIT RunProgramUtils;

INTERFACE

USES
  LogicUtils, WordUtils, Dictionary, MergeUtils;

PROCEDURE RunWordsCounter(VAR IFile, OFile: TEXT);

IMPLEMENTATION

CONST
  Empty = '';
  TempFileName = 'TEMP.TXT';
  PortionFileName = 'PORTION.TXT';

PROCEDURE SaveWord(VAR CurrentWord: STRING);
{ Чистит слово и добавляет в дерево }
VAR
  CleanedWord: STRING;
BEGIN { SaveWord }
  CleanedWord := ClearString(CurrentWord);
  IF CleanedWord <> Empty
  THEN
    BEGIN
      IF IsUniqueLimitReached AND (NOT HasWord(CleanedWord))
      THEN
        Merge(TempFileName, PortionFileName);
      Insert(CleanedWord) 
    END;
  CurrentWord := Empty
END; { SaveWord }

PROCEDURE RunWordsCounter(VAR IFile, OFile: TEXT);
{ Один проход по INPUT, батчи в дереве, внешний merge на диске }
VAR
  Ch: CHAR;
  TempFile: TEXT;
  CurrentWord: STRING;
BEGIN { RunWordsCounter }
  CurrentWord := Empty;
  PrepareEmptyFile(TempFileName);
  PrepareEmptyFile(PortionFileName);
  WHILE NOT EOF(IFile)
  DO
    BEGIN
      READ(IFile, Ch);
      IF IsAllowedCHAR(Ch)
      THEN
        CurrentWord := CurrentWord + ToLowerCase(Ch)
      ELSE
        SaveWord(CurrentWord)
    END;
  SaveWord(CurrentWord);
  Merge(TempFileName, PortionFileName);
  ASSIGN(TempFile, TempFileName); 
  RESET(TempFile);
  CopyFile(TempFile, OFile);
END; { RunWordsCounter }

BEGIN { RunProgramUtils }
END. { RunProgramUtils }
