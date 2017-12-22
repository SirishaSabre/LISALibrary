<?xml version="1.0" ?>

<TestCase name="EYUL_1Seg_VA_UB" version="5">

<meta>
   <create version="9.1.0" buildNumber="9.1.0.399" author="admin" date="06/26/2016" host="banvi08mac844" />
   <lastEdited version="10.1.0" buildNumber="10.1.0.283" author="admin" date="12/22/2017" host="LTXWD-SSDSV-01" />
</meta>

<id>3EDE653BE60011E7AFE89E3620524153</id>
<Documentation>Put documentation of the Test Case here.</Documentation>
<IsInProject>true</IsInProject>
<sig>ZWQ9NSZ0Y3Y9NSZsaXNhdj0xMC4xLjAgKDEwLjEuMC4yODMpJm5vZGVzPTc4MzIxMjk2Ng==</sig>
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
          uid="3EDE8C4CE60011E7AFE89E3620524153" 
          think="0H" 
          useFilters="true" 
          quiet="true" 
          next="Sell Create HTH Header" > 

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


    <Node name="Sell Create HTH Header" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="3EDE8C4DE60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Parse Sell EDIFACT Payload" > 


      <!-- Filters -->
      <Filter type="com.itko.lisa.test.FilterSaveResponse">
        <valueToFilterKey>lisa.Sell Create HTH Header.rsp</valueToFilterKey>
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


    <Node name="Parse Sell EDIFACT Payload" log=""
          type="com.itko.lisa.utils.ParseTextContentNode" 
          version="1" 
          uid="3EDE8C4EE60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="true" 
          next="EDIFACT Message Creator" > 

<text>VU5CK0lBVEI6MSsxQVBQQytFWTFFVCt7e2N1cnJlbnRkYXRlLnl5TU1kZEhIbW19fSsxJw0KVU5IKzErSVRBUkVROjk2OjI6SUErMDAwMVA4MUI3MEMxJw0KTVNHKzE6NjAnDQpPUkcrMUE6TVVDKzU5MjAxMDk2OkxPU044MjIwMytMT1MrK1QrTkc6TkdOOkVOK0E0NTg5SkFTVSswNDI2MTE3OCsxQScNCk9ESStDREcrQVVIJw0KVFZMKzI1MDQxODoxMDQwOjI1MDQxODoxOTMwK0NERytBVUgrVUwrMjM2MjpZKysrUCdSUEkrMStOTicNClBESSsrWToxJw0KU0RUKzAnDQpVTlQrOSsxJw0KVU5aKzErMSc=</text>
<propKey>prop_edifact_payload</propKey>
    </Node>


    <Node name="EDIFACT Message Creator" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="3EDE8C4FE60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Sell MQ-Subscribe" > 

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


    <Node name="Sell MQ-Subscribe" log=""
          type="com.itko.lisa.esb.ibm.IBMMQStep" 
          version="1" 
          uid="3EDE8C50E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Sell Delay 30Sec" > 

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
<lisa.prefill.jndiServerPWD_enc>la2c2a9a7fed0d5b856c6232b8cb83978f9d5bc379f24722afc53898da8f47d5d</lisa.prefill.jndiServerPWD_enc>
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
<sonicBrokerPwd_enc>lb37bd3cfcdf41dfba5970de6082b331501d471d5196f003e5b85c43b02cab8c0</sonicBrokerPwd_enc>
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


    <Node name="Sell Delay 30Sec" log=""
          type="com.itko.lisa.test.UserScriptNode" 
          version="1" 
          uid="3EDE8C51E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Sell MQ-Publish" > 


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


    <Node name="Sell MQ-Publish" log=""
          type="com.itko.lisa.esb.ibm.IBMMQStep" 
          version="1" 
          uid="3EDE8C52E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Sell Listen on async_queue_resp" > 

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
<lisa.prefill.jndiServerPWD_enc>l96a9f7fe457a0ae8bad794e1a63e582de819eb0bb50c056c6b3375a8fee3d686</lisa.prefill.jndiServerPWD_enc>
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
<sonicBrokerPwd_enc>l9ded037ddedadc3cbe6b008540b2edbd0252be8b0c00e5773d1d675cd02f2369</sonicBrokerPwd_enc>
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


    <Node name="Sell Listen on async_queue_resp" log=""
          type="com.itko.lisa.jms.AsyncConsumerNode" 
          version="1" 
          uid="3EDE8C53E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Sell Log Request and Respoonse" > 


      <!-- Filters -->
      <Filter type="com.itko.lisa.test.FilterSavePropToFile">
        <valueToFilterKey>lisa.Sell Listen on async_queue_resp.rsp</valueToFilterKey>
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


    <Node name="Sell Log Request and Respoonse" log=""
          type="com.itko.lisa.test.UserScriptNode" 
          version="1" 
          uid="3EDE8C54E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="ET Create HTH Header" > 


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
<script>String requestHeader = testExec.getStateObject(&quot;prop_hth_header&quot;);&#13;&#10;String requestPayload = testExec.getStateObject(&quot;prop_edifact_payload&quot;);&#13;&#10;String response = testExec.getStateObject(&quot;lisa.Sell Listen on async_queue_resp.rsp&quot;);&#13;&#10;response = response.replace((char) 0x1D, &apos;+&apos;);&#13;&#10;response = response.replace((char) 0x1F, &apos;:&apos;);&#13;&#10;response = response.replace((char) 0x1C, &apos;\&apos;&apos;);&#13;&#10;response = response.replaceAll(&quot;UNH&quot;, &quot;\nUNH&quot;);&#13;&#10;response = response.replaceAll(&quot;TVL&quot;, &quot;\nTVL&quot;);&#13;&#10;response = response.replaceAll(&quot;RPI&quot;, &quot;\nRPI&quot;);&#13;&#10;response = response.replaceAll(&quot;IFT&quot;, &quot;\nIFT&quot;);&#13;&#10;response = response.replaceAll(&quot;UNT&quot;, &quot;\nUNT&quot;);&#13;&#10;response = response.replaceAll(&quot;UNZ&quot;, &quot;\nUNZ&quot;);&#13;&#10;response = response.replaceAll(&quot;ODI&quot;, &quot;\nODI&quot;);&#13;&#10;&#13;&#10;StringTokenizer tokens = new StringTokenizer(response, &quot;\n&quot;);&#13;&#10;if (tokens.hasMoreTokens()) {&#13;&#10;    String token = tokens.nextToken();&#13;&#10;    System.out.println(&quot;token :: &quot; + token);&#13;&#10;    String referenceNumber = org.apache.commons.lang.StringUtils.substringAfterLast(token, &quot;+&quot;);&#13;&#10;    referenceNumber = referenceNumber.replace(&quot;&apos;&quot;, &quot;&quot;);&#13;&#10;    System.out.println(&quot;ReferenceNumber :: &quot; + referenceNumber);&#13;&#10;    testExec.setStateObject(&quot;ReferenceNumber&quot;, referenceNumber);&#13;&#10;}&#13;&#10;&#13;&#10;String randomString = org.apache.commons.lang.RandomStringUtils.randomAlphanumeric(6);&#13;&#10;randomString = org.apache.commons.lang.StringUtils.upperCase(randomString);&#13;&#10;testExec.setStateObject(&quot;PNR&quot;, randomString);&#13;&#10;&#13;&#10;String firstName = org.apache.commons.lang.RandomStringUtils.randomAlphabetic(6);&#13;&#10;firstName = &quot;FM&quot;+org.apache.commons.lang.StringUtils.upperCase(firstName);&#13;&#10;testExec.setStateObject(&quot;FirstName&quot;, firstName);&#13;&#10;&#13;&#10;String lastName = org.apache.commons.lang.RandomStringUtils.randomAlphabetic(6);&#13;&#10;lastName = &quot;LM&quot;+org.apache.commons.lang.StringUtils.upperCase(lastName);&#13;&#10;testExec.setStateObject(&quot;LastName&quot;, lastName);&#13;&#10;&#13;&#10;return &quot;REQUEST WITH HEADER :: \n&quot; + requestHeader + requestPayload + &quot;\n\n&quot; + &quot;RESPONSE WITH HEADER :: \n&quot; + response&#13;&#10;+ &quot;\n&quot; + &quot;Reference Number :: &quot; + testExec.getStateObject(&quot;ReferenceNumber&quot;);</script>
    </Node>


    <Node name="ET Create HTH Header" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="D3EAAEA5E6AE11E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="Parse ET EDIFACT Payload" > 


      <!-- Filters -->
      <Filter type="com.itko.lisa.test.FilterSaveResponse">
        <valueToFilterKey>lisa.ET Create HTH Header.rsp</valueToFilterKey>
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


    <Node name="Parse ET EDIFACT Payload" log=""
          type="com.itko.lisa.utils.ParseTextContentNode" 
          version="1" 
          uid="547E9635E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="true" 
          next="ET EDIFACT Message Creator" > 

<text>VU5CK0lBVEI6MSsxQVBQQytFWTFFVCt7e2N1cnJlbnRkYXRlLnl5TU1kZEhIbW19fSsxJw0KVU5IKzErSFdQUkVROjkzOjI6SUEre3tSZWZlcmVuY2VOdW1iZXJ9fScNCk1TRysxOjU2Jw0KT1JHKzFBOk1VQysxNDMzOTk0MjpERUxJMjI4Qk0rREVMKytUK0lOOklOUjpFTitXUy9TVScNClJDSSsxQTp7e1BOUn19Jw0KTFRTKw0KQk9NUk1FWQ0KLk1VQ1JNMUEgMDYyMjA4NDMNCk1VQzFBIHt7UE5SfX0vREVMSTIyOEJNLzE0MzM5OTQvREVMLzFBL1QvSU4vL1NVDQoxe3tGaXJzdE5hbWV9fS97e0xhc3ROYW1lfX0gTVINClVMMjM2MlkyNUFQUiBDREdBVUggREsxLzEwNDAgMTkzMA0KT1NJIFlZIENUQ1QgREVMIDE4MDAxMTg3NDcgMTgwMDEwMjg3NDcgTUFLRU1ZVFJJUC5DT00NCjsnDQpVTlQrNisxJw0KVU5aKzErMSc=</text>
<propKey>prop_edifact_payload</propKey>
    </Node>


    <Node name="ET EDIFACT Message Creator" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="59E9002AE60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="ET MQ-Subscribe" > 

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


    <Node name="ET MQ-Subscribe" log=""
          type="com.itko.lisa.esb.ibm.IBMMQStep" 
          version="1" 
          uid="5EBE2EF7E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="ET Delay 30Sec" > 

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
<lisa.prefill.jndiServerPWD_enc>lfa7dc4fee0ca58cbb70e486cb2acc8fe956148266e3a88bd12a701cdba4edf73</lisa.prefill.jndiServerPWD_enc>
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
<sonicBrokerPwd_enc>la010b70cc929498c8b0072ebce42771c56d81627a89cb9dc59f129efbbf07ed0</sonicBrokerPwd_enc>
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


    <Node name="ET Delay 30Sec" log=""
          type="com.itko.lisa.test.UserScriptNode" 
          version="1" 
          uid="6364FAC2E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="ET MQ-Publish" > 


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


    <Node name="ET MQ-Publish" log=""
          type="com.itko.lisa.esb.ibm.IBMMQStep" 
          version="1" 
          uid="682BF8C7E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="ET Listen on async_queue_resp" > 

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
<lisa.prefill.jndiServerPWD_enc>l5c1cfdedda645bc3135236b0ca76e57cb5eb25ea6767113ccdaf8ae6f6dd7825</lisa.prefill.jndiServerPWD_enc>
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
<sonicBrokerPwd_enc>l40f6c127ab4337ab09488be11c38fc8c63cfb5a80804dee091c09c52fc3310a9</sonicBrokerPwd_enc>
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


    <Node name="ET Listen on async_queue_resp" log=""
          type="com.itko.lisa.jms.AsyncConsumerNode" 
          version="1" 
          uid="6D50F547E60011E7AFE89E3620524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="ET Log Request and Respoonse" > 


      <!-- Filters -->
      <Filter type="com.itko.lisa.test.FilterSavePropToFile">
        <valueToFilterKey>lisa.ET Listen on async_queue_resp.rsp</valueToFilterKey>
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


    <Node name="ET Log Request and Respoonse" log=""
          type="com.itko.lisa.test.UserScriptNode" 
          version="1" 
          uid="E294604AE60111E7AFE89E3620524153" 
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
<script>String requestHeader = testExec.getStateObject(&quot;prop_hth_header&quot;);&#13;&#10;String requestPayload = testExec.getStateObject(&quot;prop_edifact_payload&quot;);&#13;&#10;String response = testExec.getStateObject(&quot;lisa.ET Listen on async_queue_resp.rsp&quot;);&#13;&#10;response = response.replace((char) 0x1D, &apos;+&apos;);&#13;&#10;response = response.replace((char) 0x1F, &apos;:&apos;);&#13;&#10;response = response.replace((char) 0x1C, &apos;\&apos;&apos;);&#13;&#10;response = response.replaceAll(&quot;UNH&quot;, &quot;\nUNH&quot;);&#13;&#10;response = response.replaceAll(&quot;TVL&quot;, &quot;\nTVL&quot;);&#13;&#10;response = response.replaceAll(&quot;RPI&quot;, &quot;\nRPI&quot;);&#13;&#10;response = response.replaceAll(&quot;IFT&quot;, &quot;\nIFT&quot;);&#13;&#10;response = response.replaceAll(&quot;UNT&quot;, &quot;\nUNT&quot;);&#13;&#10;response = response.replaceAll(&quot;UNZ&quot;, &quot;\nUNZ&quot;);&#13;&#10;response = response.replaceAll(&quot;ODI&quot;, &quot;\nODI&quot;);&#13;&#10;&#13;&#10;return &quot;REQUEST WITH HEADER :: \n&quot; + requestHeader + requestPayload + &quot;\n\n&quot; + &quot;RESPONSE WITH HEADER :: \n&quot; + response;&#13;&#10;&#13;&#10;</script>
    </Node>


    <Node name="abort" log=""
          type="com.itko.lisa.test.AbortStep" 
          version="1" 
          uid="3EDE8C55E60011E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="" > 

    </Node>


    <Node name="fail" log=""
          type="com.itko.lisa.test.Abend" 
          version="1" 
          uid="3EDE8C56E60011E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="abort" > 

    </Node>


    <Node name="end" log=""
          type="com.itko.lisa.test.NormalEnd" 
          version="1" 
          uid="3EDE8C57E60011E7AFE89E3620524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="fail" > 

    </Node>


</TestCase>
