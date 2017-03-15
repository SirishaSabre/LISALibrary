package com.itko.lisa.ext.sabre.step.edifact;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.Socket;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Element;

import com.itko.lisa.test.CustJavaNodeInterface;
import com.itko.lisa.test.TestCase;
import com.itko.lisa.test.TestDefException;
import com.itko.lisa.test.TestExec;
import com.itko.lisa.test.TestRunException;
import com.itko.util.ParameterList;

/**
 * Custom LISA node which creates an Host-to-Host header block based on v
 * alues specified in the step
 *
 * @author <a href="mailto:rick.bansal@ca.com">Rick Bansal</a>
 */
public class SabreRawSocketClientXMLStep implements CustJavaNodeInterface
{
    private static final long serialVersionUID = -1920658175701471965L;
    private static final Log log = LogFactory.getLog(SabreRawSocketClientXMLStep.class);

    private static final String SOCKET_DEST_IPADDRESS_PROP = "Socket_Destination_IPAddress";
    private static final String SOCKET_DEST_PORT_PROP = "Socket_Destination_PortNumber";
    private static final String EDIFACT_HTH_HEADER_PROP = "HTH_Header_Property";
    private static final String EDIFACT_PAYLOAD_PROP = "EDIFACT_Payload_Property";
    private static final String EDIFACT_RESPONSE_MSG_PROP = "EDIFACT_Response_Message_Property";
    private static final String EDIFACT_FORMATTED_MSG_PROP = "EDIFACT_Formatted_Message_Property";

    private static final String PARAM_DELIMITER = "=&";
    private static final String PARAM_END = "=";

    /**
     * This is the required call to initialize.
     *
     * @param test
     * @param node
     * @throws TestDefException
     */
    public void initialize(TestCase test, Element node) throws TestDefException
    {
        log.debug("initialize: start");
    }

    /**
     * This is a required call to getClassName.
     *
     * @return a <code>String</code>
     */
    public String getClassName()
    {
        return SabreRawSocketClientXMLStep.class.getName();
    }

    /**
     * This is the required call to getParameters.
     *
     * @return a <code>ParameterList</code>
     */
    public ParameterList getParameters()

    {
        StringBuffer paramBuffer = new StringBuffer();

        paramBuffer.append(SOCKET_DEST_IPADDRESS_PROP).append(PARAM_DELIMITER)
                .append(SOCKET_DEST_PORT_PROP).append(PARAM_DELIMITER)
                .append(EDIFACT_HTH_HEADER_PROP).append(PARAM_DELIMITER)
                .append(EDIFACT_PAYLOAD_PROP).append(PARAM_DELIMITER)
                .append(EDIFACT_RESPONSE_MSG_PROP).append(PARAM_END)
                .append(EDIFACT_FORMATTED_MSG_PROP).append(PARAM_END);


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
    public Object executeNodeLogic(TestExec testExec, Map params) throws TestRunException
    {
        StringBuffer msgBuffer = new StringBuffer();
        String message;
        try
		{
            //
            //  Read in step data
            //
            String dest_ipAddrString = testExec.parseInState(BeanUtils.getProperty(params, SOCKET_DEST_IPADDRESS_PROP));
            String dest_portString = testExec.parseInState(BeanUtils.getProperty(params, SOCKET_DEST_PORT_PROP));
            String hth_headerString = testExec.parseInState(BeanUtils.getProperty(params, EDIFACT_HTH_HEADER_PROP));
            String edifact_payloadString = testExec.parseInState(BeanUtils.getProperty(params, EDIFACT_PAYLOAD_PROP));
            String edifact_responseProperty = testExec.parseInState(BeanUtils.getProperty(params, EDIFACT_RESPONSE_MSG_PROP));
            String edifact_formatted_Property = testExec.parseInState(BeanUtils.getProperty(params, EDIFACT_FORMATTED_MSG_PROP));

            edifact_payloadString = XmlToEdicatConverterSellV3.convertXmlToEdicatMessage(edifact_payloadString);

            System.out.println("edifact_payload String::" + edifact_payloadString);

            /* 
             * Create an EDI message with the following structure:
             *    |---------------------|
             *    |  Length (2 bytes)   | --> length = size of (length + header + payload)
             *    |---------------------|
             *    |                     |
             *    |  Header (varialbe)  |
             *    |                     |
             *    |---------------------|
             *    |                     |
             *    | Payload (varialbe)  |
             *    |                     |
             *    |---------------------|
             */
            String edi_wireMsg = edifact_payloadString.replaceAll("'\n", "'");

            System.out.println("SabreRawSocketClientXMLStep edi_wireMsg::" + edi_wireMsg);
            System.out.println("SabreRawSocketClientXMLStep edi_wireMsg.length::" + edi_wireMsg.length());

            message = "Sending the following header to destination:" + "\n" + hth_headerString + "\n\n";
            message = "Sending the following header to destination.length:" + "\n" + hth_headerString.length() + "\n\n";

            message = message + "Sending the following message to destination:" + "\n" + edi_wireMsg + "\n\n";

            message = message + "Sending the following bytes to destination:" + "\n"
                    + dest_ipAddrString + ":" + dest_portString + "\n"
                    + "=========================================== " + "\n\n";

//            short messageLength = (short) (hth_headerString.length() + edifact_payloadString.length() + 2);
            short messageLength = (short) (hth_headerString.length() + edi_wireMsg.length() + 2);

//            msgBuffer.append(hth_headerString)
//                     .append(edifact_payloadString);
            msgBuffer.append(hth_headerString)
                    .append(edi_wireMsg);

            byte[] lenBytes = SabreUtils.short2ByteArray(messageLength);
            byte[] msgBytes = msgBuffer.toString().getBytes();

            byte[] allOutputBytes = SabreUtils.catBytes(lenBytes, msgBytes);

            message += SabreUtils.byteArrayToHexStringFormatted(allOutputBytes) + "\n\n";


            //
            // Create socket and open the i/o streams for sending and receiving EDIFACT messages
            //
            Socket clientSocket = new Socket(dest_ipAddrString, Integer.parseInt(dest_portString));

            DataOutputStream os = new DataOutputStream(clientSocket.getOutputStream());
            DataInputStream is = new DataInputStream(clientSocket.getInputStream());

            //
            // write message to output stream
            //
            os.write(allOutputBytes, 0, allOutputBytes.length);

            //
            // wait on response - first read in the lenght bytes to determine message sise
            //
            byte[] ediResponseMsgBytes = new byte[65000];
            byte[] ediResponseMsgLengthBytes = new byte[2];

            is.read(ediResponseMsgLengthBytes, 0, 2);

            int responseMsgLength = SabreUtils.byteArray2Int(ediResponseMsgLengthBytes);
            is.read(ediResponseMsgBytes, 0, responseMsgLength - 2);

            String responseString = new String(ediResponseMsgBytes);

            //
            // save response to a property
            //
            String formattedResponse = "";
            if (StringUtils.isNotBlank(responseString))
            {
                responseString = responseString.trim();
                String temp = responseString.substring(responseString.indexOf("UNB"));
                formattedResponse = StringUtils.replace(temp, "'", "'\n");

                testExec.setStateValue(edifact_responseProperty, responseString);

                if (edifact_formatted_Property != null)
                {
                    testExec.setStateValue(edifact_formatted_Property, formattedResponse);
                }
            }


            message += "Received the following response:" + "\n"
                    + "--------------------------------" + "\n"
                    + responseString + "\n";

            message += "\n\nFormatted response:" + "\n"
                    + "--------------------------------" + "\n"
                    + formattedResponse + "\n";
            clientSocket.close();
            
            /*
            */
        } catch (Exception ex)
        {
            log.error("executeNodeLogic:" + ex.getLocalizedMessage(), ex);
            throw new RuntimeException("Unable to send message on socket " + ex.getLocalizedMessage(), ex);
        }
       return message;
    }
}
