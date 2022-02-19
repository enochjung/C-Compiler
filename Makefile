# gdb 쓸꺼면
DEBUG_OPTION=-g

scc: y.tab.c lex.yy.c syntax_analyzer.o semantic_analyzer.o semantic_tree_print.o code_generator.o print.c main.c
	gcc $(DEBUG_OPTION) y.tab.c syntax_analyzer.o semantic_analyzer.o semantic_tree_print.o code_generator.o print.c lex.yy.c main.c -o scc

code_generator.o: code_generator.c code_generator.h
	gcc $(DEBUG_OPTION) code_generator.c -c

semantic_tree_print.o: semantic_tree_print.c print.c semantic_tree_print.h
	gcc $(DEBUG_OPTION) semantic_tree_print.c -c

semantic_analyzer.o: semantic_analyzer.c semantic_analyzer.h syntax_analyzer.h
	gcc $(DEBUG_OPTION) semantic_analyzer.c -c

syntax_analyzer.o: syntax_analyzer.c syntax_analyzer.h y.tab.h type.h
	gcc $(DEBUG_OPTION) syntax_analyzer.c -c

y.tab.c: cg.y
	yacc -d cg.y

lex.yy.c: cg.l
	lex cg.l
