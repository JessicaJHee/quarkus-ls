/*******************************************************************************
* Copyright (c) 2022 Red Hat Inc. and others.
* All rights reserved. This program and the accompanying materials
* which accompanies this distribution, and is available at
* http://www.eclipse.org/legal/epl-v20.html
*
* SPDX-License-Identifier: EPL-2.0
*
* Contributors:
*     Red Hat Inc. - initial API and implementation
*******************************************************************************/
package com.redhat.qute.commons.datamodel.resolvers;

/**
 * Represents the kind of a value resolver.
 * 
 * @author datho7561
 */
public enum ValueResolverKind {
	TemplateData(1), //
	TemplateEnum(2), //
	TemplateExtensionOnMethod(3), //
	TemplateExtensionOnClass(4), //
	TemplateGlobal(5), //
	InjectedBean(6), //
	Message(7), //
	Renarde(8);

	private final int value;

	ValueResolverKind(int value) {
		this.value = value;
	}

	public int getValue() {
		return value;
	}

	public static ValueResolverKind forValue(int value) {
		ValueResolverKind[] allValues = ValueResolverKind.values();
		if (value < 1 || value > allValues.length)
			throw new IllegalArgumentException("Illegal enum value: " + value);
		return allValues[value - 1];
	}

	public String toString() {
		return this.name();
	}

}
