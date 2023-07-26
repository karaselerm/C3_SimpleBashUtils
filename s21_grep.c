#include <ctype.h>
#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct grep {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
  char Patterns[10000];
  int FilesCounter;
  int FlagsCounter;
  char *Files[5000];
};

void GetLines(struct grep all_stuff);
int RunningFlags(char *line, int reti, int NumberOfFile, struct grep all_stuff,
                 int MatchCounter, int LineCounter, FILE *File);
int RunningFlagO(struct grep all_stuff, char *line, int NumberOfFile,
                 int MatchCounter, int LineCounter);
int main(int argc, char *argv[]) {
  struct grep all_stuff = {0};

  const char *short_options = "eivclnhsfo";
  char rez;
  int ind = 0;
  int flag = 0;
  while ((rez = getopt_long(argc, argv, short_options, NULL, NULL)) != -1) {
    switch (rez) {
      case 'e':
        all_stuff.e = 1;
        if (ind) strcat(all_stuff.Patterns, "|");
        strcat(all_stuff.Patterns, argv[optind]);
        ind = 1;
        optind++;
        break;
      case 'i':
        all_stuff.i = 1;
        break;
      case 'v':
        all_stuff.v = 1;
        break;
      case 'c':
        all_stuff.c = 1;
        break;
      case 'n':
        all_stuff.n = 1;
        break;
      case 'l':
        all_stuff.l = 1;
        break;
      case 'h':
        all_stuff.h = 1;
        break;
      case 's':
        all_stuff.s = 1;
        break;
      case 'f':
        all_stuff.f = 1;
        char pattern[5000] = "";
        FILE *fp = fopen(argv[optind], "r");
        optind++;
        if (fp == NULL)
          flag = 1;
        else {
          while (fgets(pattern, sizeof(pattern), fp)) {
            char new[5000] = "";
            for (int i = 0; i < (int)strlen(pattern); i++) {
              if (pattern[i] != '\n') new[i] = pattern[i];
            }
            if (ind && *pattern != '\n') strcat(all_stuff.Patterns, "|");
            strcat(all_stuff.Patterns, new);
            ind = 1;
          }
        }
        fclose(fp);
        break;
      case 'o':
        all_stuff.o = 1;
        break;
    }
  }

  if (!all_stuff.e && !all_stuff.f) {
    if (ind) strcat(all_stuff.Patterns, "|");
    strcat(all_stuff.Patterns, argv[optind]);
    optind++;
  }
  strcat(all_stuff.Patterns, "\0");

  for (int i = optind; i < argc; i++) {
    all_stuff.Files[all_stuff.FilesCounter] = argv[i];
    all_stuff.FilesCounter++;
  }

  if (!(int)strlen(all_stuff.Patterns) || !all_stuff.FilesCounter) flag = 1;

  all_stuff.FlagsCounter =
      all_stuff.e + all_stuff.i + all_stuff.v + all_stuff.c + all_stuff.l +
      all_stuff.n + all_stuff.h + all_stuff.s + all_stuff.f + all_stuff.o;

  if (flag || all_stuff.FlagsCounter > 2) {
    printf("Usage: grep [option] [pattern] [file ...]\n");

  } else
    GetLines(all_stuff);
  return 0;
}

void GetLines(struct grep all_stuff) {
  regex_t regex;
  int reti;
  int cflag = 0;
  if (all_stuff.i && !all_stuff.o) {
    cflag = REG_ICASE | REG_EXTENDED;
  } else if (!all_stuff.o || (all_stuff.o && all_stuff.v) ||
             (all_stuff.o && all_stuff.c) || (all_stuff.o && all_stuff.l)) {
    cflag = REG_EXTENDED;
  }

  reti = regcomp(&regex, all_stuff.Patterns, cflag);

  if (!reti || all_stuff.o) {
    for (int i = 0; i < all_stuff.FilesCounter; i++) {
      FILE *fp = fopen(all_stuff.Files[i], "r");
      if (fp == NULL) {
        if (!all_stuff.s)
          printf("Error: Cannot open file %s\n", all_stuff.Files[i]);
      } else if (fp != NULL) {
        int LineCounter = 0;
        int MatchCounter = 0;
        char line[5000] = "";
        while (fgets(line, sizeof(line), fp)) {
          LineCounter++;
          if (all_stuff.o && !all_stuff.v && !all_stuff.c && !all_stuff.l) {
            MatchCounter =
                RunningFlagO(all_stuff, line, i, MatchCounter, LineCounter);
          } else {
            reti = regexec(&regex, line, 0, NULL, 0);
            MatchCounter = RunningFlags(line, reti, i, all_stuff, MatchCounter,
                                        LineCounter, fp);
          }
        }
        if (all_stuff.c) {
          if (all_stuff.l && MatchCounter > 1) MatchCounter = 1;
          if (all_stuff.FilesCounter == 1 || all_stuff.h)
            printf("%d\n", MatchCounter);
          else if (!all_stuff.h)
            printf("%s:%d\n", all_stuff.Files[i], MatchCounter);
        }
        if (all_stuff.l) {
          if (MatchCounter > 0) printf("%s\n", all_stuff.Files[i]);
        }
        fclose(fp);
      }
    }
  }
  regfree(&regex);
}

int RunningFlags(char *line, int reti, int NumberOfFile, struct grep all_stuff,
                 int MatchCounter, int LineCounter, FILE *File) {
  int UnMatchCounter = MatchCounter;
  int ResultOfReti = 0;
  int Printing = 0;
  if (!reti) {
    ResultOfReti = 1;
  } else
    ResultOfReti = 0;
  if (ResultOfReti) {
    MatchCounter++;
    if (!all_stuff.FlagsCounter || (all_stuff.s && all_stuff.e) ||
        (all_stuff.s && all_stuff.i) || (all_stuff.e && all_stuff.i) ||
        (all_stuff.n && all_stuff.e) || (all_stuff.n && all_stuff.i) ||
        (all_stuff.h && all_stuff.e) || (all_stuff.h && all_stuff.i) ||
        (all_stuff.h && all_stuff.n) || (all_stuff.s && all_stuff.n) ||
        (all_stuff.s && all_stuff.h) || (all_stuff.e && all_stuff.f) ||
        (all_stuff.i && all_stuff.f) || (all_stuff.n && all_stuff.f) ||
        (all_stuff.h && all_stuff.f) || (all_stuff.s && all_stuff.f) ||
        ((all_stuff.f || all_stuff.n || all_stuff.e || all_stuff.i ||
          all_stuff.h || all_stuff.s) &&
         all_stuff.FlagsCounter == 1)) {
      Printing = 1;
    }
  } else {
    UnMatchCounter++;
    if (all_stuff.v && (all_stuff.FlagsCounter == 1 || all_stuff.e ||
                        all_stuff.i || all_stuff.f || all_stuff.n ||
                        all_stuff.o || all_stuff.h || all_stuff.s)) {
      Printing = 1;
    }
  }
  if (Printing) {
    if (all_stuff.FilesCounter > 1 && !all_stuff.h)
      printf("%s:", all_stuff.Files[NumberOfFile]);
    if (all_stuff.n) printf("%d:", LineCounter);
    printf("%s", line);
    if (feof(File)) printf("\n");
  }
  if (all_stuff.v) MatchCounter = UnMatchCounter;

  return MatchCounter;
}

int RunningFlagO(struct grep all_stuff, char *line, int NumberOfFile,
                 int MatchCounter, int LineCounter) {
  int LineLen = 0;
  int PatternsCounter = 0;
  char *PatternsArray[5000];
  while (line[LineLen] != '\0') LineLen++;
  char LowerLine[5000] = "";
  if (all_stuff.i) {
    strcpy(LowerLine, line);
    for (int j = 0; j < LineLen; j++) LowerLine[j] = tolower(LowerLine[j]);
  }
  char *token = strtok(all_stuff.Patterns, "|");
  char Pattern[5000] = "";
  for (int i = 0; token != NULL; i++) {
    if (all_stuff.i) {
      strcpy(Pattern, token);
      for (int j = 0; j < (int)strlen(Pattern); j++)
        Pattern[j] = tolower(Pattern[j]);
      PatternsArray[i] = Pattern;
    } else
      PatternsArray[i] = token;
    PatternsCounter++;
    token = strtok(NULL, "|");
  }
  int MatchInLineCounter = 0;

  for (int i = 0; i < PatternsCounter; i++) {
    int PatternLen = 0;
    while (PatternsArray[i][PatternLen] != '\0')
      PatternLen++;  // Получили паттерн и его длину
    // Ищем совпадения
    if (all_stuff.o &&
        (all_stuff.FlagsCounter == 1 || all_stuff.e || all_stuff.n ||
         all_stuff.s || all_stuff.i || all_stuff.h || all_stuff.f)) {
      for (int j = 0; j <= LineLen - PatternLen; j++) {
        int Printing = 0;
        int m = 0;
        for (int k = 0; k < PatternLen; k++) {
          if (all_stuff.i) {
            if (LowerLine[j + k] == PatternsArray[i][k])
              m++;
            else
              m = 0;
          } else {
            if (line[j + k] == PatternsArray[i][k])
              m++;
            else
              m = 0;
          }
        }
        if (m == PatternLen) {
          Printing = 1;
          m = 0;
          MatchCounter++;
          MatchInLineCounter++;
        }
        if (Printing) {
          if (all_stuff.FilesCounter > 1 && MatchInLineCounter == 1 &&
              !all_stuff.h)
            printf("%s:", all_stuff.Files[NumberOfFile]);
          if (all_stuff.n && MatchInLineCounter == 1)
            printf("%d:", LineCounter);
          printf("%.*s\n", PatternLen, &line[j]);
        }
      }
    }
  }
  return MatchCounter;
}