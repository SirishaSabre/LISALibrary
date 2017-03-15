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
public class XmlToEdicatConverterSellV3 {

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
                "\t<!--UNB+IATA:1+1P+AA+160720:1100+9F101B'UNH+1+ITAREQ:96:2:IA+9F101B600120192'MSG+:60'ORG+1P:HDQ+05523302:IP9+SFO+1P+T+US:USD+GS'ODI+JFK+LAX'\n" +
                "\t     TVL+200716:1900:200716:2216+JFK+LAX+AA+21:F+++P'RPI+1+NN'ODI'MSG+:F'TVL+190716:1635:200716:0058+LAX+JFK+B6+1124:C'RPI+1+HK'\n" +
                "\t\t TVL+210716:1930:210716:2247+JFK+LAX+B6+1123:I'RPI+1+HK'UNT+13+1'UNZ+1+9F101B'-->\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTAG>UNB</SegmentTAG>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<SyntaxId>IATA</SyntaxId>\n" +
                "\t\t\t<SyntaxVersionNumber>1</SyntaxVersionNumber>\n" +
                "\t\t</Component>\n" +
                "\t\t<SenderId>1P</SenderId>\n" +
                "\t\t<RecipientId>AA</RecipientId>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<msgDate>160720</msgDate>\n" +
                "\t\t\t<msgTime>1100</msgTime>\n" +
                "\t\t</Component>\n" +
                "\t\t<interchangeControlRef>9F101B</interchangeControlRef>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTag>UNH</SegmentTag>\n" +
                "\t\t<MsgType>1</MsgType>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<MsgRef>ITAREQ</MsgRef>\n" +
                "\t\t\t<MsgVer>96</MsgVer>\n" +
                "\t\t\t<MsgRel>2</MsgRel>\n" +
                "\t\t\t<CtlAgy>IA</CtlAgy>\n" +
                "\t\t</Component>\n" +
                "\t\t<interchangeControlRef>9F101B600120192</interchangeControlRef>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTAG>MSG</SegmentTAG>\n" +
                "\t\t<Component>\n" +
                "\t\t<MessageFunction>:60</MessageFunction>\n" +
                "\t\t</Component>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTAG>ORG</SegmentTAG>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<AirlineCompanyId>1P</AirlineCompanyId>\n" +
                "\t\t\t<In-HouseIdCode>HDQ</In-HouseIdCode>\n" +
                "\t\t</Component>\n" +
                "\t\t<Component>\n" +
                "\t\t\t<AgentIataNbr>05523302</AgentIataNbr>\n" +
                "\t\t\t<AgentPCC>IP9</AgentPCC>\n" +
                "\t\t</Component>\n" +
                "\t\t<AgentCityCode>SFO</AgentCityCode>\n" +
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
                "\t\t<DestLocId>LAX</DestLocId>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<Component>\n" +
                "\t\t<DepartureDate>200716</DepartureDate>\n" +
                "\t\t<DepartureTime>1900</DepartureTime>\n" +
                "\t\t<ArrivalDate>200716</ArrivalDate>\n" +
                "\t\t<ArrivalTime>2216</ArrivalTime>\n" +
                "\t\t</Component>\n" +
                "\t\t<DepartureAirport>JFK</DepartureAirport>\n" +
                "\t\t<ArrivalAirport>LAX</ArrivalAirport>\n" +
                "\t\t<Carrier>AA</Carrier>\n" +
                "\t\t<Component>\n" +
                "\t\t<FlightNumber>21</FlightNumber>\n" +
                "\t\t<SolutionNumber>F</SolutionNumber>\n" +
                "\t\t</Component>\n" +
                "\t\t<SegmentNumber></SegmentNumber>\n" +
                "\t\t<SegmentNumber1></SegmentNumber1>\n" +
                "\t\t<ProcessingIndicator>P</ProcessingIndicator>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>RPI</SegmentHDR>\n" +
                "\t\t<Numberofpassengers>1</Numberofpassengers>\n" +
                "\t\t<FlightbookingStatus>NN</FlightbookingStatus>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>ODI</SegmentHDR>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentTAG>MSG</SegmentTAG>\n" +
                "\t\t<Component>\n" +
                "\t\t<MessageFunction>:F</MessageFunction>\n" +
                "\t\t</Component>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<Component>\n" +
                "\t\t<DepartureDate>190716</DepartureDate>\n" +
                "\t\t<DepartureTime>1635</DepartureTime>\n" +
                "\t\t<ArrivalDate>200716</ArrivalDate>\n" +
                "\t\t<ArrivalTime>0058</ArrivalTime>\n" +
                "\t\t</Component>\n" +
                "\t\t<DepartureAirport>LAX</DepartureAirport>\n" +
                "\t\t<ArrivalAirport>JFK</ArrivalAirport>\n" +
                "\t\t<Carrier>B6</Carrier>\n" +
                "\t\t<Component>\n" +
                "\t\t<FlightNumber>1124</FlightNumber>\n" +
                "\t\t<ProcessingIndicator>C</ProcessingIndicator>\n" +
                "\t\t</Component>\n" +
                "\t\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>RPI</SegmentHDR>\n" +
                "\t\t<Numberofpassengers>1</Numberofpassengers>\n" +
                "\t\t<FlightbookingStatus>HK</FlightbookingStatus>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>TVL</SegmentHDR>\n" +
                "\t\t<Component>\n" +
                "\t\t<DepartureDate>210716</DepartureDate>\n" +
                "\t\t<DepartureTime>1930</DepartureTime>\n" +
                "\t\t<ArrivalDate>210716</ArrivalDate>\n" +
                "\t\t<ArrivalTime>2247</ArrivalTime>\n" +
                "\t\t</Component>\n" +
                "\t\t<DepartureAirport>JFK</DepartureAirport>\n" +
                "\t\t<ArrivalAirport>LAX</ArrivalAirport>\n" +
                "\t\t<Carrier>B6</Carrier>\n" +
                "\t\t<Component>\n" +
                "\t\t<FlightNumber>1123</FlightNumber>\n" +
                "\t\t<ProcessingIndicator>I</ProcessingIndicator>\n" +
                "\t\t</Component>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>RPI</SegmentHDR>\n" +
                "\t\t<Numberofpassengers>1</Numberofpassengers>\n" +
                "\t\t<FlightbookingStatus>HK</FlightbookingStatus>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>UNT</SegmentHDR>\n" +
                "\t\t<NumOfSegsInMsg>13</NumOfSegsInMsg>\n" +
                "\t\t<MsgReferenceNum>1</MsgReferenceNum>\n" +
                "\t</Segment>\n" +
                "\t<Segment>\n" +
                "\t\t<SegmentHDR>UNZ</SegmentHDR>\n" +
                "\t\t<InterchangeCtlCnt>1</InterchangeCtlCnt>\n" +
                "\t\t<InterchangeCtlRef>9F101B</InterchangeCtlRef>\n" +
                "\t</Segment>\n" +
                "</p1:Paoreq>\n";
        System.out.println(convertXmlToEdicatMessage(inputXML));
    }
}

