all:prog
prog: pascal.tab.o lex.yy.o
	gcc -o $@ $^ -lfl
pascal.tab.o: pascal.tab.c y.tab.h
	gcc -o $@ -c pascal.tab.c
pascal.tab.c pascal.tab.h: pascal.y
	bison pascal.y --defines=y.tab.h
lex.yy.o: lex.yy.c
	gcc -o $@ -c lex.yy.c
lex.yy.c: pascal.l y.tab.h
	flex pascal.l
clean:
	rm *.tab.*
	rm *.yy.*
