/**
 * 
 */
package org.volante.abm.comi.output;


import org.geotools.util.UnsupportedImplementationException;
import org.simpleframework.xml.Attribute;
import org.volante.abm.data.ModelData;
import org.volante.abm.data.Regions;
import org.volante.abm.decision.pa.CraftyPa;
import org.volante.abm.output.ActionCSVOutputter.TableEntry;
import org.volante.abm.output.TableColumn;
import org.volante.abm.schedule.RunInfo;

import de.cesr.lara.components.decision.LaraScoreReportingDecider;
import de.cesr.lara.components.model.impl.LModel;


/**
 * NOTE: Log4j logger 'de.cesr.lara.components.decision.impl.LDeliberativeDecider.RowInspection' must be set to level
 * 'DEBUG'!
 * 
 * @author Sascha Holzhauer
 * 
 */
public class PreferenceEffectivenessTableEntry implements TableColumn<TableEntry> {

	@Attribute(required=true)
	protected String preference;
	
	/**
	 * @see org.volante.abm.output.TableColumn#getHeader()
	 */
	@Override
	public String getHeader() {
		return preference;
	}

	/**
	 * @see org.volante.abm.output.TableColumn#getValue(java.lang.Object, org.volante.abm.data.ModelData,
	 *      org.volante.abm.schedule.RunInfo, org.volante.abm.data.Regions)
	 */
	@Override
    public String getValue(TableEntry t, ModelData data, RunInfo info, Regions r) {
		try {
			return ((LaraScoreReportingDecider<CraftyPa<?>>) t.getDecisionData().getDecider()).getScore(t.getPa(),
			        LModel
		        .getModel(r).getPrefRegistry().get(preference))
		        + "";
		} catch (UnsupportedImplementationException ex) {
			throw new IllegalStateException(
			        "The logger 'log4j.logger.de.cesr.lara.components.decision.impl.LDeliberativeDecider.RowInspection' must be set to level 'DEBUG' in order to apply LInspectionBoRows!");
		}
    }
}
