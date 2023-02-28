/*******************************************************************************
 * Copyright (c) 2023 Red Hat Inc. and others. All rights reserved. This program and the
 * accompanying materials which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v20.html
 * 
 * SPDX-License-Identifier: EPL-2.0
 * 
 * Contributors: Red Hat Inc. - initial API and implementation
 * *****************************************************************************
 */

/**
 * Defines the parser and lexer for https://quarkus.io/guides/qute-reference#expressions
 */
grammar Expression;

/*
 * Parser rules
 */

expressionWrapped: (OPEN_CURLY_BRACE expression CLOSE_CURLY_BRACE)+;
expression:
	part // ex: {item.name} - objectPart + propertyPart/methodPart
	| objectPart // ex: {name}
	| partBracketNotation // ex: {item['name']} 
	| infixExpression; // ex: name or 'John'

part:
	objectPart DOT_OPERATOR propertyPart // ex: item.name
	| objectPart DOT_OPERATOR methodPart; // ex: item.getLabel(1)

partBracketNotation: (namespace ':')? (
		objectPart '[\'' propertyPart '\']'
	);

infixExpression: (part | objectPart | literal) operator (
		part
		| objectPart
		| literal
	);

objectPart: (namespace ':')? STRING;
propertyPart: STRING;
namespace: STRING;

methodPart: methodName OPEN_PAREN args CLOSE_PAREN;
methodName: STRING;
args: (literal) (',' literal)*;

operator:
	logicalComplement
	| greaterThan
	| greaterThanOrEqualTo
	| lessThan
	| lessThanOrEqualTo
	| equals
	| not
	| and
	| or;

logicalComplement: 'logical complement' | '!';
greaterThan: 'greater than' | 'gt' | '>';
greaterThanOrEqualTo: 'greater than or equal to ' | 'ge' | '>=';
lessThan: 'less than' | 'lt' | '<';
lessThanOrEqualTo: 'less than or equal to ' | 'le' | '<=';
equals: 'equals' | 'eq' | '==' | 'is';
not: 'not equals' | 'ne' | '!=';
and: '&&' | 'and';
or: '||' | 'or';

literal:
	numberLiteral
	| booleanLiteral
	| stringLiteral
	| voidLiteral;
numberLiteral: NUMBER_LITERAL;
booleanLiteral: BOOLEAN_LITERAL;
stringLiteral: SINGLE_QUOTE_STRING | DOUBLE_QUOTE_STRING;
voidLiteral: NULL;

/*
 * Lexer Rules
 */

WHITESPACE: [ \t\n\r]+ -> skip;
OPEN_PAREN: '(';
CLOSE_PAREN: ')';
OPEN_SQUARE_BRACE: '[';
CLOSE_SQUARE_BRACE: ']';
OPEN_CURLY_BRACE: '{';
CLOSE_CURLY_BRACE: '}';
COLON: ':';
QUESTION_MARK: '?';

/* operators */
DOT_OPERATOR: '.';
HASH: '#';
SLASH: '/';

SINGLE_QUOTE_STRING: '\'' STRING '\'';
DOUBLE_QUOTE_STRING: '\'' STRING '\'';
STRING: [a-zA-Z]+;
NUMBER_LITERAL: [0-9]+;
BOOLEAN_LITERAL: 'true' | 'false';
NULL: 'null';
