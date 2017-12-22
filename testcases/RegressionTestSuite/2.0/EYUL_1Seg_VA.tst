<?xml version="1.0" ?>

<TestCase name="EYUL_1Seg_VA" version="5">

<meta>
   <create version="9.1.0" buildNumber="9.1.0.399" author="admin" date="06/26/2016" host="banvi08mac844" />
   <lastEdited version="10.1.0" buildNumber="10.1.0.283" author="admin" date="12/22/2017" host="LTXWD-SSDSV-01" />
</meta>

<id>B221AB1BE5BD11E7AFE89E3620524153</id>
<Documentation>Put documentation of the Test Case here.</Documentation>
<IsInProject>true</IsInProject>
<sig>ZWQ9NSZ0Y3Y9NSZsaXNhdj0xMC4xLjAgKDEwLjEuMC4yODMpJm5vZGVzPS0yMzAwNzE5MTc=</sig>
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
          uid="B221AB1CE5BD11E7AFE89E3620524153" 
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
<save>currentdate.MMddyyHH</save>
<save>currentdate.yyMMddHHmm</save>
</SaveProps>
    </Node>


    <Node name="Custom Step - Create HTH Header" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="B221AB1DE5BD11E7AFE89E3620524153" 
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
  <value>V</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_ORI6</key>
  <value>A</value>
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
          uid="B221AB1EE5BD11E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="true" 
          next="EDIFACT Message Creator" > 

<text>VU5CK0lBVEI6MSsxQVBQQytFWTFFVCt7e2N1cnJlbnRkYXRlLnl5TU1kZEhIbW19fSsxJ1VOSCsxK0lUQVJFUTo5NjoyOklBKzAwMDFQODFCNzBDMSdNU0crMTo2MCdPUkcrMUE6TVVDKzU5MjAxMDk2OkxPU044MjIwMytMT1MrK1QrTkc6TkdOOkVOK0E0NTg5SkFTVSswNDI2MTE3OCsxQSdPREkrQ0RHK0FVSCdUVkwrMjUwNDE4OjEwNDA6MjUwNDE4OjE5MzArQ0RHK0FVSCtVTCsyMzYyOlkrKytQJ1JQSSsxK05OJ1BESSsrWToxJ1NEVCswJ1VOVCs5KzEnVU5aKzErMSc=</text>
<propKey>prop_edifact_payload</propKey>
    </Node>


    <Node name="EDIFACT Message Creator" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="B221AB1FE5BD11E7AFE89E3620524153" 
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
          uid="B221AB20E5BD11E7AFE89E3620524153" 
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
<lisa.prefill.jndiServerPWD_enc>l4c2555eb4cf0d1b1f4eae5ff0258c237ae4a4f6fa968a7dca537df3c0ff344c2</lisa.prefill.jndiServerPWD_enc>
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
<sonicBrokerPwd_enc>l4dc23c5d33617a7f7ed4704b5f3d957459725f2d46f8fb4d8fedc3fdc069c4b9</sonicBrokerPwd_enc>
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
          uid="B221AB21E5BD11E7AFE89E3620524153" 
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
          uid="B221AB22E5BD11E7AFE89E3620524153" 
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
<lisa.prefill.jndiServerPWD_enc>l8b951c53535f98385c8ae24a82d43b13faeb95468a0c466fbdee1a5610e7372b</lisa.prefill.jndiServerPWD_enc>
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
<sonicBrokerPwd_enc>l25389d13260da2f0b8922628c7b604e193f84be4b1b12741d25c9c3c64c26902</sonicBrokerPwd_enc>
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
          uid="B221AB23E5BD11E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="LogTest Request and Respoonse" > 


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


    <Node name="LogTest Request and Respoonse" log=""
          type="com.itko.lisa.test.UserScriptNode" 
          version="1" 
          uid="B221AB24E5BD11E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="end" > 


      <!-- Assertions -->
<CheckResult assertTrue="true" name="Any Exception Then Fail" type="com.itko.lisa.dynexec.CheckInvocationEx">
<log>Assertion name: Any Exception Then Fail checks for: true is of type: Assert on Invocation Exception.</log>
<then>fail</then>
<valueToAssertKey></valueToAssertKey>
        <param>.*</param>
</CheckResult>

<onerror>abort</onerror>
<language>BeanShell</language>
<copyProps>TestExecProps</copyProps>
<script>String request = testExec.getStateObject(&quot;prop_edifact_payload&quot;);&#13;&#10;String response = testExec.getStateObject(&quot;lisa.Listen on async_queue_resp.rsp&quot;);&#13;&#10;response = response.replace((char) 0x1D, &apos;+&apos;);&#13;&#10;response = response.replace((char) 0x1F, &apos;:&apos;);&#13;&#10;response = response.replace((char) 0x1C, &apos;\&apos;&apos;);&#13;&#10;response = response.replaceAll(&quot;UNH&quot;, &quot;\nUNH&quot;);&#13;&#10;response = response.replaceAll(&quot;TVL&quot;, &quot;\nTVL&quot;);&#13;&#10;response = response.replaceAll(&quot;RPI&quot;, &quot;\nRPI&quot;);&#13;&#10;response = response.replaceAll(&quot;IFT&quot;, &quot;\nIFT&quot;);&#13;&#10;response = response.replaceAll(&quot;UNT&quot;, &quot;\nUNT&quot;);&#13;&#10;response = response.replaceAll(&quot;UNZ&quot;, &quot;\nUNZ&quot;);&#13;&#10;response = response.replaceAll(&quot;ODI&quot;, &quot;\nODI&quot;);&#13;&#10;&#13;&#10;StringTokenizer tokens = new StringTokenizer(response, &quot;\n&quot;);&#13;&#10;if (tokens.hasMoreTokens()) {&#13;&#10;    String token = tokens.nextToken();&#13;&#10;    System.out.println(&quot;token :: &quot; + token);&#13;&#10;    String referenceNumber = org.apache.commons.lang.StringUtils.substringAfterLast(token, &quot;+&quot;);&#13;&#10;    referenceNumber = referenceNumber.replace(&quot;&apos;&quot;, &quot;&quot;);&#13;&#10;    System.out.println(&quot;ReferenceNumber :: &quot; + referenceNumber);&#13;&#10;    testExec.setStateObject(&quot;ReferenceNumber&quot;, referenceNumber);&#13;&#10;}&#13;&#10;&#13;&#10;String randomString = org.apache.commons.lang.RandomStringUtils.randomAlphanumeric(6);&#13;&#10;System.out.println(org.apache.commons.lang.StringUtils.upperCase(randomString));&#13;&#10;&#13;&#10;String firstName = org.apache.commons.lang.RandomStringUtils.randomAlphabetic(6);&#13;&#10;System.out.println(&quot;FM&quot;+org.apache.commons.lang.StringUtils.upperCase(firstName));&#13;&#10;&#13;&#10;String lastName = org.apache.commons.lang.RandomStringUtils.randomAlphabetic(6);&#13;&#10;System.out.println(&quot;LM&quot;+org.apache.commons.lang.StringUtils.upperCase(lastName));&#13;&#10;&#13;&#10;return &quot;REQUEST :: \n&quot; + request.replace(&quot;&apos;&quot;, &quot;&apos;\n&quot;) + &quot;\n&quot; + &quot;RESPONSE :: \n&quot; + response&#13;&#10;+ &quot;\n&quot; + &quot;Reference Number :: &quot; + testExec.getStateObject(&quot;ReferenceNumber&quot;);&#13;&#10;&#13;&#10;</script>
    </Node>


    <Node name="abort" log=""
          type="com.itko.lisa.test.AbortStep" 
          version="1" 
          uid="B221AB25E5BD11E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="" > 

    </Node>


    <Node name="fail" log=""
          type="com.itko.lisa.test.Abend" 
          version="1" 
          uid="B221AB26E5BD11E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="abort" > 

    </Node>


    <Node name="end" log=""
          type="com.itko.lisa.test.NormalEnd" 
          version="1" 
          uid="B221AB27E5BD11E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="fail" > 

    </Node>


</TestCase>
