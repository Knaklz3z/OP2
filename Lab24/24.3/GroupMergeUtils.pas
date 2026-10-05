UNIT GroupMergeUtils;

INTERFACE

USES
  GroupTypes, GroupLogicUtils, GroupWordUtils, GroupDictionary;

PROCEDURE PrepareEmptyFile(FileName: STRING);
PROCEDURE Merge(TempFileName, PortionFileName: STRING);
PROCEDURE CopyFile(VAR IFile, OFile: TEXT);

IMPLEMENTATION

CONST
  MergeFileName = 'MERGE.TXT';
TYPE
  GroupLine = RECORD
                Root: STRING;
                Words: STRING;
                Count: INTEGER
              END;

PROCEDURE PrepareEmptyFile(FileName: STRING);
{ Создает пустой рабочий файл }
VAR
  F: TEXT;
BEGIN { PrepareEmptyFile }
  ASSIGN(F, FileName);
  REWRITE(F)
END; { PrepareEmptyFile }

PROCEDURE MergeLines(VAR Left, Right: GroupLine; VAR OutF: TEXT);
{ Объединяет две строки с одинаковым корнем }
BEGIN { MergeLines }
  WRITELN(OutF, Left.Words, CommaSymbol, SpaceSymbol, Right.Words, ColonSymbol, SpaceSymbol, IntToString(Left.Count + Right.Count))
END; { MergeLines }

FUNCTION LineToRecord(Line: STRING): GroupLine;
{ Строку формата "слово, слово, ...: число" переделывает в запись }
VAR
  ColonPos, Index: INTEGER;
  WordsPart, CountPart: STRING;
  Res: GroupLine;
BEGIN { LineToRecord }
  ColonPos := POS(ColonSymbol, Line);
  IF ColonPos > 0
  THEN
    BEGIN
      WordsPart := Empty;
      CountPart := Empty;
      FOR Index := 1 TO ColonPos - 1
      DO
        WordsPart := WordsPart + Line[Index];
      FOR Index := ColonPos + 2 TO LENGTH(Line)
      DO
        CountPart := CountPart + Line[Index];
      Res.Words := WordsPart;
      Res.Root := FindRoot(ExtractWord(WordsPart));
      Res.Count := ExtractCount(SpaceSymbol + CountPart)
    END
  ELSE
    BEGIN
      Res.Root := Empty;
      Res.Words := Empty;
      Res.Count := 0
    END;
  LineToRecord := Res
END; { LineToRecord }

PROCEDURE MergeSortedFiles(VAR LeftF, RightF, OutF: TEXT);
{ Потоково сливает два отсортированных файла }
VAR
  LeftLine, RightLine: STRING;
  LeftData, RightData: GroupLine;
BEGIN { MergeSortedFiles }
  ReadLine(LeftF, LeftLine);
  ReadLine(RightF, RightLine);
  LeftData := LineToRecord(LeftLine);
  RightData := LineToRecord(RightLine);
  WHILE (LeftLine <> Empty) OR (RightLine <> Empty)
  DO
    BEGIN
      IF (LeftData.Root = RightData.Root) AND (LeftData.Root <> Empty)
      THEN
        BEGIN
          MergeLines(LeftData, RightData, OutF);
          ReadLine(LeftF, LeftLine);
          ReadLine(RightF, RightLine);
          LeftData := LineToRecord(LeftLine);
          RightData := LineToRecord(RightLine)
        END
      ELSE
        IF (RightLine = Empty) OR ((LeftLine <> Empty) AND (NOT IsGreater(LeftData.Root, RightData.Root)))
        THEN
          BEGIN
            WRITELN(OutF, LeftLine);
            ReadLine(LeftF, LeftLine);
            LeftData := LineToRecord(LeftLine)
          END
        ELSE
          BEGIN
            WRITELN(OutF, RightLine);
            ReadLine(RightF, RightLine);
            RightData := LineToRecord(RightLine)
          END
    END
END; { MergeSortedFiles }

PROCEDURE MergeWithSort(VAR TempFile, PortionFile: TEXT);
{ Сливает TEMP и PORTION в MERGE, затем переносит
  MERGE обратно в TEMP }
VAR
  MergeFile: TEXT;
BEGIN { MergeWithSort }
  ASSIGN(MergeFile, MergeFileName);
  REWRITE(MergeFile);
  MergeSortedFiles(TempFile, PortionFile, MergeFile);
  RESET(MergeFile);
  REWRITE(TempFile);
  CopyFile(MergeFile, TempFile);
END; { MergeWithSort }

PROCEDURE Merge(TempFileName, PortionFileName: STRING);
{ Выгружает данные в PORTION и сливает с TEMP }
VAR
  PortionFile, TempFile: TEXT;
BEGIN { Merge }
  IF HasData
  THEN
    BEGIN
      ASSIGN(PortionFile, PortionFileName);
      ASSIGN(TempFile, TempFileName);
      REWRITE(PortionFile);
      RESET(TempFile);
      OutputGroupsStats(PortionFile);
      RESET(PortionFile);
      MergeWithSort(TempFile, PortionFile);
      ClearMemory
    END
END; { Merge }

PROCEDURE CopyFile(VAR IFile, OFile: TEXT);
{ Копирует все строки из IFile в OFile }
VAR
  Line: STRING;
BEGIN { CopyFile }
  WHILE NOT EOF(IFile)
  DO
    BEGIN
      READLN(IFile, Line);
      WRITELN(OFile, Line)
    END
END; { CopyFile }

BEGIN { GroupMergeUtils }
  PrepareEmptyFile(MergeFileName)
END. { GroupMergeUtils }
