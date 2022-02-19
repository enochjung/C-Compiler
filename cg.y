%token AUTO_SYM BREAK_SYM CASE_SYM CONTINUE_SYM DEFAULT_SYM DO_SYM ELSE_SYM ENUM_SYM FOR_SYM IF_SYM RETURN_SYM SIZEOF_SYM STATIC_SYM STRUCT_SYM SWITCH_SYM TYPEDEF_SYM UNION_SYM WHILE_SYM PLUSPLUS MINUSMINUS ARROW LSS GTR LEQ GEQ EQL NEQ AMPAMP BARBAR DOTDOTDOT LP RP LB RB LR RR COLON PERIOD COMMA EXCL STAR SLASH PERCENT AMP SEMICOLON PLUS MINUS ASSIGN INTEGER_CONSTANT FLOAT_CONSTANT STRING_LITERAL CHARACTER_CONSTANT IDENTIFIER TYPE_IDENTIFIER CONST_SYM

%{
#define YYSTYPE_IS_DECLARED 1 
typedef long YYSTYPE;
#include <stdlib.h>
#include "type.h"
#include "syntax_analyzer.h"

int yylex();
void yyerror(char const *s);
int yywrap();

extern A_ID* current_id;
extern int current_level;
extern int syntax_err;
extern int semantic_err;
extern A_NODE* root;
extern A_TYPE* int_type;
%}

%start program

%%
program 
	: translation_unit {checkForwardReference(); root=makeNode(N_PROGRAM,0,(A_NODE*)$1,0);}
	;
translation_unit
	: external_declaration {$$=$1;}
	| translation_unit external_declaration {$$=(YYSTYPE)linkDeclaratorList((A_ID*)$1,(A_ID*)$2);}
	;
external_declaration
	: function_definition {$$=$1;}
	| declaration {$$=$1;}
	;
function_definition
	: declaration_specifiers declarator {$$=(YYSTYPE)setFunctionDeclaratorSpecifier((A_ID*)$2,(A_SPECIFIER*)$1);} compound_statement {$$=(YYSTYPE)setFunctionDeclaratorBody((A_ID*)$3,(A_NODE*)$4);}
	| declarator {$$=(YYSTYPE)setFunctionDeclaratorSpecifier((A_ID*)$1,makeSpecifier(int_type,0));} compound_statement {$$=(YYSTYPE)setFunctionDeclaratorBody((A_ID*)$2,(A_NODE*)$3);}
	;
declaration
	: declaration_specifiers init_declarator_list_opt SEMICOLON {$$=(YYSTYPE)setDeclaratorListSpecifier((A_ID*)$2,(A_SPECIFIER*)$1);}
	//| init_declarator_list_opt SEMICOLON {$$=(YYSTYPE)setDeclaratorListSpecifier((A_ID*)$1,makeSpecifier(int_type,0));}
	;
declaration_specifiers 
	: type_specifier {$$=(YYSTYPE)makeSpecifier((A_TYPE*)$1,0);}
	| storage_class_specifier {$$=(YYSTYPE)makeSpecifier(0,$1);}
	| type_specifier declaration_specifiers {$$=(YYSTYPE)updateSpecifier((A_SPECIFIER*)$2,(A_TYPE*)$1,0);}
	| storage_class_specifier declaration_specifiers {$$=(YYSTYPE)updateSpecifier((A_SPECIFIER*)$2,0,(S_KIND)$1);}
	;
storage_class_specifier
	: AUTO_SYM {$$=S_AUTO;}
	| STATIC_SYM {$$=S_STATIC;}
	| TYPEDEF_SYM {$$=S_TYPEDEF;}
	;
init_declarator_list_opt
	: {$$=(YYSTYPE)makeDummyIdentifier();}
	| init_declarator_list {$$=$1;}
	;
init_declarator_list
	: init_declarator {$$=$1;}
	| init_declarator_list COMMA init_declarator {$$=(YYSTYPE)linkDeclaratorList((A_ID*)$1,(A_ID*)$3);}
	;
init_declarator
	: declarator {$$=$1;}
	| declarator ASSIGN initializer {$$=(YYSTYPE)setDeclaratorInit((A_ID*)$1,(A_NODE*)$3);}
	;
type_specifier
	: struct_specifier {$$=$1;}
	| enum_specifier {$$=$1;}
	| TYPE_IDENTIFIER {$$=$1;}
	;
struct_specifier
	: struct_or_union IDENTIFIER {$$=(YYSTYPE)setTypeStructOrEnumIdentifier((T_KIND)$1,(char*)$2,ID_STRUCT);} LR {$$=(YYSTYPE)current_id; current_level++;} struct_declaration_list RR {checkForwardReference(); current_level--; current_id=(A_ID*)$5; $$=(YYSTYPE)setTypeField((A_TYPE*)$3,(A_ID*)$6);}
	| struct_or_union {$$=(YYSTYPE)makeType((T_KIND)$1);} LR {$$=(YYSTYPE)current_id; current_level++;} struct_declaration_list RR {checkForwardReference(); current_level--; current_id=(A_ID*)$4; $$=(YYSTYPE)setTypeField((A_TYPE*)$2,(A_ID*)$5);}
	| struct_or_union IDENTIFIER {$$=(YYSTYPE)getTypeOfStructOrEnumRefIdentifier((T_KIND)$1,(char*)$2,ID_STRUCT);}
	;
struct_or_union
	: STRUCT_SYM {$$=T_STRUCT;}
	| UNION_SYM {$$=T_UNION;}
	;
struct_declaration_list
	: struct_declaration {$$=$1;}
	| struct_declaration_list struct_declaration {$$=(YYSTYPE)linkDeclaratorList((A_ID*)$1,(A_ID*)$2);}
	;
struct_declaration
	: type_specifier struct_declarator_list SEMICOLON {$$=(YYSTYPE)setStructDeclaratorListSpecifier((A_ID*)$2,(A_TYPE*)$1);}
	;
struct_declarator_list
	: struct_declarator {$$=$1;}
	| struct_declarator_list COMMA struct_declarator {$$=(YYSTYPE)linkDeclaratorList((A_ID*)$1,(A_ID*)$3);}
	;
struct_declarator
	: declarator {$$=$1;}
	;
enum_specifier
	: ENUM_SYM IDENTIFIER {$$=(YYSTYPE)setTypeStructOrEnumIdentifier(T_ENUM,(char*)$2,ID_ENUM);} LR enumerator_list RR {$$=(YYSTYPE)setTypeField((A_TYPE*)$3,(A_ID*)$5);}
	| ENUM_SYM {$$=(YYSTYPE)makeType(T_ENUM);} LR enumerator_list RR {$$=(YYSTYPE)setTypeField((A_TYPE*)$2,(A_ID*)$4);}
	| ENUM_SYM IDENTIFIER {$$=(YYSTYPE)getTypeOfStructOrEnumRefIdentifier(T_ENUM,(char*)$2,ID_ENUM);}
	;
enumerator_list
	: enumerator {$$=$1;}
	| enumerator_list COMMA enumerator {$$=(YYSTYPE)linkDeclaratorList((A_ID*)$1,(A_ID*)$3);}
	;
enumerator
	: IDENTIFIER {$$=(YYSTYPE)setDeclaratorKind(makeIdentifier((char*)$1),ID_ENUM_LITERAL);}
	| IDENTIFIER {$$=(YYSTYPE)setDeclaratorKind(makeIdentifier((char*)$1),ID_ENUM_LITERAL);} ASSIGN expression {$$=(YYSTYPE)setDeclaratorInit((A_ID*)$2,(A_NODE*)$4);}
	;
declarator
	: pointer direct_declarator {$$=(YYSTYPE)setDeclaratorElementType((A_ID*)$2,(A_TYPE*)$1);}
	| direct_declarator {$$=$1;}
	;
pointer
	: STAR {$$=(YYSTYPE)makeType(T_POINTER);}
	| STAR pointer {$$=(YYSTYPE)setTypeElementType((A_TYPE*)$2,makeType(T_POINTER));}
	;
direct_declarator
	: IDENTIFIER {$$=(YYSTYPE)makeIdentifier((char*)$1);}
	| LP declarator RP {$$=$2;}
	| direct_declarator LB constant_expression_opt RB {$$=(YYSTYPE)setDeclaratorElementType((A_ID*)$1,setTypeExpr(makeType(T_ARRAY),(A_NODE*)$3));}
	| direct_declarator LP {$$=(YYSTYPE)current_id; current_level++;} parameter_type_list_opt RP {checkForwardReference(); current_level--; current_id=(A_ID*)$3; $$=(YYSTYPE)setDeclaratorElementType((A_ID*)$1,setTypeField(makeType(T_FUNC),(A_ID*)$4));}
	;
parameter_type_list_opt
	: {$$=NIL;}
	| parameter_type_list {$$=$1;}
	;
parameter_type_list
	: parameter_list {$$=$1;}
	| parameter_list COMMA DOTDOTDOT {$$=(YYSTYPE)linkDeclaratorList((A_ID*)$1,setDeclaratorKind(makeDummyIdentifier(),ID_PARM));}
	;
parameter_list
	: parameter_declaration {$$=$1;}
	| parameter_list COMMA parameter_declaration {$$=(YYSTYPE)linkDeclaratorList((A_ID*)$1,(A_ID*)$3);}
	;
parameter_declaration
	: declaration_specifiers declarator {$$=(YYSTYPE)setParameterDeclaratorSpecifier((A_ID*)$2,(A_SPECIFIER*)$1);}
	| declaration_specifiers abstract_declarator_opt {$$=(YYSTYPE)setParameterDeclaratorSpecifier(setDeclaratorType(makeDummyIdentifier(),(A_TYPE*)$2),(A_SPECIFIER*)$1);}
	;
abstract_declarator_opt
	: {$$=NIL;}
	| abstract_declarator {$$=$1;}
	;
abstract_declarator
	: pointer {$$=(YYSTYPE)makeType(T_POINTER);}
	| direct_abstract_declarator {$$=$1;}
	| pointer direct_abstract_declarator {$$=(YYSTYPE)setTypeElementType((A_TYPE*)$2,makeType(T_POINTER));}
	;
direct_abstract_declarator
	: LP abstract_declarator RP {$$=$2;}
	| LB constant_expression_opt RB {$$=(YYSTYPE)setTypeExpr(makeType(T_ARRAY),(A_NODE*)$2);}
	| LP parameter_type_list_opt RP {$$=(YYSTYPE)setTypeExpr(makeType(T_FUNC),(A_NODE*)$2);}
	| direct_abstract_declarator LB constant_expression_opt RB {$$=(YYSTYPE)setTypeElementType((A_TYPE*)$1,setTypeExpr(makeType(T_ARRAY),(A_NODE*)$3));}
	| direct_abstract_declarator LP parameter_type_list_opt RP {$$=(YYSTYPE)setTypeElementType((A_TYPE*)$1,setTypeExpr(makeType(T_FUNC),(A_NODE*)$3));}
	;
initializer
	: constant_expression {$$=(YYSTYPE)makeNode(N_INIT_LIST_ONE,0,(A_NODE*)$1,0);}
	| LR initializer_list RR {$$=$2;}
	;
initializer_list
	: initializer {$$=(YYSTYPE)makeNode(N_INIT_LIST,(A_NODE*)$1,0,makeNode(N_INIT_LIST_NIL,0,0,0));}
	| initializer_list COMMA initializer {$$=(YYSTYPE)makeNodeList(N_INIT_LIST,(A_NODE*)$1,(A_NODE*)$3);}
	;
statement_list_opt
	: {$$=(YYSTYPE)makeNode(N_STMT_LIST_NIL,0,0,0);}
	| statement_list {$$=$1;}
statement_list
	: statement {$$=(YYSTYPE)makeNode(N_STMT_LIST,(A_NODE*)$1,0,makeNode(N_STMT_LIST_NIL,0,0,0));}
	| statement_list statement {$$=(YYSTYPE)makeNodeList(N_STMT_LIST,(A_NODE*)$1,(A_NODE*)$2);}
	;
statement
	: labeled_statement {$$=$1;}
	| compound_statement {$$=$1;}
	| expression_statement {$$=$1;}
	| selection_statement {$$=$1;}
	| iteration_statement {$$=$1;}
	| jump_statement {$$=$1;}
	;
labeled_statement
	: CASE_SYM constant_expression COLON statement {$$=(YYSTYPE)makeNode(N_STMT_LABEL_CASE,(A_NODE*)$2,0,(A_NODE*)$4);}
	| DEFAULT_SYM COLON statement {$$=(YYSTYPE)makeNode(N_STMT_LABEL_DEFAULT,0,(A_NODE*)$3,0);}
	;
compound_statement
	: LR {$$=(YYSTYPE)current_id; current_level++;} declaration_list_opt statement_list_opt RR {checkForwardReference(); current_level--; current_id=(A_ID*)$2; $$=(YYSTYPE)makeNode(N_STMT_COMPOUND,(A_NODE*)$3,0,(A_NODE*)$4);}
	;
declaration_list_opt
	: {$$=0;}
	| declaration_list {$$=$1;}
	;
declaration_list
	: declaration {$$=$1;}
	| declaration_list declaration {$$=(YYSTYPE)linkDeclaratorList((A_ID*)$1,(A_ID*)$2);}
	;
expression_statement
	: SEMICOLON {$$=(YYSTYPE)makeNode(N_STMT_EMPTY,0,0,0);}
	| expression SEMICOLON {$$=(YYSTYPE)makeNode(N_STMT_EXPRESSION,0,(A_NODE*)$1,0);}
	;
selection_statement
	: IF_SYM LP expression RP statement {$$=(YYSTYPE)makeNode(N_STMT_IF,(A_NODE*)$3,0,(A_NODE*)$5);}
	| IF_SYM LP expression RP statement ELSE_SYM statement {$$=(YYSTYPE)makeNode(N_STMT_IF_ELSE,(A_NODE*)$3,(A_NODE*)$5,(A_NODE*)$7);}
	| SWITCH_SYM LP expression RP statement {$$=(YYSTYPE)makeNode(N_STMT_SWITCH,(A_NODE*)$3,0,(A_NODE*)$5);}
	;
iteration_statement
	: WHILE_SYM LP expression RP statement {$$=(YYSTYPE)makeNode(N_STMT_WHILE,(A_NODE*)$3,0,(A_NODE*)$5);}
	| DO_SYM statement WHILE_SYM LP expression RP SEMICOLON {$$=(YYSTYPE)makeNode(N_STMT_DO,(A_NODE*)$2,0,(A_NODE*)$5);}
	| FOR_SYM LP for_expression RP statement {$$=(YYSTYPE)makeNode(N_STMT_FOR,(A_NODE*)$3,0,(A_NODE*)$5);}
	;
for_expression
	: expression_opt SEMICOLON expression_opt SEMICOLON expression_opt {$$=(YYSTYPE)makeNode(N_FOR_EXP,(A_NODE*)$1,(A_NODE*)$3,(A_NODE*)$5);}
	;
expression_opt
	: {$$=0;}
	| expression {$$=$1;}
	;
jump_statement
	: RETURN_SYM expression_opt SEMICOLON {$$=(YYSTYPE)makeNode(N_STMT_RETURN,0,(A_NODE*)$2,0);}
	| CONTINUE_SYM SEMICOLON {$$=(YYSTYPE)makeNode(N_STMT_CONTINUE,0,0,0);}
	| BREAK_SYM SEMICOLON {$$=(YYSTYPE)makeNode(N_STMT_BREAK,0,0,0);}
	;
arg_expression_list_opt
	: {$$=(YYSTYPE)makeNode(N_ARG_LIST_NIL,0,0,0);}
	| arg_expression_list {$$=$1;}
	;
arg_expression_list
	: assignment_expression {$$=(YYSTYPE)makeNode(N_ARG_LIST,(A_NODE*)$1,0,makeNode(N_ARG_LIST_NIL,0,0,0));}
	| arg_expression_list COMMA assignment_expression {$$=(YYSTYPE)makeNodeList(N_ARG_LIST,(A_NODE*)$1,(A_NODE*)$3);}
	;
constant_expression_opt
	: {$$=NIL;}
	| constant_expression {$$=$1;}
	;
constant_expression
	: expression {$$=$1;}
	;
expression
	: comma_expression {$$=$1;}
	;
comma_expression
	: assignment_expression {$$=$1;}
	;
assignment_expression
	: conditional_expression {$$=$1;}
	| unary_expression ASSIGN assignment_expression {$$=(YYSTYPE)makeNode(N_EXP_ASSIGN,(A_NODE*)$1,0,(A_NODE*)$3);}
	;
conditional_expression
	: logical_OR_expression {$$=$1;}
	;
logical_OR_expression
	: logical_AND_expression {$$=$1;}
	| logical_OR_expression BARBAR logical_AND_expression {$$=(YYSTYPE)makeNode(N_EXP_OR,(A_NODE*)$1,0,(A_NODE*)$3);}
	;
logical_AND_expression
	: equality_expression {$$=$1;}
	| logical_AND_expression AMPAMP equality_expression {$$=(YYSTYPE)makeNode(N_EXP_AND,(A_NODE*)$1,0,(A_NODE*)$3);}
	;
equality_expression
	: relational_expression {$$=$1;}
	| equality_expression EQL relational_expression {$$=(YYSTYPE)makeNode(N_EXP_EQL,(A_NODE*)$1,0,(A_NODE*)$3);}
	| equality_expression NEQ relational_expression {$$=(YYSTYPE)makeNode(N_EXP_NEQ,(A_NODE*)$1,0,(A_NODE*)$3);}
	;
relational_expression
	: additive_expression {$$=$1;}
	| relational_expression LSS additive_expression {$$=(YYSTYPE)makeNode(N_EXP_LSS,(A_NODE*)$1,0,(A_NODE*)$3);}
	| relational_expression GTR additive_expression {$$=(YYSTYPE)makeNode(N_EXP_GTR,(A_NODE*)$1,0,(A_NODE*)$3);}
	| relational_expression LEQ additive_expression {$$=(YYSTYPE)makeNode(N_EXP_LEQ,(A_NODE*)$1,0,(A_NODE*)$3);}
	| relational_expression GEQ additive_expression {$$=(YYSTYPE)makeNode(N_EXP_GEQ,(A_NODE*)$1,0,(A_NODE*)$3);}
	;
additive_expression
	: multiplicative_expression {$$=$1;}
	| additive_expression PLUS multiplicative_expression {$$=(YYSTYPE)makeNode(N_EXP_ADD,(A_NODE*)$1,0,(A_NODE*)$3);}
	| additive_expression MINUS multiplicative_expression {$$=(YYSTYPE)makeNode(N_EXP_SUB,(A_NODE*)$1,0,(A_NODE*)$3);}
	;
multiplicative_expression
	: cast_expression {$$=$1;}
	| multiplicative_expression STAR cast_expression {$$=(YYSTYPE)makeNode(N_EXP_MUL,(A_NODE*)$1,0,(A_NODE*)$3);}
	| multiplicative_expression SLASH cast_expression {$$=(YYSTYPE)makeNode(N_EXP_DIV,(A_NODE*)$1,0,(A_NODE*)$3);}
	| multiplicative_expression PERCENT cast_expression {$$=(YYSTYPE)makeNode(N_EXP_MOD,(A_NODE*)$1,0,(A_NODE*)$3);}
	;
cast_expression
	: unary_expression {$$=$1;}
	| LP type_name RP cast_expression {$$=(YYSTYPE)makeNode(N_EXP_CAST,(A_NODE*)$2,0,(A_NODE*)$4);}
	;
unary_expression
	: postfix_expression {$$=$1;}
	| PLUSPLUS unary_expression {$$=(YYSTYPE)makeNode(N_EXP_PRE_INC,0,(A_NODE*)$2,0);}
	| MINUSMINUS unary_expression {$$=(YYSTYPE)makeNode(N_EXP_PRE_DEC,0,(A_NODE*)$2,0);}
	| AMP cast_expression {$$=(YYSTYPE)makeNode(N_EXP_AMP,0,(A_NODE*)$2,0);}
	| STAR cast_expression {$$=(YYSTYPE)makeNode(N_EXP_STAR,0,(A_NODE*)$2,0);}
	| EXCL cast_expression {$$=(YYSTYPE)makeNode(N_EXP_NOT,0,(A_NODE*)$2,0);}
	| MINUS cast_expression {$$=(YYSTYPE)makeNode(N_EXP_MINUS,0,(A_NODE*)$2,0);}
	| PLUS cast_expression {$$=(YYSTYPE)makeNode(N_EXP_PLUS,0,(A_NODE*)$2,0);}
	| SIZEOF_SYM unary_expression {$$=(YYSTYPE)makeNode(N_EXP_SIZE_EXP,0,(A_NODE*)$2,0);}
	| SIZEOF_SYM LP type_name RP {$$=(YYSTYPE)makeNode(N_EXP_SIZE_TYPE,0,(A_NODE*)$3,0);}
	;
postfix_expression
	: primary_expression {$$=$1;}
	| postfix_expression LB expression RB {$$=(YYSTYPE)makeNode(N_EXP_ARRAY,(A_NODE*)$1,0,(A_NODE*)$3);}
	| postfix_expression LP arg_expression_list_opt RP {$$=(YYSTYPE)makeNode(N_EXP_FUNCTION_CALL,(A_NODE*)$1,0,(A_NODE*)$3);}
	| postfix_expression PERIOD IDENTIFIER {$$=(YYSTYPE)makeNode(N_EXP_STRUCT,(A_NODE*)$1,0,(A_NODE*)$3);}
	| postfix_expression ARROW IDENTIFIER {$$=(YYSTYPE)makeNode(N_EXP_ARROW,(A_NODE*)$1,0,(A_NODE*)$3);}
	| postfix_expression PLUSPLUS {$$=(YYSTYPE)makeNode(N_EXP_POST_INC,0,(A_NODE*)$1,0);}
	| postfix_expression MINUSMINUS {$$=(YYSTYPE)makeNode(N_EXP_POST_DEC,0,(A_NODE*)$1,0);}
	;
primary_expression
	: IDENTIFIER {$$=(YYSTYPE)makeNode(N_EXP_IDENT,0,(A_NODE*)getIdentifierDeclared((char*)$1),0);}
	| INTEGER_CONSTANT {$$=(YYSTYPE)makeNode(N_EXP_INT_CONST,0,(A_NODE*)$1,0);}
	| FLOAT_CONSTANT {$$=(YYSTYPE)makeNode(N_EXP_FLOAT_CONST,0,(A_NODE*)$1,0);}
	| CHARACTER_CONSTANT {$$=(YYSTYPE)makeNode(N_EXP_CHAR_CONST,0,(A_NODE*)$1,0);}
	| STRING_LITERAL {$$=(YYSTYPE)makeNode(N_EXP_STRING_LITERAL,0,(A_NODE*)$1,0);}
	| LP expression RP {$$=$2;}
	;
type_name
	: declaration_specifiers abstract_declarator_opt {$$=(YYSTYPE)setTypeNameSpecifier((A_TYPE*)$2,(A_SPECIFIER*)$1);}
	;
%%

int yywrap()
{
	return 1;
}
