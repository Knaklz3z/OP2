PROGRAM GroupWords(INPUT, OUTPUT);
USES
  GroupRunUtils;
CONST
  InputFileName = 'TEST.TXT';
  OutputFileName = 'OUTPUT.TXT';
VAR
  InputFile, OutputFile: TEXT;
BEGIN { GroupWords }
  ASSIGN(InputFile, InputFileName);
  ASSIGN(OutputFile, OutputFileName);
  RESET(InputFile);
  REWRITE(OutputFile);
  RunWordsGrouper(InputFile, OutputFile)
END. { GroupWords }                                                    
