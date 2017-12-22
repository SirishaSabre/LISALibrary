<?xml version="1.0" ?>

<TestCase name="EYUL_1Seg_UB" version="5">

<meta>
   <create version="9.1.0" buildNumber="9.1.0.399" author="admin" date="06/26/2016" host="banvi08mac844" />
   <lastEdited version="10.1.0" buildNumber="10.1.0.283" author="admin" date="12/22/2017" host="LTXWD-SSDSV-01" />
</meta>

<id>DCBF37BCE5E511E7AFE89E3620524153</id>
<Documentation>Put documentation of the Test Case here.</Documentation>
<IsInProject>true</IsInProject>
<sig>ZWQ9NSZ0Y3Y9NSZsaXNhdj0xMC4xLjAgKDEwLjEuMC4yODMpJm5vZGVzPTExNjY2MjE2NzE=</sig>
<subprocess>false</subprocess>

<initState>
</initState>

<resultState>
</resultState>

<deletedProps>
</deletedProps>

    <Node name="Subprocess DateFormatStep" log=""
          type="com.itko.lisa.utils.ExecSubProcessNode" 
          version="1" 
          uid="F911F92FE5E711E7AFE89E3620524153" 
          think="0H" 
          useFilters="true" 
          quiet="true" 
          next="Custom Step - Create HTH Header" > 

<Subprocess>{{LISA_RELATIVE_PROJ_ROOT}}/../Common-utility/Tests/Subprocesses/DateFormatStep.tst</Subprocess>
<fullyParseProps>false</fullyParseProps>
<sendCommonState>false</sendCommonState>
<getCommonState>false</getCommonState>
<onAbort>abort</onAbort>
<Parameters>
</Parameters>
<SaveProps>
<save>currentdate.MMddyyHHmm</save>
<save>currentdate.MMddyyHH</save>
<save>currentdate.yyMMddHHmm</save>
</SaveProps>
    </Node>


    <Node name="Custom Step - Create HTH Header" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="DCBF37BDE5E511E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Parse in EDIFACT Payload" > 


      <!-- Filters -->
      <Filter type="com.itko.lisa.test.FilterSaveResponse">
        <valueToFilterKey>lisa.Custom Step - Create HTH Header.rsp</valueToFilterKey>
      <prop>prop_hth_header</prop>
      </Filter>

      <class>com.itko.lisa.ext.sabre.step.edifact.SabreHTHHeaderStep</class>
      <parameters>  <Parameter>
  <key>Layer_5_ORI1</key>
  <value>H</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_ORI2</key>
  <value>L</value>
  </Parameter>
  <Parameter>
  <key>Layer_5 ORI3</key>
  <value>G</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_ORI5</key>
  <value>U</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_ORI6</key>
  <value>B</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_Destination_Address</key>
  <value>E11AACC2</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_Source_Address</key>
  <value>I1MHHCC2</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_TPR</key>
  <value>PL_3{{currentdate.MMddyyHH}}</value>
  </Parameter>
</parameters>
    </Node>


    <Node name="Parse in EDIFACT Payload" log=""
          type="com.itko.lisa.utils.ParseTextContentNode" 
          version="1" 
          uid="DCBF37BEE5E511E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="true" 
          next="EDIFACT Message Creator" > 

<text>VU5CK0lBVEI6MSsxQVBQQytFWTFFVCt7e2N1cnJlbnRkYXRlLnl5TU1kZEhIbW19fSsxJ1VOSCsxK0hXUFJFUTo5MzoyOklBKzBDNUswMDQxMDcnTVNHKzE6NTYnT1JHKzFBOk1VQysxNDMzOTk0MjpERUxJMjI4Qk0rREVMKytUK0lOOklOUjpFTitXUy9TVSdSQ0krMUE6WDVXOFU0J0xUUysNCkJPTVJNRVkNCi5NVUNSTTFBIDA2MjIwODQzDQpNVUMxQSBYNVc4VTQvREVMSTIyOEJNLzE0MzM5OTQvREVMLzFBL1QvSU4vL1NVDQoxS0lURTEvUkFEWVMxIE1SDQpVTDIzNjJZMjVBUFIgQ0RHQVVIIERLMS8xMDQwIDE5MzANCk9TSSBZWSBDVENUIERFTCAxODAwMTE4NzQ3IDE4MDAxMDI4NzQ3IE1BS0VNWVRSSVAuQ09NDQo7J1VOVCs2KzEnVU5aKzErMSc=</text>
<propKey>prop_edifact_payload</propKey>
    </Node>


    <Node name="EDIFACT Message Creator" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="DCBF37BFE5E511E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="MQ-Subscribe" > 

      <class>com.itko.lisa.ext.sabre.step.edifact.EdifactMessageCreatorCharacterSetB</class>
      <parameters>  <Parameter>
  <key>HTH_Header_Property</key>
  <value>{{prop_hth_header}}</value>
  </Parameter>
  <Parameter>
  <key>EDIFACT_Payload_Property</key>
  <value>{{prop_edifact_payload}}</value>
  </Parameter>
  <Parameter>
  <key>Encoded_Edifact_Binary_Message</key>
  <value>edifact_request-bin</value>
  </Parameter>
</parameters>
    </Node>


    <Node name="MQ-Subscribe" log=""
          type="com.itko.lisa.esb.ibm.IBMMQStep" 
          version="1" 
          uid="DCBF37C0E5E511E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Delay 30Seconds" > 

<msgVersion>2</msgVersion>
<autoExtractPayLoad>false</autoExtractPayLoad>
<pubEnabledType>false</pubEnabledType>
<subEnabledType>true</subEnabledType>
<repEnabledType>false</repEnabledType>
<repTempQ>false</repTempQ>
<pubSessionMode>AUTO</pubSessionMode>
<subSessionMode>AUTO</subSessionMode>
<keepConnection>false</keepConnection>
<sharePublisher>false</sharePublisher>
<connectionType>MQ</connectionType>
<lisa.prefill.jndiServerPWD_enc>l539bca1a2d66c33f92b710d4a1ae09c5ec975ea25c5f413fb6ef0397e87f14c9</lisa.prefill.jndiServerPWD_enc>
<mqHost>lnkibc03.sabre.com</mqHost>
<mqPort>1416</mqPort>
<mqChannel>LISA.SVRCONN</mqChannel>
<mqQManager>LNKCT03</mqQManager>
<mqCCID></mqCCID>
<mqConnMode>Native Client</mqConnMode>
<mqOverrideQMan></mqOverrideQMan>
<mqUseCorrelationIDOnSubscribe>false</mqUseCorrelationIDOnSubscribe>
<mqCreatePublishDestination>false</mqCreatePublishDestination>
<mqCreateSubscribeDestination>false</mqCreateSubscribeDestination>
<mqEnvProperties>
</mqEnvProperties>
<mqExtMsgProperties>
</mqExtMsgProperties>
<mqSubscribeExtMsgProperties>
</mqSubscribeExtMsgProperties>
<tibRvConnMode>Native Client</tibRvConnMode>
<tibRvUseCMsg>false</tibRvUseCMsg>
<tibRvInBoxType>false</tibRvInBoxType>
<tibRvInBoxReplyMode>false</tibRvInBoxReplyMode>
<tibRvCmConfirmAdvisorySubject>_RV.INFO.RVCM.DELIVERY.CONFIRM.&gt;</tibRvCmConfirmAdvisorySubject>
<tibRvCmRequestOld>true</tibRvCmRequestOld>
<tibRvCmLedgerSync>false</tibRvCmLedgerSync>
<secondLevelAuthEnabled>false</secondLevelAuthEnabled>
<wmBrokerDeliverEnabled>false</wmBrokerDeliverEnabled>
<wmBrokerEventConvertRsp>false</wmBrokerEventConvertRsp>
<wmBrokerEventConvertRspXML>false</wmBrokerEventConvertRspXML>
<sonicBrokerPwd_enc>l6c292610927de5e051297b2a07103a0dab4f897c9e1592a378fc56d31cc815ed</sonicBrokerPwd_enc>
<pubDestType>Queue</pubDestType>
<subDestType>Queue - ASYNC</subDestType>
<subDestination>EDS.LNX.LNX.CRT.Q1S_LISA_ALL_R_MQCRQ</subDestination>
<subTimeout>2</subTimeout>
<repDestType>Queue</repDestType>
<sendMsgType>Empty</sendMsgType>
<jmsMessageObject>
</jmsMessageObject>
<onExNode>abort</onExNode>
<customProperties>
</customProperties>
<customConnProperties>
</customConnProperties>
<asyncPropKey>async_queue_resp</asyncPropKey>
    </Node>


    <Node name="Delay 30Seconds" log=""
          type="com.itko.lisa.test.UserScriptNode" 
          version="1" 
          uid="DCBF37C1E5E511E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="MQ-Publish" > 


      <!-- Assertions -->
<CheckResult assertTrue="true" name="Any Exception Then Fail" type="com.itko.lisa.dynexec.CheckInvocationEx">
<log>Assertion name: Any Exception Then Fail checks for: true is of type: Assert on Invocation Exception.</log>
<then>fail</then>
<valueToAssertKey></valueToAssertKey>
        <param>.*</param>
</CheckResult>

<onerror>abort</onerror>
<language>ECMAScript</language>
<copyProps>TestExecProps</copyProps>
<script>java.lang.Thread.sleep(32000);</script>
    </Node>


    <Node name="MQ-Publish" log=""
          type="com.itko.lisa.esb.ibm.IBMMQStep" 
          version="1" 
          uid="DCBF37C2E5E511E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Listen on async_queue_resp" > 

<msgVersion>2</msgVersion>
<autoExtractPayLoad>true</autoExtractPayLoad>
<pubEnabledType>true</pubEnabledType>
<subEnabledType>false</subEnabledType>
<repEnabledType>true</repEnabledType>
<repTempQ>false</repTempQ>
<pubSessionMode>AUTO</pubSessionMode>
<subSessionMode>AUTO</subSessionMode>
<keepConnection>false</keepConnection>
<sharePublisher>false</sharePublisher>
<connectionType>MQ</connectionType>
<lisa.prefill.jndiServerPWD_enc>le503c68d9733139b5ecc4f8b4f62920d27e491f93f9451846722e596d8d88f55</lisa.prefill.jndiServerPWD_enc>
<mqHost>lnkibc03.sabre.com</mqHost>
<mqPort>1416</mqPort>
<mqChannel>LISA.SVRCONN</mqChannel>
<mqQManager>LNKCT03</mqQManager>
<mqCCID></mqCCID>
<mqConnMode>Native Client</mqConnMode>
<mqReplyToQMgrName>LNKCT03</mqReplyToQMgrName>
<mqOverrideQMan></mqOverrideQMan>
<mqUseCorrelationIDOnSubscribe>false</mqUseCorrelationIDOnSubscribe>
<mqCreatePublishDestination>false</mqCreatePublishDestination>
<mqCreateSubscribeDestination>false</mqCreateSubscribeDestination>
<mqEnvProperties>
</mqEnvProperties>
<mqExtMsgProperties>
</mqExtMsgProperties>
<mqSubscribeExtMsgProperties>
</mqSubscribeExtMsgProperties>
<tibRvConnMode>Native Client</tibRvConnMode>
<tibRvUseCMsg>false</tibRvUseCMsg>
<tibRvInBoxType>false</tibRvInBoxType>
<tibRvInBoxReplyMode>false</tibRvInBoxReplyMode>
<tibRvCmConfirmAdvisorySubject>_RV.INFO.RVCM.DELIVERY.CONFIRM.&gt;</tibRvCmConfirmAdvisorySubject>
<tibRvCmRequestOld>true</tibRvCmRequestOld>
<tibRvCmLedgerSync>false</tibRvCmLedgerSync>
<secondLevelAuthEnabled>false</secondLevelAuthEnabled>
<wmBrokerDeliverEnabled>false</wmBrokerDeliverEnabled>
<wmBrokerEventConvertRsp>false</wmBrokerEventConvertRsp>
<wmBrokerEventConvertRspXML>false</wmBrokerEventConvertRspXML>
<sonicBrokerPwd_enc>l45c70c99a18b1c9534235d6196027f0a9ee96dca2c731fabdc8ca827b8d71fc3</sonicBrokerPwd_enc>
<pubDestType>Queue</pubDestType>
<pubDestination>EDS.LNX.LNX.CRT.Q1S_LISA_ALL_R_INB</pubDestination>
<subDestType>Queue</subDestType>
<subTimeout>30</subTimeout>
<repDestination>EDS.LNX.LNX.CRT.Q1S_LISA_ALL_R_MQCRQ</repDestination>
<repDestType>Queue</repDestType>
<sendMsgType>Bytes</sendMsgType>
<sendMessage>edifact_request-bin</sendMessage>
<jmsMessageObject>
</jmsMessageObject>
<onExNode>abort</onExNode>
<customProperties>
</customProperties>
<customConnProperties>
</customConnProperties>
    </Node>


    <Node name="Listen on async_queue_resp" log=""
          type="com.itko.lisa.jms.AsyncConsumerNode" 
          version="1" 
          uid="DCBF37C3E5E511E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="end" > 


      <!-- Filters -->
      <Filter type="com.itko.lisa.test.FilterSavePropToFile">
        <valueToFilterKey>lisa.Listen on async_queue_resp.rsp</valueToFilterKey>
      <file>{{LISA_RELATIVE_PROJ_ROOT}}/Data/Avail_Res/Avail_Res</file>
      <append>false</append>
      </Filter>


      <!-- Assertions -->
<CheckResult assertTrue="true" name="Any Exception Then Fail" type="com.itko.lisa.dynexec.CheckInvocationEx">
<log>Assertion name: Any Exception Then Fail checks for: true is of type: Assert on Invocation Exception.</log>
<then>fail</then>
<valueToAssertKey></valueToAssertKey>
        <param>.*</param>
</CheckResult>

<wrapperKeyName>async_queue_resp</wrapperKeyName>
<waitTimeOut>-1</waitTimeOut>
<messageDynObj>
</messageDynObj>
<onExNode>abort</onExNode>
<autoExtractPayLoad>true</autoExtractPayLoad>
    </Node>


    <Node name="end" log=""
          type="com.itko.lisa.test.NormalEnd" 
          version="1" 
          uid="DCBF37C6E5E511E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="fail" > 

    </Node>


    <Node name="fail" log=""
          type="com.itko.lisa.test.Abend" 
          version="1" 
          uid="DCBF37C5E5E511E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="abort" > 

    </Node>


    <Node name="abort" log=""
          type="com.itko.lisa.test.AbortStep" 
          version="1" 
          uid="DCBF37C4E5E511E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="" > 

    </Node>


</TestCase>
