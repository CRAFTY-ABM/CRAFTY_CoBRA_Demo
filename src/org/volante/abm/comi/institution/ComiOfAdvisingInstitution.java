/**
 * 
 */
package org.volante.abm.comi.institution;


import org.simpleframework.xml.Attribute;
import org.simpleframework.xml.Element;
import org.volante.abm.institutions.AbstractSocialCobraInstitution;

/**
 * @author Sascha Holzhauer
 *
 */
public class ComiOfAdvisingInstitution extends AbstractSocialCobraInstitution {

	@Element(required = false)
	protected double pbcFactor = 1.0;

	/**
	 * @param id
	 */
	public ComiOfAdvisingInstitution(@Attribute(name = "id") String id) {
		super(id);
	}

}
