UNIT GroupTypes;

INTERFACE

TYPE
  WordData = RECORD
               Word: STRING;
               Count: INTEGER;
               Overflow: BOOLEAN
             END;
CONST
  Empty = '';
  SpaceSymbol = ' ';
  ColonSymbol = ':';
  CommaSymbol = ',';

IMPLEMENTATION

BEGIN { GroupTypes }
END. { GroupTypes }
