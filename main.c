#include <stdio.h>
#include <stdlib.h>
#include "type.h"

void initialize();
int yyparse();
void print_ast(A_NODE *);
void semantic_analysis(A_NODE *);
void print_sem_ast(A_NODE *);
void code_generation(A_NODE *);

extern int syntax_err;
extern int semantic_err;
extern A_NODE* root;

FILE *fin;
FILE *fout;

int open_files(int argc, char* argv[])
{
	char* output_file_name;

	if (!(2<=argc && argc<=3))
	{
		fprintf(stderr, "USAGE:\tscc <input_file>\n"
						"\tscc <input_file> <output_file>\n");
		return 1;
	}
	if ((fin=freopen(argv[1],"r",stdin)) == NULL)
	{
		fprintf(stderr, "CANNOT OPEN FILE : %s\n", argv[1]);
		return 1;
	}
	output_file_name = argc==3? argv[2] : "a.asm";
	if ((fout=fopen(output_file_name, "w")) == NULL)
	{
		fprintf(stderr, "CANNOT OPEN FILE : %s\n", output_file_name);
		return 1;
	}
	return 0;
}

void close_files()
{
	fclose(fin);
	fclose(fout);
}

int main(int argc, char* argv[])
{
	if (open_files(argc, argv))
	{
		return 1;
	}
	initialize();
	yyparse();
	if (syntax_err)
		exit(1);
	print_ast(root);
	semantic_analysis(root);
	if (semantic_err)
		exit(1);
	print_sem_ast(root);
	code_generation(root);

	close_files();
	return 0;
}
