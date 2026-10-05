PROGRAM SarahRevere(INPUT, OUTPUT); 
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN; 

PROCEDURE Init; 
{ Инициализация переменных } 
BEGIN { DoInitialization }
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := NOT EOLN;
  Land := FALSE;
  Sea := FALSE
END; { DoInitialization }

PROCEDURE MoveWindow(VAR Ch1, Ch2, Ch3, Ch4: CHAR; VAR Look: BOOLEAN); 
{ Сдвиг окна }
BEGIN { MoveWindow }
  Ch1 := Ch2;
  Ch2 := Ch3;
  Ch3 := Ch4;
  READ(Ch4);
  Look := NOT EOLN
END; { MoveWindow }

PROCEDURE CheckWindow(VAR Ch1, Ch2, Ch3, Ch4: CHAR; VAR Land, Sea: BOOLEAN); 
{ Проверка на land / sea }
BEGIN { CheckWindow }
  Land := (Ch1 = 'l') AND (Ch2 = 'a') AND (Ch3 = 'n') AND (Ch4 = 'd'); 
  Sea := (Ch2 = 's') AND (Ch3 = 'e') AND (Ch4 = 'a')
END; { CheckWindow }

PROCEDURE SendMessage(VAR Land, Sea: BOOLEAN); 
{ Отправка сообщения }
BEGIN { SendMessage }
  IF Land
  THEN
    WRITELN('The British are coming by land')
  ELSE
    IF Sea
    THEN
      WRITELN('The British are coming by sea')
    ELSE
      WRITELN('Error')
END; { SendMessage } 
 
BEGIN { SarahRevere }   
  Init;
  WHILE Looking AND NOT (Land OR Sea)   
  DO
    BEGIN
      MoveWindow(W1, W2, W3, W4, Looking);
      CheckWindow(W1, W2, W3, W4, Land, Sea)
    END;
  SendMessage(Land, Sea)    
END. { SarahRevere } 
