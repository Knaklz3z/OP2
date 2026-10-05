PROGRAM InsertionSort(INPUT, OUTPUT);
{ Сортирует символы из INPUT }
CONST
  Max = 16;
  ListEnd = 0;
TYPE
  IndexType = 0 .. Max;
  RecArray = ARRAY [1 .. Max] OF 
               RECORD
                 Key: CHAR;
                 Next: IndexType
               END;
VAR
  Arr: RecArray;
  First: IndexType;

PROCEDURE InsertElement(VAR Arr: RecArray; VAR First, Index: IndexType);
{ Найти значения Prev и Curr, если существуют такие что
  Arr[Prev].Key  <= Arr[Index].Key <= Arr[Curr].Key }
VAR
  Found: BOOLEAN;
  Curr, Prev: IndexType;
BEGIN
  Prev := 0;
  Curr := First;
  Found := FALSE;
  WHILE (Curr <> ListEnd) AND NOT Found
  DO
    IF Arr[Index].Key > Arr[Curr].Key
    THEN
      BEGIN
        Prev := Curr;
        Curr := Arr[Curr].Next
      END
    ELSE
      Found := True;
  Arr[Index].Next := Curr;
  IF Prev = 0 { Первый элемент в списке }
  THEN
    First := Index
  ELSE
    Arr[Prev].Next := Index    
END;

PROCEDURE RunInsertionSort(VAR Arr: RecArray; VAR First: IndexType);
{ Запускает вставочную сортировку }
VAR
  Extra: CHAR;
  Index: IndexType;
BEGIN
  First := ListEnd;
  Index := 0;
  WHILE NOT EOLN(INPUT)      
  DO
    BEGIN
      { Помещать запись в список, если позволяет пространство, 
      иначе игнорировать и сообщать об ошибке }
      Index := Index + 1;
      IF Index > Max
      THEN
        BEGIN
          READ(Extra);
          WRITELN('Сообщение содержит: ', Extra, '. Игнорируем.')
        END
      ELSE
        BEGIN
          READ(Arr[Index].Key);
          InsertElement(Arr, First, Index)
        END
    END
END;
  
PROCEDURE OutputResult(VAR Arr: RecArray; First: IndexType);
{ Печать списка начиная с Arr[First] }
VAR 
  Index: IndexType;
BEGIN
  Index := First;
  WHILE Index <> ListEnd
  DO
    BEGIN
      WRITE(Arr[Index].Key);  
      Index := Arr[Index].Next
    END;
  WRITELN
END;
  
BEGIN { InsertionSort }
  RunInsertionSort(Arr, First);
  OutputResult(Arr, First)
END. { InsertionSort }
