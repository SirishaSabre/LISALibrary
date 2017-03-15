package com.itko.lisa.ext.sabre.step.edifact;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamReader;
import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by SG0222123 on 8/2/2016.
 */
public class XmlToEdicatConverterV2 {

    public static String convertXmlToEdicatMessage(String inputXML) throws Exception {

        System.out.println("inputXML::" + inputXML);

        List<String> dataList = new ArrayList();

        String buffer;
        buffer = "";

        int x = 0;
        boolean componentStarted = false;
        boolean segmentStarted = false;
        String delimiter = "";

        XMLInputFactory inputFactory = XMLInputFactory.newInstance();
        XMLStreamReader xmlStreamReader = inputFactory.createXMLStreamReader(new ByteArrayInputStream(inputXML.getBytes()));

        while (xmlStreamReader.hasNext()) {
            int event = xmlStreamReader.next();

            if (event == XMLStreamConstants.START_ELEMENT) {
                String localName = xmlStreamReader.getLocalName();

                if ("Component".equals(localName)) {
                    componentStarted = true;
                } else if ("Segment".equals(localName)) {
                    segmentStarted = true;
                }
            }

            if (event == XMLStreamConstants.CHARACTERS) {
                if (!xmlStreamReader.getText().trim().equals("")) {
                    String data = xmlStreamReader.getText();
                    dataList.add(data);
                }
            }

            if (event == XMLStreamConstants.END_ELEMENT) {

                if (componentStarted && !"Component".equals(xmlStreamReader.getLocalName())) {
                    delimiter = ":";
                } else if (componentStarted && "Component".equals(xmlStreamReader.getLocalName())) {
                    componentStarted = false;
                    dataList.remove(dataList.size() - 1);
                    delimiter = "+";
                } else if (segmentStarted && "Segment".equals(xmlStreamReader.getLocalName())) {
                    dataList.remove(dataList.size() - 1);
                    delimiter = "'\n";
                    segmentStarted = false;
                } else if(!"Paoreq".equals(xmlStreamReader.getLocalName())){
                    delimiter = "+";
                }

                if(!delimiter.equals("")) {
                    dataList.add(delimiter);
                }
                delimiter = "";
            }
        }

        for (String data : dataList) {
            buffer = buffer.concat(data);
        }

        return buffer;
    }

    public static void main(String[] args) throws Exception {
        String inputXML = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<p1:Paoreq xmlns:p1=\"http://ihp271:7001/aircore/bkg/paoreq.xsd\"\n" +
                "       xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                "\t<!--UNB+IATA:1+1P+AA+160726:1430+021124'UNH+1+PAOREQ:96:2:IA'MSG+:46'ORG+1P:HDQ+35165001:T4S+LAX+1P+T+US:USD+GS'ODI+JFK+CLT'\n" +
                "\t          TVL+290716+JFK+BOS+AA+1039+2+1+P'TVL+290716+BOS+CLT+AA+703+2+2+P'TVL+290716+JFK+DCA+AA+2183+6+1+P'TVL+290716+DCA+CLT+AA+1720+6+2+P'\n" +
                "\t\t\t  TVL+290716+JFK+RDU+AA+4374+10+1+P'TVL+290716+RDU+CLT+AA+5415+10+2+P'UNT+11+1'UNZ+1+021124'-->\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTAG>UNB</SegmentTAG>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<SyntaxId>IATA</SyntaxId>\n" +
                "\t\t\t<SyntaxVersionNumber>1</SyntaxVersionNumber>\n" +
                "\t\t</Component>\n" +
                "\t\t<SenderId>1P</SenderId>\n" +
                "\t\t<RecipientId>AA</RecipientId>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<msgDate>160808</msgDate>\n" +
                "\t\t\t<msgTime>1200</msgTime>\n" +
                "\t\t</Component>\n" +
                "\t\t<interchangeControlRef>21124</interchangeControlRef>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTag>UNH</SegmentTag>\n" +
                "\t\t<MsgType>1</MsgType>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<MsgRef>PAOREQ</MsgRef>\n" +
                "\t\t\t<MsgVer>96</MsgVer>\n" +
                "\t\t\t<MsgRel>2</MsgRel>\n" +
                "\t\t\t<CtlAgy>IA</CtlAgy>\n" +
                "\t\t</Component>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTAG>MSG</SegmentTAG>\n" +
                "\t\t<MessageFunction>46</MessageFunction>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTAG>ORG</SegmentTAG>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<AirlineCompanyId>1P</AirlineCompanyId>\n" +
                "\t\t\t<In-HouseIdCode>HDQ</In-HouseIdCode>\n" +
                "\t\t</Component>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<AgentIataNbr>35165001</AgentIataNbr>\n" +
                "\t\t\t<AgentPCC>T4S</AgentPCC>\n" +
                "\t\t</Component>\n" +
                "\t\t<AgentCityCode>LAX</AgentCityCode>\n" +
                "\t\t<AirlineCompanyId1>1P</AirlineCompanyId1>\n" +
                "\t\t<OriginatorTypeCode>T</OriginatorTypeCode>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<AgentCountry>US</AgentCountry>\n" +
                "\t\t\t<AgentCurrency>USD</AgentCurrency>\n" +
                "\t\t</Component>\n" +
                "\t\t<AgentAuthority>GS</AgentAuthority>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>ODI</SegmentHDR>\n" +
                "\t\t<OriginLoc>JFK</OriginLoc>\n" +
                "\t\t<DestLocId>CLT</DestLocId>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<FirstDate>290716</FirstDate>\n" +
                "\t\t<OriginLocId>JFK</OriginLocId>\n" +
                "\t\t<DestLocId>BOS</DestLocId>\n" +
                "\t\t<MarketingCompanyId>AA</MarketingCompanyId>\n" +
                "\t\t<ProductId>1039</ProductId>\n" +
                "\t\t<SequenceNumber>2</SequenceNumber>\n" +
                "\t\t<AvailDisplayLineNumber>1</AvailDisplayLineNumber>\n" +
                "\t\t<ActionRequired>P</ActionRequired>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<FirstDate>290716</FirstDate>\n" +
                "\t\t<OriginLocId>BOS</OriginLocId>\n" +
                "\t\t<DestLocId>CLT</DestLocId>\n" +
                "\t\t<MarketingCompanyId>AA</MarketingCompanyId>\n" +
                "\t\t<ProductId>703</ProductId>\n" +
                "\t\t<SequenceNumber>2</SequenceNumber>\n" +
                "\t\t<AvailDisplayLineNumber>2</AvailDisplayLineNumber>\n" +
                "\t\t<ActionRequired>P</ActionRequired>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<FirstDate>290716</FirstDate>\n" +
                "\t\t<OriginLocId>JFK</OriginLocId>\n" +
                "\t\t<DestLocId>DCA</DestLocId>\n" +
                "\t\t<MarketingCompanyId>AA</MarketingCompanyId>\n" +
                "\t\t<ProductId>2183</ProductId>\n" +
                "\t\t<SequenceNumber>6</SequenceNumber>\n" +
                "\t\t<AvailDisplayLineNumber>1</AvailDisplayLineNumber>\n" +
                "\t\t<ActionRequired>P</ActionRequired>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<FirstDate>290716</FirstDate>\n" +
                "\t\t<OriginLocId>DCA</OriginLocId>\n" +
                "\t\t<DestLocId>CLT</DestLocId>\n" +
                "\t\t<MarketingCompanyId>AA</MarketingCompanyId>\n" +
                "\t\t<ProductId>1720</ProductId>\n" +
                "\t\t<SequenceNumber>6</SequenceNumber>\n" +
                "\t\t<AvailDisplayLineNumber>2</AvailDisplayLineNumber>\n" +
                "\t\t<ActionRequired>P</ActionRequired>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<FirstDate>290716</FirstDate>\n" +
                "\t\t<OriginLocId>JFK</OriginLocId>\n" +
                "\t\t<DestLocId>RDU</DestLocId>\n" +
                "\t\t<MarketingCompanyId>AA</MarketingCompanyId>\n" +
                "\t\t<ProductId>4374</ProductId>\n" +
                "\t\t<SequenceNumber>10</SequenceNumber>\n" +
                "\t\t<AvailDisplayLineNumber>1</AvailDisplayLineNumber>\n" +
                "\t\t<ActionRequired>P</ActionRequired>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<FirstDate>290716</FirstDate>\n" +
                "\t\t<OriginLocId>RDU</OriginLocId>\n" +
                "\t\t<DestLocId>CLT</DestLocId>\n" +
                "\t\t<MarketingCompanyId>AA</MarketingCompanyId>\n" +
                "\t\t<ProductId>5415</ProductId>\n" +
                "\t\t<SequenceNumber>10</SequenceNumber>\n" +
                "\t\t<AvailDisplayLineNumber>2</AvailDisplayLineNumber>\n" +
                "\t\t<ActionRequired>P</ActionRequired>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>UNT</SegmentHDR>\n" +
                "\t\t<NumOfSegsInMsg>11</NumOfSegsInMsg>\n" +
                "\t\t<MsgReferenceNum>1</MsgReferenceNum>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>UNZ</SegmentHDR>\n" +
                "\t\t<InterchangeCtlCnt>1</InterchangeCtlCnt>\n" +
                "\t\t<InterchangeCtlRef>021124</InterchangeCtlRef>\n" +
                "\t</Segment>\n" +
                "</p1:Paoreq>\n";
        System.out.println(convertXmlToEdicatMessage(inputXML));
    }
}

