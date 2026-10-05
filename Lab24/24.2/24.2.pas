PROGRAM CountWords2;
{ Подсчитывает число слов в текстовом файле
 и собирает статистику встречаемости для каждого слова. }
USES
  RunProgramUtils;
CONST
  InputFileName = 'INPUT.TXT';
  OutputFileName = 'OUTPUT.TXT';
VAR
  InputFile, OutputFile: TEXT;
BEGIN { CountWords2 }
  ASSIGN(InputFile, InputFileName);
  ASSIGN(OutputFile, OutputFileName);
  RESET(InputFile);
  REWRITE(OutputFile);
  RunWordsCounter(InputFile, OutputFile)
END. { CountWords2 }
