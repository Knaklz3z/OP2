UNIT Dictionary;

INTERFACE

USES 
  LogicUtils;

FUNCTION IsUniqueLimitReached: BOOLEAN;
PROCEDURE Insert(Str: STRING);           
PROCEDURE OutputWordsStats(VAR F: TEXT);
PROCEDURE ClearMemory;  

IMPLEMENTATION

CONST
  SpaceSymbol = ' ';
  MaxUniqueWords = 4;
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
BEGIN
  NEW(Root);
  Root^.Word := Word;
  Root^.Count := 1;
  Root^.Left := NIL;
  Root^.Right := NIL;
  NodesTotal := NodesTotal + 1
END;

FUNCTION IsUniqueLimitReached: BOOLEAN;
{ Проверка на лимиту уникальных слов }
BEGIN { IsUniqueLimitReached }
  IsUniqueLimitReached := NodesTotal >= MaxUniqueWords
END; { IsUniqueLimitReached }

PROCEDURE AddToTree(VAR Root: PointWord; Str: STRING);
{ Добавляет к слову сразу заданное количество }
BEGIN { InsertIntoTree }
  IF (Root = NIL) AND NOT IsUniqueLimitReached
  THEN
    CreateNode(Root, Str)   
  ELSE
    IF Root <> NIL
    THEN
      IF Root^.Word = Str
      THEN
        Root^.Count := Root^.Count + 1
      ELSE
        IF IsGreater(Root^.Word, Str)
        THEN
          AddToTree(Root^.Left, Str)
        ELSE
          AddToTree(Root^.Right, Str)       
END; { InsertIntoTree }

PROCEDURE PrintTree(VAR Root: PointWord; VAR F: TEXT);
{ Печатает дерево в отсортированном порядке }
BEGIN { PrintTree }
  IF Root <> NIL 
  THEN
    BEGIN
      PrintTree(Root^.Left, F);
      WRITELN(F, Root^.Word, SpaceSymbol, Root^.Count);
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

PROCEDURE Insert(Str: STRING);
{ Вставка через корень }
BEGIN { InsertIntoTree }
  AddToTree(Root, Str)
END; { InsertIntoTree }

PROCEDURE OutputWordsStats(VAR F: TEXT);
{ Вывод текущего дерева }
BEGIN
  PrintTree(Root, F)
END; { OutputWordsStats }

PROCEDURE ClearMemory;
{ Полная очистка дерева }
BEGIN { ClearMemory }
  DisposeTree(Root)
END; { ClearMemory }

BEGIN { Dictionary }
  Root := NIL;
  NodesTotal := 0  
END. { Dictionary }
