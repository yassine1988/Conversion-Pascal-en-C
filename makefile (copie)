all:prog
prog: grammaire.tab.o lex.yy.o
	gcc -o $@ $^ -lfl
grammaire.tab.o: grammaire.tab.c grammaire.tab.h
	gcc -o $@ -c grammaire.tab.c
grammaire.tab.c grammaire.tab.h: grammaire.y
	bison grammaire.y --defines=grammaire.tab.h
lex.yy.o: lex.yy.c
	gcc -o $@ -c lex.yy.c
lex.yy.c: syntaxe.l grammaire.tab.h
	flex syntaxe.l
clean:
	rm *.tab.*
	rm *.yy.*
