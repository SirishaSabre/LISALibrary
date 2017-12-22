package com.itko.lisa.ext.sabre.step.edifact;

import com.itko.lisa.test.*;
import com.itko.util.ParameterList;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Element;

import java.util.Map;

/**
 * Custom LISA node which creates an Host-to-Host header block based on v
 * alues specified in the step
 *
 * @author <a href="mailto:rick.bansal@ca.com">Rick Bansal</a>
 */
@SuppressWarnings({"rawtypes", "unused"})
public class SabreHTHHeaderStepCharacterSetB implements CustJavaNodeInterface {
    private static final long serialVersionUID = -1920658175701471965L;
    private static final Log log = LogFactory.getLog(SabreHTHHeaderStep.class);

    private static final String CR = "\r";

    private static final String LAYER_4_GFI_DEFAULT = "V";
    private static final String LAYER_4_VER_DEFAULT = ".";
    private static final String LAYER_4_END = CR;

    private static final String LAYER_5_GFI_DEFAULT = "V";
    private static final String LAYER_5_ORI1_DEFAULT = "H";
    private static final String LAYER_5_ORI2_DEFAULT = "D";
    private static final String LAYER_5_ORI3_DEFAULT = "D";
    private static final String LAYER_5_ORI4_DEFAULT = ".";
    private static final String LAYER_5_ORI5_DEFAULT = "T";
    private static final String LAYER_5_ORI6_DEFAULT = "A";
    private static final String LAYER_5_ORI7_DEFAULT = "A";
    private static final String LAYER_5_SEPARATOR = "/";
    private static final String LAYER_5_ADDR1_DEFAULT = "I1";
    private static final String LAYER_5_ADDR2_DEFAULT = "E1";
    private static final String LAYER_5_TPR_DEFAULT = "P0000";
    private static final String LAYER_5_WHY_DEFAULT = "..";
    private static final String LAYER_5_OCTECT1_DEFAULT = "0";
    private static final String LAYER_5_OCTECT2_DEFAULT = "0";
    private static final String LAYER_5_END = CR;

    private static final String LAYER_6_GFI_DEFAULT = "V";
    private static final String LAYER_6_DPD_DEFAULT = "G";
    private static final String LAYER_6_CFT_DEFAULT = "Y";
    private static final String LAYER_6_SDI_DEFAULT = "A";
    private static final String LAYER_6_END = CR;

    private static final String LAYER_5_ORI1_PROP = "Layer_5_ORI1";
    private static final String LAYER_5_ORI2_PROP = "Layer_5_ORI2";
    private static final String LAYER_5_ORI3_PROP = "Layer_5 ORI3";
    private static final String LAYER_5_ORI5_PROP = "Layer_5_ORI5";
    private static final String LAYER_5_ORI6_PROP = "Layer_5_ORI6";
    private static final String LAYER_5_ADDR1_PROP = "Layer_5_Destination_Address";
    private static final String LAYER_5_ADDR2_PROP = "Layer_5_Source_Address";
    private static final String LAYER_5_TPR_PROP = "Layer_5_TPR";

    private static final String PARAM_DELIMITER = "=&";
    private static final String PARAM_END = "=";

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

        paramBuffer.append(LAYER_5_ORI1_PROP).append(PARAM_DELIMITER)
                .append(LAYER_5_ORI2_PROP).append(PARAM_DELIMITER)
                .append(LAYER_5_ORI3_PROP).append(PARAM_DELIMITER)
                .append(LAYER_5_ORI5_PROP).append(PARAM_DELIMITER)
                .append(LAYER_5_ORI6_PROP).append(PARAM_DELIMITER)
                .append(LAYER_5_ADDR1_PROP).append(PARAM_DELIMITER)
                .append(LAYER_5_ADDR2_PROP).append(PARAM_DELIMITER)
                .append(LAYER_5_TPR_PROP).append(PARAM_END);

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
        log.info("SabreHTHHeaderStepCharacterSetB executeNodeLogic invoked");
        StringBuffer headerBuffer = new StringBuffer();
        String headerString;

        try {
            String ori1String = testExec.parseInState(BeanUtils.getProperty(params, LAYER_5_ORI1_PROP));
            String ori2String = testExec.parseInState(BeanUtils.getProperty(params, LAYER_5_ORI2_PROP));
            String ori3String = testExec.parseInState(BeanUtils.getProperty(params, LAYER_5_ORI3_PROP));
            String ori5String = testExec.parseInState(BeanUtils.getProperty(params, LAYER_5_ORI5_PROP));
            String ori6String = testExec.parseInState(BeanUtils.getProperty(params, LAYER_5_ORI6_PROP));
            String addr1String = testExec.parseInState(BeanUtils.getProperty(params, LAYER_5_ADDR1_PROP));
            String addr2String = testExec.parseInState(BeanUtils.getProperty(params, LAYER_5_ADDR2_PROP));
            String tprString = testExec.parseInState(BeanUtils.getProperty(params, LAYER_5_TPR_PROP));

            headerBuffer.append(LAYER_4_GFI_DEFAULT)
                    .append(LAYER_4_VER_DEFAULT)
                    .append(LAYER_4_END)
                    .append(LAYER_5_GFI_DEFAULT)
                    .append(ori1String)
                    .append(ori2String)
                    .append(ori3String)
                    .append(LAYER_5_ORI4_DEFAULT)
                    .append(ori5String)
                    .append(ori6String)
                    .append(LAYER_5_SEPARATOR)
                    .append(addr1String)
                    .append(LAYER_5_SEPARATOR)
                    .append(addr2String)
                    //.append(LAYER_5_SEPARATOR)
                    //.append(tprString)
                    .append(LAYER_5_END)
                    .append(LAYER_6_GFI_DEFAULT)
                    .append(LAYER_6_DPD_DEFAULT)
                    .append(LAYER_6_CFT_DEFAULT)
                    .append(LAYER_6_SDI_DEFAULT)
                    .append(LAYER_6_END);
        } catch (Exception ex) {
            log.error("executeNodeLogic:" + ex.getLocalizedMessage(), ex);
            throw new RuntimeException("Unable to build host-to-host header! " + ex.getLocalizedMessage(), ex);
        }

        headerString = headerBuffer.toString();

        /*
        byte[] byteArray = headerString.getBytes();
        char[] charArray = headerString.toCharArray();
        */

        return headerString;
    }
}

