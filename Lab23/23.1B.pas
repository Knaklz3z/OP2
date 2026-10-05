PROGRAM InsertSort2(INPUT, OUTPUT);
TYPE 
  NodePtr = ^Node;
  Node = RECORD
           Next: NodePtr;
           Key: CHAR
         END;
VAR
  FirstPtr: NodePtr; 

PROCEDURE InsertElement(VAR FirstPtr: NodePtr; NewPtr: NodePtr);
{ ¬ставл€ем NewPtr в отсортированный список }
VAR
  Curr, Prev: NodePtr;
  Found: BOOLEAN;
BEGIN
  Prev := NIL;
  Curr := FirstPtr;
  Found := FALSE;
  WHILE (Curr <> NIL) AND NOT Found
  DO
    IF NewPtr^.Key > Curr^.Key
    THEN
      BEGIN
        Prev := Curr;
        Curr := Curr^.Next
      END
    ELSE
      Found := TRUE;
    NewPtr^.Next := Curr;
    IF Prev = NIL 
    THEN
      FirstPtr := NewPtr
    ELSE
      Prev^.Next := NewPtr
END;

PROCEDURE RunInsertionSort(VAR FirstPtr: NodePtr);
{ —читывает данные и сортирует их вставкой }
VAR
  NewPtr: NodePtr;
BEGIN
  FirstPtr := NIL;
  WHILE NOT EOLN
  DO
    BEGIN
      NEW(NewPtr);
      READ(NewPtr^.Key);
      InsertElement(FirstPtr, NewPtr)
    END
END;

PROCEDURE OutputResult(FirstPtr: NodePtr);
{ ¬ывод отсортированного списка }
VAR
  NewPtr: NodePtr;
BEGIN
  NewPtr := FirstPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WRITE(NewPtr^.Key);
      NewPtr := NewPtr^.Next
    END;
  WRITELN  
END;
  
BEGIN { InsertSort2 }
  RunInsertionSort(FirstPtr);
  OutputResult(FirstPtr)
END. { InsertSort2 }
