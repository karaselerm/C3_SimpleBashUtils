#sh test.sh > shtest.txt
# gcc -Werror -Wextra -Wall -fsanitize=leak -fsanitize=address -fsanitize=undefined -fsanitize=unreachable -fno-sanitize-recover -fstack-protector s21_grep.c -o s21_grep

#test no flag
./s21_grep New test.txt > s21_grep_out.txt
grep New test.txt > grep_out.txt
echo "test no flag"
diff -q s21_grep_out.txt grep_out.txt

#test -e flag 
echo "test -e"
./s21_grep -e New -e 123 test.txt > s21_grep_out.txt
grep -e New -e 123 test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -i flag
./s21_grep -i NEW test.txt > s21_grep_out.txt
grep -i NEW test.txt > grep_out.txt
echo "test -i"
diff -q s21_grep_out.txt grep_out.txt

#test -v flag
./s21_grep -v 123 test.txt > s21_grep_out.txt
grep -v 123 test.txt > grep_out.txt
echo "test -v"
diff -q s21_grep_out.txt grep_out.txt

#test -c flag
./s21_grep -c 123 test.txt test2.txt > s21_grep_out.txt
grep -c 123 test.txt test2.txt > grep_out.txt
echo "test -c"
diff -q s21_grep_out.txt grep_out.txt

#test -n flag
./s21_grep -n 123 test.txt > s21_grep_out.txt
grep -n 123 test.txt> grep_out.txt
echo "test -n"
diff -q s21_grep_out.txt grep_out.txt

#test -l flag
./s21_grep -l 123 test.txt test2.txt  > s21_grep_out.txt
grep -l 123 test.txt test2.txt  > grep_out.txt
echo "test -l"
 diff -q s21_grep_out.txt grep_out.txt

#EXTRAS
#test -h flag
./s21_grep -h 123 test.txt test2.txt  > s21_grep_out.txt
grep -h 123 test.txt test2.txt  > grep_out.txt
echo "EXTRA test -h"
 diff -q s21_grep_out.txt grep_out.txt

#test -s flag
./s21_grep -s 123 test.txt qwerty.txt  > s21_grep_out.txt
 grep -s 123 test.txt qwerty.txt  > grep_out.txt
echo "EXTRA test -s"
 diff -q s21_grep_out.txt grep_out.txt

#test -o flag
./s21_grep -o 123 test.txt test2.txt > s21_grep_out.txt
grep -o 123 test.txt test2.txt > grep_out.txt
echo "EXTRA test -o"
diff -q s21_grep_out.txt grep_out.txt

#test -f flag
./s21_grep -f test_pattern.txt test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt test.txt test2.txt > grep_out.txt
echo "EXTRA test -f"
diff -q s21_grep_out.txt grep_out.txt

#DOUBLE FLAGS
#test -e -v flags
./s21_grep -e New -e 123 -v test.txt > s21_grep_out.txt
grep -e New -e 123 -v test.txt > grep_out.txt
echo "test -e -v"
diff -q s21_grep_out.txt grep_out.txt

#test -e -i flags
./s21_grep -e NEW -i test.txt > s21_grep_out.txt
grep -e NEW -i test.txt > grep_out.txt
echo "test -e -i"
diff -q s21_grep_out.txt grep_out.txt

#test -i -v flags 
echo "test -i -v"
./s21_grep -i NEW -v test.txt > s21_grep_out.txt
grep -i NEW -v test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -n -e flags
echo "test -n -e"
./s21_grep -e new -e 123 -n test.txt test2.txt > s21_grep_out.txt
grep -e new -e 123 -n test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -n -i flags
echo "test -n -i"
./s21_grep -i NEW -n test.txt > s21_grep_out.txt
grep -i NEW -n test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -n -v flags
echo "test -n -v"
./s21_grep -v 123 -n test.txt > s21_grep_out.txt
grep -v 123 -n test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -n -c flags
echo "test -n -c"
./s21_grep -c 123 -n test.txt test2.txt> s21_grep_out.txt
grep -c 123 -n test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -i -c flags
echo "test -i -c"
./s21_grep -i NEW -c test.txt test2.txt> s21_grep_out.txt
grep -i NEW -c test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -v -c flags
echo "test -v -c"
./s21_grep -v 123 -c test.txt test2.txt> s21_grep_out.txt
grep -v 123 -c test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -e -c flags
echo "test -e -c"
./s21_grep -e 123 -e New -c test.txt test2.txt> s21_grep_out.txt
grep -e 123 -e New -c test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -l -e flags
echo "test -l -e"
./s21_grep -e 123 -e New -l test.txt test2.txt> s21_grep_out.txt
grep -e 123 -e New -l test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -l -i flags
echo "test -l -i"
./s21_grep -i NEW  -l test.txt test2.txt> s21_grep_out.txt
grep -i NEW -l test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -l -v flags
echo "test -l -v"
./s21_grep -v 123  -l test.txt test2.txt> s21_grep_out.txt
grep -v 123 -l test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -l -c flags
echo "test -l -c"
./s21_grep -c 123  -l test.txt test2.txt> s21_grep_out.txt
grep -c 123 -l test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -l -n flags
echo "test -l -n"
./s21_grep -n 123  -l test.txt test2.txt> s21_grep_out.txt
grep -n 123 -l test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -h -e flags
echo "test -h -e "
./s21_grep -e 123 -e new -h test.txt test2.txt> s21_grep_out.txt
grep -e 123 -e new -h test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -h -i flags
echo "test -h -i "
./s21_grep -i NEW -h test.txt test2.txt> s21_grep_out.txt
grep -i NEW -h test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -h -v flags
echo "test -h -v "
./s21_grep -v 123 -h test.txt test2.txt> s21_grep_out.txt
grep -v 123 -h test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -h -c flags
echo "test -h -c "
./s21_grep -c 123 -h test.txt test2.txt> s21_grep_out.txt
grep -c 123 -h test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -h -n flags
echo "test -h -n "
./s21_grep -n 123 -h test.txt test2.txt> s21_grep_out.txt
grep -n 123 -h test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -h -l flags
echo "test -h -l "
./s21_grep -l 123 -h test.txt test2.txt> s21_grep_out.txt
grep -l 123 -h test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -s -e flag
echo "test -s -e "
./s21_grep -e 123 -e new -s test.txt qwerty.txt > s21_grep_out.txt
grep -e 123 -e new -s test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -s -i flag
echo "test -s -i "
./s21_grep -i NEW -s test.txt qwerty.txt > s21_grep_out.txt
grep -i NEW -s test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -s -v flag
echo "test -s -v"
./s21_grep -v 123 -s test.txt qwerty.txt > s21_grep_out.txt
grep -v 123 -s test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -s -c flag
echo "test -s -v"
./s21_grep -c 123 -s test.txt qwerty.txt > s21_grep_out.txt
grep -c 123 -s test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -s -n flag
echo "test -s -v"
./s21_grep -n 123 -s test.txt qwerty.txt > s21_grep_out.txt
grep -n 123 -s test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -s -l flag
echo "test -s -l"
./s21_grep -l 123 -s test.txt qwerty.txt > s21_grep_out.txt
grep -l 123 -s test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -s -h flag
echo "test -s -h"
./s21_grep -h 123 -s test.txt qwerty.txt > s21_grep_out.txt
grep -h 123 -s test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -f -e flag
echo "test -f -e"
./s21_grep -f test_pattern.txt -e new -e 123 test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -e new -e 123 test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -f -i flag
echo "test -f -i"
./s21_grep -f test_pattern.txt -i test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -i test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -f -v flag
echo "test -f -v"
./s21_grep -f test_pattern.txt -v test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -v test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -f -c flag
echo "test -f -c"
./s21_grep -f test_pattern.txt -c test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -c test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -f -n flag
echo "test -f -n"
./s21_grep -f test_pattern.txt -n test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -n test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -f -l flag
echo "test -f -l"
./s21_grep -f test_pattern.txt -l test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -l test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -f -h flag
echo "test -f -h"
./s21_grep -f test_pattern.txt -h test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -h test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -f -s flag
echo "test -f -s"
./s21_grep -f test_pattern.txt -s qwerty.txt test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -s qwerty.txt test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -e flag
echo "test -o -e "
./s21_grep -e 123 -e new -o test.txt test2.txt > s21_grep_out.txt
grep -e 123 -e new -o test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -i flag
echo "test -o -i "
./s21_grep -i NeW -o test.txt test2.txt > s21_grep_out.txt
grep -i NeW -o test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -v flag
echo "test -o -v "
./s21_grep -v 123 -o test.txt test2.txt > s21_grep_out.txt
grep -v 123 -o test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -c flag
echo "test -o -c "
./s21_grep -c 123 -o test.txt test2.txt > s21_grep_out.txt
grep -c 123 -o test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -n flag
echo "test -o -n "
./s21_grep -n 123 -o test.txt test2.txt > s21_grep_out.txt
grep -n 123 -o test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -l flag
echo "test -o -l "
./s21_grep -l 123 -o test.txt test2.txt > s21_grep_out.txt
grep -l 123 -o test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -h flag
echo "test -o -h "
./s21_grep -h 123 -o test.txt test2.txt > s21_grep_out.txt
grep -h 123 -o test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -s flag
echo "test -o -s "
./s21_grep -s 123 -o test.txt qwerty.txt > s21_grep_out.txt
grep -s 123 -o test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

#test -o -f flag
echo "test -o -f "
./s21_grep -f test_pattern.txt -o test.txt test2.txt > s21_grep_out.txt
grep -f test_pattern.txt -o test.txt test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt
