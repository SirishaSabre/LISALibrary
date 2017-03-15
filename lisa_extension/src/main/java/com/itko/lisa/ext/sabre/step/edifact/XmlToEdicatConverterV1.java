package com.itko.lisa.ext.sabre.step.edifact;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamReader;
import java.io.ByteArrayInputStream;

/**
 * Created by SG0222123 on 8/2/2016.
 */
public class XmlToEdicatConverterV1 {

    public static String convertXmlToEdicatMessage(String inputXML) throws Exception {

        System.out.println("inputXML::" + inputXML);

        String[] xmlElem = new String[255];
        String[] xmlData = new String[255];
        String[] xmlDelim = new String[255];
        String buffer;
        buffer = "";

        int x = 0;
        char del_colon = 'F';

        XMLInputFactory inputFactory = XMLInputFactory.newInstance();
        XMLStreamReader xmlStreamReader = inputFactory.createXMLStreamReader(new ByteArrayInputStream(inputXML.getBytes()));

        while (xmlStreamReader.hasNext()) {
            int event = xmlStreamReader.next();

            if (event == XMLStreamConstants.START_ELEMENT) {
                //System.out.println("Element Local Name:" + xmlStreamReader.getLocalName());

                xmlElem[x] = xmlStreamReader.getLocalName();
                if ("Component".equals(xmlElem[x])) {
                    del_colon = 'T';
                }
            }

            if (event == XMLStreamConstants.CHARACTERS) {
                if (!xmlStreamReader.getText().trim().equals("")) {
                    //System.out.println("Text:"+xmlStreamReader.getText().trim());
                    xmlData[x] = xmlStreamReader.getText();
                    if (del_colon == 'T') {
                        xmlDelim[x] = ":";
                    } else {
                        xmlDelim[x] = "+";
                    }
                    //System.out.println(xmlData[x]);
                }
            }

            if (event == XMLStreamConstants.END_ELEMENT) {
                //System.out.println("Element Local Name:" + xmlStreamReader.getLocalName());
                if ("Component".equals(xmlStreamReader.getLocalName())) {
                    del_colon = 'F';
                }
                if ("Segment".equals(xmlStreamReader.getLocalName())) {
                    xmlDelim[x - 1] = "'\n";
                }
                ++x;
            }
        }

        for (int i = 0; i < x; i++) {
            if (xmlData[i] != null && !xmlData[i].isEmpty()) {
                //System.out.println(xmlData[i]);
                buffer = buffer.concat(xmlData[i]);
                buffer = buffer.concat(xmlDelim[i]);
            }
        }

        System.out.println(buffer.replaceAll("'\n", "'"));
        return buffer;
    }

    public static void main(String[] args) throws Exception {
        String inputXML = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<p1:Paoreq xmlns:p1=\"http://ihp271:7001/aircore/bkg/paoreq.xsd\"\n" +
                "       xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                "       <!-- UNB+IATB:1+1SRES+H1RES+090810:1251+409B0000C10001++TR2+S' UNH+1+PAOREQ:96:2:IA+09823130001272' \n" +
                "              MSG+:46' ORG+1S+27213723:L8TH+ATH++T+GR+EUR+BFM' ODI+AMS+FRA' TVL+070815+AMS+FRA+IB+8901+1+1+P' \n" +
                "              ODI+FRA+AMS' TVL+090815+FRA+AMS+IB+8902+1+1+P' UNT+9+1' UNZ+1+409B0000C10001' -->\n" +
                "       <Segment>\n" +
                "              <SegmentTAG>UNB</SegmentTAG>\n" +
                "              <SyntaxId>IATB</SyntaxId>\n" +
                "              <SyntaxVersionNumber>1</SyntaxVersionNumber>\n" +
                "              <SenderId>1HRES</SenderId>\n" +
                "              <RecipientId>AARES</RecipientId>\n" +
                "              <Component>\n" +
                "                     <msgDate>160707</msgDate>\n" +
                "                     <msgTime>1200</msgTime>\n" +
                "              </Component>\n" +
                "              <interchangeControlRef>409B0000C10001</interchangeControlRef>\n" +
                "              <Placeholder>+</Placeholder>\n" +
                "              <ApplicationReference>TR2</ApplicationReference>\n" +
                "              <ProcessingPriorityCode>S</ProcessingPriorityCode>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentTag>UNH</SegmentTag>\n" +
                "              <MsgType>1</MsgType>\n" +
                "              <Component>\n" +
                "                     <MsgRef>PAOREQ</MsgRef>\n" +
                "                     <MsgVer>96</MsgVer>\n" +
                "                     <MsgRel>2</MsgRel>\n" +
                "                     <CtlAgy>IA</CtlAgy>\n" +
                "              </Component>\n" +
                "              <AssocCd>9F101B600120192</AssocCd>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentTAG>MSG</SegmentTAG>\n" +
                "              <MessageFunction>46</MessageFunction>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentTAG>ORG</SegmentTAG>\n" +
                "              <AirlineCompanyId>1S</AirlineCompanyId>\n" +
                "              <Component>\n" +
                "                     <In-HouseIdCode>L8TH</In-HouseIdCode>\n" +
                "                     <SpecificLocationId>ATH</SpecificLocationId>\n" +
                "              </Component>\n" +
                "              <Placeholder></Placeholder>\n" +
                "              <OriginatorTypeCode>T</OriginatorTypeCode>\n" +
                "              <Country>GR</Country>\n" +
                "              <OriginatorsAuthReqCd>EUR</OriginatorsAuthReqCd>\n" +
                "              <CommNumber>BFM</CommNumber>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentHDR>ODI</SegmentHDR>\n" +
                "              <OriginLoc>AMS</OriginLoc>\n" +
                "              <DestLocId>FRA</DestLocId>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentHDR>TVL</SegmentHDR>\n" +
                "              <FirstDate>070815</FirstDate>\n" +
                "              <OriginLocId>AMS</OriginLocId>\n" +
                "              <DestLocId>FRA</DestLocId>\n" +
                "              <MarketingCompanyId>IB</MarketingCompanyId>\n" +
                "              <ProductId>8901</ProductId>\n" +
                "              <SequenceNumber>1</SequenceNumber>\n" +
                "              <AvailDisplayLineNumber>1</AvailDisplayLineNumber>\n" +
                "              <ActionRequired>P</ActionRequired>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentHDR>ODI</SegmentHDR>\n" +
                "              <OriginLoc>FRA</OriginLoc>\n" +
                "              <DestLocId>AMS</DestLocId>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentHDR>TVL</SegmentHDR>\n" +
                "              <FirstDate>090815</FirstDate>\n" +
                "              <OriginLocId>FRA</OriginLocId>\n" +
                "              <DestLocId>AMS</DestLocId>\n" +
                "              <MarketingCompanyId>IB</MarketingCompanyId>\n" +
                "              <ProductId>8902</ProductId>\n" +
                "              <SequenceNumber>1</SequenceNumber>\n" +
                "              <AvailDisplayLineNumber>1</AvailDisplayLineNumber>\n" +
                "              <ActionRequired>P</ActionRequired>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentHDR>UNT</SegmentHDR>\n" +
                "              <NumOfSegsInMsg>8</NumOfSegsInMsg>\n" +
                "              <MsgReferenceNum>1</MsgReferenceNum>\n" +
                "       </Segment>\n" +
                "       <Segment>\n" +
                "              <SegmentHDR>UNZ</SegmentHDR>\n" +
                "              <InterchangeCtlCnt>1</InterchangeCtlCnt>\n" +
                "              <InterchangeCtlRef>409B0000C10001</InterchangeCtlRef>\n" +
                "       </Segment>\n" +
                "</p1:Paoreq>\n";
        System.out.println(convertXmlToEdicatMessage(inputXML));
    }

}
