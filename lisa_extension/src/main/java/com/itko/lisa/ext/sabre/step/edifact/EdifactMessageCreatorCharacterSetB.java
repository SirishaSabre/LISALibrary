package com.itko.lisa.ext.sabre.step.edifact;

import com.itko.lisa.test.*;
import com.itko.util.ParameterList;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Element;

import java.util.Map;

/**
 * Created by SG0222123 on 8/22/2016.
 */
public class EdifactMessageCreatorCharacterSetB implements CustJavaNodeInterface {
    private static final long serialVersionUID = -1920658175701471965L;
    private static final Log log = LogFactory.getLog(EdifactMessageCreator.class);

    private static final String EDIFACT_HTH_HEADER_PROP = "HTH_Header_Property";
    private static final String EDIFACT_PAYLOAD_PROP = "EDIFACT_Payload_Property";
    private static final String EDIFACT_MSG_OUTPUT_PROP = "Encoded_Edifact_Binary_Message";

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
        return SabreRawSocketClientXMLStep.class.getName();
    }

    /**
     * This is the required call to getParameters.
     *
     * @return a <code>ParameterList</code>
     */
    public ParameterList getParameters() {
        StringBuffer paramBuffer = new StringBuffer();

        paramBuffer.append(EDIFACT_HTH_HEADER_PROP).append(PARAM_DELIMITER)
                .append(EDIFACT_PAYLOAD_PROP).append(PARAM_DELIMITER)
                .append(EDIFACT_MSG_OUTPUT_PROP).append(PARAM_END);

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
    @SuppressWarnings({"rawtypes"})
    public Object executeNodeLogic(TestExec testExec, Map params) throws TestRunException {
        StringBuffer msgBuffer = new StringBuffer();
        String message = "";
        try {

            String hth_headerString = testExec.parseInState(BeanUtils.getProperty(params, EDIFACT_HTH_HEADER_PROP));
            String edifact_payloadString = testExec.parseInState(BeanUtils.getProperty(params, EDIFACT_PAYLOAD_PROP));
            String edifactMsgOutputProp = testExec.parseInState(BeanUtils.getProperty(params, EDIFACT_MSG_OUTPUT_PROP));

            /*
             * Create an EDI message with the following structure:
             *    |---------------------|
             *    |  Header (varialbe)  |
             *    |                     |
             *    |---------------------|
             *    |                     |
             *    | Payload (varialbe)  |
             *    |                     |
             *    |---------------------|
             */
            String edi_wireMsg = edifact_payloadString.replaceAll("'\n", "'");

            message = message + "edi_wireMsg before special characters:\n" + SabreUtils.byteArrayToHexStringFormatted(edi_wireMsg.getBytes()) + "\n\n";

            edi_wireMsg = StringUtils.replaceChars(edi_wireMsg, '+', (char) 0x1D);
            edi_wireMsg = StringUtils.replaceChars(edi_wireMsg, ':', (char) 0x1F);
            edi_wireMsg = StringUtils.replaceChars(edi_wireMsg, '\'', (char) 0x1C);

            message = message + "edi_wireMsg after special characters:\n" + SabreUtils.byteArrayToHexStringFormatted(edi_wireMsg.getBytes()) + "\n\n";

            message = message + "Sending the following header to destination:" + "\n" + hth_headerString + "\n\n";

            message = message + "Sending the following message to destination:" + "\n" + edi_wireMsg + "\n\n";

            msgBuffer.append(hth_headerString)
                    .append(edi_wireMsg);

            byte[] msgBytes = msgBuffer.toString().getBytes();

            testExec.setStateObject(edifactMsgOutputProp, msgBytes);

            message += SabreUtils.byteArrayToHexStringFormatted(msgBytes) + "\n\n";

        } catch (Exception ex) {
            log.error("executeNodeLogic:" + ex.getLocalizedMessage(), ex);
            throw new RuntimeException("Unable to create message " + ex.getLocalizedMessage(), ex);
        }

        return message;
    }
}

