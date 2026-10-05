PROGRAM CountWords(INPUT, OUTPUT);
{ Подсчитывает число слов в текстовом файле
 и собирает статистику встречаемости для каждого слова. }
USES
  WordUtils, Dictionary;
CONST
  InputFileName = 'TEST.TXT';
  OutputFileName = 'OUTPUT.TXT';
VAR
  InputFile, OutputFile: TEXT;     
BEGIN { CountWords }
  ASSIGN(InputFile,  InputFileName);
  ASSIGN(OutputFile, OutputFileName);
  RESET(InputFile);
  REWRITE(OutputFile);
  CountWords(InputFile);
  OutputWordsStats(OutputFile);
  ClearMemory
END. { CountWords }
