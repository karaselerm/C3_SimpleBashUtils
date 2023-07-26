#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#define no_argument 0
void read_fp(int j, char *ARGV[], int FLAG);

int main(int argc, char *argv[]) {
  int flag = 0;
  char rez;
  const char *short_options = "benstETv";

  const struct option long_options[] = {
      {"number-nonblank", no_argument, NULL, 'b'},
      {"number", no_argument, NULL, 'n'},
      {"squeeze-blank", no_argument, NULL, 's'},
      {NULL, 0, NULL, 0}};

  while ((rez = getopt_long(argc, argv, short_options, long_options, NULL)) !=
         -1) {
    switch (rez) {
      case 'b':
        flag = 1;
        break;
      case 'n':
        flag = 2;
        break;
      case 's':
        flag = 3;
        break;
      case 'e':
        flag = 4;
        continue;
      case 't':
        flag = 5;
        break;
      case 'E':
        flag = 6;
        break;
      case 'T':
        flag = 7;
        break;
      case 'v':
        flag = 8;
        break;
      default:
        printf("Usage: cat [option] [file ...]\n");
    }
  }

  for (int i = optind; i < argc;
       i++) {  // Индекс текущего параметра хранится - optind
    read_fp(i, argv, flag);
    continue;
  }
  // printf("\n");
  return 0;
}

void read_fp(int j, char *ARGV[], int FLAG) {  // i, arrgv,
  FILE *fp = fopen(ARGV[j], "r");
  if (fp == NULL) {
    printf("Error: Cannot open file %s\n", ARGV[j]);
  } else {
    int line_num = 1;
    int ch;
    int prev = '\n';
    int empty_printed = 0;
    while ((ch = fgetc(fp)) != EOF) {
      if (FLAG == 1) {
        if (prev == '\n' && ch != '\n') {
          printf("%6d\t", line_num);
          line_num++;
        }
        putchar(ch);
      } else if (FLAG == 2) {
        if (prev == '\n') printf("%6d\t", line_num);
        putchar(ch);
        if (ch == '\n') line_num++;
      } else if (FLAG == 3 &&
                 !(prev == '\n' && ch == '\n' && empty_printed == 1)) {
        putchar(ch);
        if (prev == '\n' && ch == '\n')
          empty_printed = 1;
        else
          empty_printed = 0;
      } else if (FLAG == 6) {
        if (ch == '\n')
          printf("$\n");
        else
          putchar(ch);
      } else if (FLAG == 7) {
        if (ch == '\t')
          printf("^I");
        else
          putchar(ch);
      } else if (FLAG == 4 || FLAG == 5 || FLAG == 8) {
        if (ch <= 31 && ch >= 0 && ch != 9 && ch != 10)
          printf("^%c", ch + 64);
        else if (FLAG == 4 && ch == '\n')
          printf("$\n");
        else if (FLAG == 5 && ch == '\t')
          printf("^I");
        else if ((ch <= 126 && ch >= 32) || ch == 9 || ch == 10)
          printf("%c", ch);
        else if (ch == 127)
          printf("^?");
        else
          printf("M-^%c", ch + 192);
      } else if (FLAG == 0)
        putchar(ch);
      prev = ch;
    }
  }
}