run: y.tab.c y.tab.h lex.yy.c interp.c lib.c
	gcc y.tab.c lex.yy.c interp.c lib.c -o run

y.tab.c: int.y
	yacc -d int.y

lex.yy.c: int.l
	lex int.l

clear:
	rm -f run y.tab.c y.tab.h lex.yy.c

