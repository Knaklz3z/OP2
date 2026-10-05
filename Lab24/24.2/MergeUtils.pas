UNIT MergeUtils;

INTERFACE

USES
  LogicUtils, WordUtils, Dictionary;

PROCEDURE PrepareEmptyFile(FileName: STRING);
PROCEDURE Merge(TempFileName, PortionFileName: STRING);
PROCEDURE CopyFile(VAR IFile, OFile: TEXT);

IMPLEMENTATION

CONST
  Empty = '';
  MergeFileName = 'MERGE.TXT';

PROCEDURE MergeSortedFiles(VAR LeftF, RightF, OFile: TEXT);
{ Cливает два отсортированных файла статистики }
VAR
  LeftWord, RightWord: STRING;
  LeftCount, RightCount: INTEGER;
BEGIN { MergeSortedFiles }
  ReadStat(LeftF, LeftWord, LeftCount);
  ReadStat(RightF, RightWord, RightCount);
  WHILE (LeftWord <> Empty) OR (RightWord <> Empty)
  DO
    BEGIN
      IF (LeftWord = RightWord) AND (LeftWord <> Empty)
      THEN
        BEGIN
          WriteStat(OFile, LeftWord, LeftCount + RightCount);
          ReadStat(LeftF, LeftWord, LeftCount);
          ReadStat(RightF, RightWord, RightCount)
        END
      ELSE
        IF (RightWord = Empty) OR ((LeftWord <> Empty) AND (NOT IsGreater(LeftWord, RightWord)))
        THEN
          BEGIN
            WriteStat(OFile, LeftWord, LeftCount);
            ReadStat(LeftF, LeftWord, LeftCount)
          END
        ELSE
          BEGIN
            WriteStat(OFile, RightWord, RightCount);
            ReadStat(RightF, RightWord, RightCount)
          END
    END
END; { MergeSortedFiles }

PROCEDURE MergeWithSort(VAR TempFile, PortionFile: TEXT);
{ Сливает TEMP и PORTION в MERGE, затем переносит MERGE обратно в TEMP }
VAR
  MergeFile: TEXT;
BEGIN { MergeWithSort }
  ASSIGN(MergeFile, MergeFileName);
  REWRITE(MergeFile);
  MergeSortedFiles(TempFile, PortionFile, MergeFile);
  RESET(MergeFile);
  REWRITE(TempFile);
  CopyFile(MergeFile, TempFile);
  RESET(TempFile)
END; { MergeWithSort }

PROCEDURE PrepareEmptyFile(FileName: STRING);
{ Создает пустой рабочий файл }
VAR
  F: TEXT;
BEGIN { PrepareEmptyFile }
  ASSIGN(F, FileName);
  REWRITE(F)
END; { PrepareEmptyFile }

PROCEDURE Merge(TempFileName, PortionFileName: STRING);
{ Выгружает дерево в PORTION и сливает с TEMP }
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
      OutputWordsStats(PortionFile);
      RESET(PortionFile);
      MergeWithSort(TempFile, PortionFile);
      ClearMemory
    END
END; { Merge }

PROCEDURE CopyFile(VAR IFile, OFile: TEXT);
{ Копирует все строки из IFile в OFile }
VAR
  Str: STRING;
BEGIN { CopyFile }
  WHILE NOT EOF(IFile)
  DO
    BEGIN
      READLN(IFile, Str);
      WRITELN(OFile, Str)
    END
END; { CopyFile }

BEGIN { MergeUtils }
  PrepareEmptyFile(MergeFileName)
END. { MergeUtils }
