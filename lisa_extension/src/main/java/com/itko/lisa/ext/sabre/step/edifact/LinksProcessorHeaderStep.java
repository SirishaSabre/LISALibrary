package com.itko.lisa.ext.sabre.step.edifact;

import com.itko.lisa.test.*;
import com.itko.util.ParameterList;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Element;

import javax.xml.bind.DatatypeConverter;
import java.util.Map;

/**
 * Custom LISA node which creates an Host-to-Host header block based on v
 * alues specified in the step
 *
 * @author <a href="-lto:rick.bansal@ca.com">Rick Bansal</a>
 */
@SuppressWarnings({"rawtypes", "unused"})
public class LinksProcessorHeaderStep implements CustJavaNodeInterface {
    private static final long serialVersionUID = -1920658175701471965L;
    private static final Log log = LogFactory.getLog(LinksProcessorHeaderStep.class);



    /**
     * This is the required call to initialize.
     *
     * @param test
     * @param node
     * @throws TestDefException
     */
    public void initialize(TestCase test, Element node) throws TestDefException {
        log.debug("initialize: start");
    }

    /**
     * This is a required call to getClassName.
     *
     * @return a <code>String</code>
     */
    public String getClassName() {
        return SabreHTHHeaderStep.class.getName();
    }

    /**
     * This is the required call to getParameters.
     *
     * @return a <code>ParameterList</code>
     */
    public ParameterList getParameters() {
        StringBuffer paramBuffer = new StringBuffer();
        ParameterList parameters = new ParameterList(paramBuffer.toString());

        return parameters;
    }

    /**
     * This is the required call to executeNodeLogic. This method takes the
     * parameters specified on the CustomJavaNode tab of the LISA Test Editor.
     *
     * @param testExec
     * @param params
     * @return the step's response.
     * @throws TestRunException
     */
    public Object executeNodeLogic(TestExec testExec, Map params) throws TestRunException {
     //   String headerString;
     //   headerString = "HDR..... ...RTG.....DQM.....DUMMYDQN.....ATR.....1A_SU_RAAOQM.....slphli101XOQN.....1A_SU_RAASTK.........DTK.........PRO.........";
     //   return headerString;


       String hex = "484452000000007F20000000525447000000007F44514D000000000544554D4D5944514E0000000011415452000000000931415F53555F5241414F514D00000000086C697361627731584F514E000000000931415F53555F52414153544B00000000040014BD1444544B000000000400041CBF50524F000000000400000004";
       byte [] s  = DatatypeConverter.parseHexBinary(hex);
       String output = DatatypeConverter.printHexBinary(s);
       System.out.println("Conversion returns" + output);
       return new String(s);





    }
}
