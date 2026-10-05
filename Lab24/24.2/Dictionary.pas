UNIT Dictionary;

INTERFACE

USES
  LogicUtils, WordUtils;

FUNCTION IsUniqueLimitReached: BOOLEAN;
FUNCTION HasWord(Str: STRING): BOOLEAN;
FUNCTION HasData: BOOLEAN;
PROCEDURE Insert(Str: STRING);
PROCEDURE OutputWordsStats(VAR F: TEXT);
PROCEDURE ClearMemory;

IMPLEMENTATION

CONST
  MaxUniqueWords = 30000;
TYPE
  PointWord = ^WordStats;
  WordStats = RECORD
                Word: STRING;
                Count: INTEGER;
                Left, Right: PointWord
              END;
VAR
  Root: PointWord;
  NodesTotal: INTEGER;

PROCEDURE CreateNode(VAR Root: PointWord; Word: STRING);
{ Создает новый узел дерева с начальными данными }
BEGIN { CreateNode }
  NEW(Root);
  Root^.Word := Word;
  Root^.Count := 1;
  Root^.Left := NIL;
  Root^.Right := NIL;
  NodesTotal := NodesTotal + 1
END; { CreateNode }

FUNCTION IsUniqueLimitReached: BOOLEAN;
{ Проверка на лимиту уникальных слов }
BEGIN { IsUniqueLimitReached }
  IsUniqueLimitReached := NodesTotal >= MaxUniqueWords
END; { IsUniqueLimitReached }

PROCEDURE AddToTree(VAR Root: PointWord; Str: STRING);
{ Добавляет к слову сразу заданное количество }
BEGIN { AddToTree }
  IF (Root = NIL) AND NOT IsUniqueLimitReached
  THEN
    CreateNode(Root, Str)
  ELSE
    IF Root <> NIL
    THEN
      IF Root^.Word = Str
      THEN
        IF Root^.Count < MAXINT
        THEN
          Root^.Count := Root^.Count + 1
        ELSE
          WRITELN(OUTPUT, 'Ошибка: переполнение для ', Root^.Word)
      ELSE
        IF IsGreater(Root^.Word, Str)
        THEN
          AddToTree(Root^.Left, Str)
        ELSE
          AddToTree(Root^.Right, Str)
END; { AddToTree }

PROCEDURE PrintTree(Root: PointWord; VAR F: TEXT);
{ Печатает дерево в отсортированном порядке }
BEGIN { PrintTree }
  IF Root <> NIL
  THEN
    BEGIN
      PrintTree(Root^.Left, F);
      WriteStat(F, Root^.Word, Root^.Count);
      PrintTree(Root^.Right, F)
    END
END; { PrintTree }

PROCEDURE DisposeTree(VAR Root: PointWord);
{ Освобождает память дерева }
BEGIN { DisposeTree }
  IF Root <> NIL
  THEN
    BEGIN
      DisposeTree(Root^.Left);
      DisposeTree(Root^.Right);
      DISPOSE(Root);
      Root := NIL
    END
END; { DisposeTree }

FUNCTION SearchWord(Root: PointWord; Str: STRING): BOOLEAN;
{ Ищет слово в дереве }
BEGIN { SearchWord }
  IF Root = NIL
  THEN
    SearchWord := FALSE
  ELSE
    IF Root^.Word = Str
    THEN
      SearchWord := TRUE
    ELSE
      IF IsGreater(Root^.Word, Str)
      THEN
        SearchWord := SearchWord(Root^.Left, Str)
      ELSE
        SearchWord := SearchWord(Root^.Right, Str)
END; { SearchWord }

FUNCTION HasWord(Str: STRING): BOOLEAN;
{ Проверяет на наличие слова в дереве }
BEGIN { HasWord }
  HasWord := SearchWord(Root, Str)
END; { HasWord }

FUNCTION HasData: BOOLEAN;
{ Проверка на наличие хотя бы одного узла в дереве }
BEGIN { HasData }
  HasData := NodesTotal <> 0; // Убрать DataEx
END; { HasData }

PROCEDURE Insert(Str: STRING);
{ Добавление слова в дерево }
BEGIN { InsertIntoTree }
  AddToTree(Root, Str)
END; { InsertIntoTree }

PROCEDURE OutputWordsStats(VAR F: TEXT);
{ Вывод текущего дерева }
BEGIN { OutputWordsStats }
  PrintTree(Root, F)
END; { OutputWordsStats }

PROCEDURE ClearMemory;
{ Полная очистка дерева }
BEGIN { ClearMemory }
  DisposeTree(Root);
  NodesTotal := 0;
END; { ClearMemory }

BEGIN { Dictionary }
  Root := NIL;
  NodesTotal := 0;
END. { Dictionary }
