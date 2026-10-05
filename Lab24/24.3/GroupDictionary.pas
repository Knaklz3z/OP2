UNIT GroupDictionary;

INTERFACE

USES
  GroupTypes, GroupLogicUtils, GroupWordUtils;

FUNCTION IsUniqueLimitReached: BOOLEAN;
FUNCTION HasRoot(Root: STRING): BOOLEAN;
FUNCTION HasData: BOOLEAN;
PROCEDURE Insert(Root: STRING; Data: WordData);
PROCEDURE OutputGroupsStats(VAR F: TEXT);
PROCEDURE ClearMemory;

IMPLEMENTATION

CONST
  MaxUniqueRoots = 1;
TYPE
  WordList = ^WordListNode;
  WordListNode = RECORD
                   Word: STRING;
                   Next: WordList
                 END;               
  PointGroup = ^GroupStats;
  GroupStats = RECORD
                 Root: STRING;
                 Words: WordList;
                 Count: INTEGER;
                 Left, Right: PointGroup
               END;
VAR
  RootNode: PointGroup;
  NodesTotal: INTEGER;

FUNCTION IsUniqueLimitReached: BOOLEAN;
{ Проверка на достижение лимита уникальных корней }
BEGIN { IsUniqueLimitReached }
  IsUniqueLimitReached := NodesTotal >= MaxUniqueRoots
END; { IsUniqueLimitReached }

FUNCTION MakeWordsList(List: WordList): STRING;
{ Формирует строку из списка слов через запятую }
VAR
  Current: WordList;
  Res: STRING;
  First: BOOLEAN;
BEGIN { MakeWordsList }
  Res := Empty;
  Current := List;
  First := TRUE;
  WHILE Current <> NIL 
  DO
    BEGIN
      IF NOT First 
      THEN
        Res := Res + CommaSymbol + SpaceSymbol;
      Res := Res + Current^.Word;
      First := FALSE;
      Current := Current^.Next
    END;
  MakeWordsList := Res
END; { MakeWordsList }

PROCEDURE AddWordToList(VAR List: WordList; Word: STRING);
{ Добавляет слово в список, если его там еще нет }
VAR
  Current: WordList;
  Found: BOOLEAN;
BEGIN { AddWordToList }
  Found := FALSE;
  Current := List;
  WHILE (Current <> NIL) AND NOT Found 
  DO
    BEGIN
      IF Current^.Word = Word 
      THEN
        Found := TRUE
      ELSE
        Current := Current^.Next
    END;
  IF NOT Found 
  THEN
    BEGIN
      NEW(Current);
      Current^.Word := Word;
      Current^.Next := List;
      List := Current
    END
END; { AddWordToList }

PROCEDURE CreateNode(VAR Node: PointGroup; Root: STRING; Data: WordData);
{ Создает новый узел с начальными данными }
BEGIN { CreateNode }
  NEW(Node);
  Node^.Root := Root;
  Node^.Words := NIL;
  AddWordToList(Node^.Words, Data.Word);
  Node^.Count := Data.Count;
  Node^.Left := NIL;
  Node^.Right := NIL;
  NodesTotal := NodesTotal + 1
END; { CreateNode }

PROCEDURE AddToDictionary(VAR Node: PointGroup; Root: STRING; Data: WordData);
{ Добавляет слово к группе или создает новую группу }
BEGIN { AddToDictionary }
  IF NOT Data.Overflow
  THEN
    IF (Node = NIL) AND NOT IsUniqueLimitReached 
    THEN
      CreateNode(Node, Root, Data)
    ELSE
      IF Node <> NIL 
      THEN
        IF Node^.Root = Root 
        THEN
          IF MAXINT - Node^.Count < Data.Count
          THEN
            Data.Overflow := TRUE
          ELSE
            BEGIN
              AddWordToList(Node^.Words, Data.Word);
              Node^.Count := Node^.Count + Data.Count
            END
        ELSE
          IF IsGreater(Node^.Root, Root) 
          THEN
            AddToDictionary(Node^.Left, Root, Data)
          ELSE
            AddToDictionary(Node^.Right, Root, Data)
END; { AddToDictionary }

PROCEDURE PrintSortedData(Node: PointGroup; VAR F: TEXT);
{ Печатает данные в отсортированном порядке }
VAR
  WordsList: STRING;
BEGIN { PrintSortedData }
  IF Node <> NIL 
  THEN
    BEGIN
      PrintSortedData(Node^.Left, F);
      WordsList := MakeWordsList(Node^.Words);
      WRITELN(F, WordsList, ColonSymbol, SpaceSymbol, IntToString(Node^.Count));
      PrintSortedData(Node^.Right, F)
    END
END; { PrintSortedData }

PROCEDURE DisposeWordList(VAR List: WordList);
{ Освобождает память списка слов }
VAR
  Temp: WordList;
BEGIN { DisposeWordList }
  WHILE List <> NIL 
  DO
    BEGIN
      Temp := List;
      List := List^.Next;
      DISPOSE(Temp)
    END
END; { DisposeWordList }

PROCEDURE DisposeDictionary(VAR Node: PointGroup);
{ Освобождает память коллекции }
BEGIN { DisposeDictionary }
  IF Node <> NIL 
  THEN
    BEGIN
      DisposeDictionary(Node^.Left);
      DisposeDictionary(Node^.Right);
      DisposeWordList(Node^.Words);
      DISPOSE(Node);
      Node := NIL
    END
END; { DisposeDictionary }

FUNCTION SearchRoot(Node: PointGroup; Root: STRING): BOOLEAN;
{ Ищет корень в словаре }
BEGIN { SearchRoot }
  IF Node = NIL 
  THEN
    SearchRoot := FALSE
  ELSE
    IF Node^.Root = Root 
    THEN
      SearchRoot := TRUE
    ELSE
      IF IsGreater(Node^.Root, Root) 
      THEN
        SearchRoot := SearchRoot(Node^.Left, Root)
      ELSE
        SearchRoot := SearchRoot(Node^.Right, Root)
END; { SearchRoot }

FUNCTION HasRoot(Root: STRING): BOOLEAN;
{ Проверяет наличие корня }
BEGIN { HasRoot }
  HasRoot := SearchRoot(RootNode, Root)
END; { HasRoot }

FUNCTION HasData: BOOLEAN;
{ Проверка на наличие данных }
BEGIN { HasData }
  HasData := NodesTotal <> 0
END; { HasData }

PROCEDURE Insert(Root: STRING; Data: WordData);
{ Добавление слова в коллекцию по корню }
BEGIN { Insert }
  AddToDictionary(RootNode, Root, Data)
END; { Insert }

PROCEDURE OutputGroupsStats(VAR F: TEXT);
{ Вывод текущих данных }
BEGIN { OutputGroupsStats }
  PrintSortedData(RootNode, F)
END; { OutputGroupsStats }

PROCEDURE ClearMemory;
{ Полная очистка памяти }
BEGIN { ClearMemory }
  DisposeDictionary(RootNode);
  NodesTotal := 0;
END; { ClearMemory }

BEGIN { GroupDictionary }
  RootNode := NIL;
  NodesTotal := 0;
END. { GroupDictionary }
