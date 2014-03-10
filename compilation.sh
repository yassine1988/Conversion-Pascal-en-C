rm lex.yy.c
rm a.out
flex $1
gcc lex.yy.c -lfl
./a.out test
