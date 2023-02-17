/*******************************************************************************
* Copyright (c) 2023 Red Hat Inc. and others.
* All rights reserved. This program and the accompanying materials
* which accompanies this distribution, and is available at
* http://www.eclipse.org/legal/epl-v20.html
*
* SPDX-License-Identifier: EPL-2.0
*
* Contributors:
*     Red Hat Inc. - initial API and implementation
*******************************************************************************/
package com.redhat.qute.ls.api;

import com.redhat.qute.parser.template.Template;

/**
 * {@link Template} provider.
 *
 */
public interface QuteTemplateProvider {

	/**
	 * Returns the {@link Template} instance from the given <code>uri</code> and
	 * null otherwise.
	 * 
	 * @param uri the document URI.
	 * @return the {@link Template} instance from the given <code>uri</code> and
	 *         null otherwise.
	 */
	Template getTemplate(String uri);

}