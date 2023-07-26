FLAGS = -Wall -Wextra -Werror

all : s21_grep

s21_grep : s21_grep.o
	gcc $(FLAGS) s21_grep.o -o s21_grep
	rm -rf *.o

s21_grep.o : s21_grep.c
	gcc $(FLAGS) -c s21_grep.c

clean :
	rm ./s21_grep

# valgrind_test:
# 	cd ../../materials/build/Valgrind/ && sh run.sh