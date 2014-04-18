all:prog
prog: grammaire.tab.o lex.yy.o table.o
	gcc -o $@ $^ -lfl
grammaire.tab.o: grammaire.tab.c grammaire.tab.h 
	gcc -o $@ -c grammaire.tab.c
grammaire.tab.c grammaire.tab.h: grammaire.y 
	bison -v grammaire.y --defines=grammaire.tab.h
lex.yy.o: lex.yy.c  table.h
	gcc -o $@ -c lex.yy.c
lex.yy.c: syntaxe.l grammaire.tab.h
	flex syntaxe.l
table.o: table.h table.c
	gcc -o $@ -c table.c 
clean:
	rm *.tab.*
	rm *.yy.*
	rm *.o
