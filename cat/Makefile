FLAGS = -Wall -Wextra -Werror

all : s21_cat

s21_cat : s21_cat.o
	gcc $(FLAGS) s21_cat.o -o s21_cat
	rm -rf *.o

s21_cat.o : s21_cat.c
	gcc $(FLAGS) -c s21_cat.c

clean :
	rm ./s21_cat
