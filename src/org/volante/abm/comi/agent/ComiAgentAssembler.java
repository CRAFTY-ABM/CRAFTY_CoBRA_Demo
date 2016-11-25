/**
 * 
 */
package org.volante.abm.comi.agent;


import org.volante.abm.agent.LandUseAgent;
import org.volante.abm.agent.assembler.DefaultSocialAgentAssembler;
import org.volante.abm.comi.serialization.ComiPropertyInitialiser;
import org.volante.abm.data.Cell;

/**
 * @author Sascha Holzhauer
 *
 */
public class ComiAgentAssembler extends DefaultSocialAgentAssembler {

	/**
	 * @see org.volante.abm.agent.assembler.DefaultSocialAgentAssembler#assembleAgent(org.volante.abm.data.Cell, int,
	 *      int, java.lang.String)
	 */
	public LandUseAgent assembleAgent(Cell homecell, int btIdInitial, int frIdInitial, String id) {
		LandUseAgent luagent = super.assembleAgent(homecell, btIdInitial, frIdInitial, id);
		int curTick = this.rinfo.getSchedule().getCurrentTick();
		luagent.setProperty(ComiPropertyInitialiser.AgentProperty.START_TICK, (double) (curTick == 2000 ? 1998
		        : curTick));
		return luagent;
	}
}
