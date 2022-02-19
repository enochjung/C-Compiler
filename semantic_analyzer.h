#ifndef __SEMANTIC_ANALYZER_H__
#define __SEMANTIC_ANALYZER_H__

#include "type.h"
#define LIT_MAX 100

void semantic_analysis(A_NODE *);
void set_literal_address(A_NODE *);
void sem_program(A_NODE *);
int put_literal(A_LITERAL, int);
A_TYPE *sem_expression(A_NODE *);
void sem_arg_expr_list(A_NODE *, A_ID *);
BOOLEAN isModifiableLvalue(A_NODE *);
int sem_statement(A_NODE *, int, A_TYPE *, BOOLEAN, BOOLEAN, BOOLEAN);
void sem_for_expression(A_NODE *);
int sem_statement_list(A_NODE *, int, A_TYPE *, BOOLEAN, BOOLEAN, BOOLEAN);
int sem_A_TYPE(A_TYPE *);
int sem_declaration_list(A_ID *, int);
int sem_declaration(A_ID *, int);
A_ID *getStructFieldIdentifier(A_TYPE *, char *);
A_ID *getPointerFieldIdentifier(A_TYPE *, char *);
//BOOLEAN isSameParameterType(A_ID *, A_ID *);
BOOLEAN isCompatibleType(A_TYPE *, A_TYPE *);
BOOLEAN isConstantZeroExp(A_NODE *);
BOOLEAN isCompatiblePointerType(A_TYPE *, A_TYPE *);
A_NODE *convertScalarToInteger(A_NODE *);
A_NODE *convertUsualAssignmentConversion(A_TYPE *, A_NODE *);
A_NODE *convertUsualUnaryConversion(A_NODE *);
A_TYPE *convertUsualBinaryConversion(A_NODE *);
A_NODE *convertCastingConversion(A_NODE *, A_TYPE *);
BOOLEAN isAllowableAssignmentConversion(A_TYPE *, A_TYPE *, A_NODE *);
BOOLEAN isAllowableCastingConversion(A_TYPE *, A_TYPE *);
BOOLEAN isFloatType(A_TYPE *);
BOOLEAN isArithmeticType(A_TYPE *);
BOOLEAN isScalarType(A_TYPE *);
BOOLEAN isAnyIntegerType(A_TYPE *);
BOOLEAN isIntegralType(A_TYPE *);
BOOLEAN isFunctionType(A_TYPE *);
BOOLEAN isStructOrUnionType(A_TYPE *);
BOOLEAN isPointerType(A_TYPE *);
BOOLEAN isPointerOrArrayType(A_TYPE *);
BOOLEAN isIntType(A_TYPE *);
BOOLEAN isVoidType(A_TYPE *);
BOOLEAN isArrayType(A_TYPE *);
BOOLEAN isStringType(A_TYPE *);
A_LITERAL checkTypeAndConvertLiteral(A_LITERAL, A_TYPE *, int);
A_LITERAL getTypeAndValueOfExpression(A_NODE *);
void semantic_error(int, int, char*);
void semantic_warning(int, int);
BOOLEAN isNotSameType(A_TYPE *, A_TYPE *);
//void setTypeSize(A_TYPE *, int);
A_TYPE** sem_initializer(A_NODE *);
BOOLEAN isCompatibleInitializer(A_ID *);

#endif
