UNIT GroupRunUtils;

INTERFACE

USES
  GroupTypes, GroupLogicUtils, GroupWordUtils, GroupDictionary, GroupMergeUtils;

PROCEDURE RunWordsGrouper(VAR IFile, OFile: TEXT);

IMPLEMENTATION

CONST
  TempFileName = 'TEMP.TXT';
  PortionFileName = 'PORTION.TXT';
  Overflow = -1;   

PROCEDURE RunWordsGrouper(VAR IFile, OFile: TEXT);
{ Основной цикл обработки файла статистики }
VAR
  Str, Word, Root: STRING;
  Count: INTEGER;
  Data: WordData;
  TempFile: TEXT;
BEGIN { RunWordsGrouper }
  PrepareEmptyFile(TempFileName);
  WHILE NOT EOF(IFile) AND NOT Data.Overflow 
  DO
    BEGIN
      READLN(IFile, Str);
      Word := ExtractWord(Str);
      Count := ExtractCount(Str);
      Data.Overflow := FALSE;
      IF Count = Overflow
      THEN
        WRITELN('Overflow: in ', '', Str, '')
      ELSE
        BEGIN
          Root := FindRoot(Word);
          IF IsUniqueLimitReached AND (NOT HasRoot(Root)) 
          THEN
            Merge(TempFileName, PortionFileName);
          Data.Word := Word;
          Data.Count := Count;
          Insert(Root, Data);
          IF Data.Overflow
          THEN
            WRITELN('Overflow: summary count for ', '', Root, '', ' > MAXINT. Skipping ', '', Word, '')
        END
    END; 
  Merge(TempFileName, PortionFileName);
  ASSIGN(TempFile, TempFileName);
  RESET(TempFile);
  CopyFile(TempFile, OFile)
END; { RunWordsGrouper }

BEGIN { GroupRunUtils }
END. { GroupRunUtils }
