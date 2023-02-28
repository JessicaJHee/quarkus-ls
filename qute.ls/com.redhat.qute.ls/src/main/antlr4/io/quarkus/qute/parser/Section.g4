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
 * Defines the parser and lexer for https://quarkus.io/guides/qute-reference#sections
 */
grammar Section;

import Expression;

section: (eachSection | forSection | ifSection | emptySection)+;

// empty section
emptySection:
	STARTSECTION sectionTagName SLASH CLOSE_CURLY_BRACE; // ex: {#emptySection /}

// each section 
eachSection:
	eachStartTag (compValue | section | ANYCONTENT)* endTagSection;

eachStartTag: STARTSECTION 'each' expression CLOSE_CURLY_BRACE;

// for section 
forSection:
	forStartTag (compValue | section | ANYCONTENT)* endTagSection;

forStartTag: STARTSECTION 'for' itr 'in' expression CLOSE_CURLY_BRACE;

// if section 
ifSection:
	ifStartTag (elseSection | elseIfSection)* endTagSection;

ifStartTag:
	STARTSECTION 'if' compValue operator compValue CLOSE_CURLY_BRACE;

elseSection: '{#else}' (compValue | section | ANYCONTENT)*;

elseIfSection:
	STARTSECTION 'else if' compValue operator compValue CLOSE_CURLY_BRACE (
		compValue
		| section
		| ANYCONTENT
	)*;

// commons for all sections
itr: STRING;

endTagSection:
	OPEN_CURLY_BRACE SLASH sectionTagName CLOSE_CURLY_BRACE; // ex: {/sectionTagName}

sectionTagName: STRING;

compValue: expression | literal;

/*
 * Lexer Rules
 */
STARTSECTION: OPEN_CURLY_BRACE HASH;
ANYCONTENT: [.^{}]+;