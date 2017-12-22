<?xml version="1.0" ?>

<TestCase name="1E_9W_2ODI_6TVL_VA" version="5">

<meta>
   <create version="9.1.0" buildNumber="9.1.0.399" author="admin" date="06/26/2016" host="banvi08mac844" />
   <lastEdited version="10.1.0" buildNumber="10.1.0.283" author="admin" date="12/22/2017" host="LTXWD-SSDSV-01" />
</meta>

<id>E53B333FA8AD11E78CFDE4F220524153</id>
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
          uid="B8E6E104BC5511E7B3906C5320524153" 
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
          uid="E53B3340A8AD11E78CFDE4F220524153" 
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
  <value>E11E9WDS</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_Source_Address</key>
  <value>I19W1EDS</value>
  </Parameter>
  <Parameter>
  <key>Layer_5_TPR</key>
  <value>PL_3{{currentdate.MMddyyHHmm}}</value>
  </Parameter>
</parameters>
    </Node>


    <Node name="Parse in EDIFACT Payload" log=""
          type="com.itko.lisa.utils.ParseTextContentNode" 
          version="1" 
          uid="E53B3341A8AD11E78CFDE4F220524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="true" 
          next="EDIFACT Message Creator" > 

<text>VU5CK0lBVEE6MSsxRVJFUys5Vyt7e2N1cnJlbnRkYXRlLnl5TU1kZEhIbW19fSs1MTc5NSdVTkgrMStJVEFSRVE6OTY6MjpJQStQSDUyMEZBQUEnT1JHKzFFOkJKUyswODMwNTM1NjpTWlgyNzgrU1pYKytUK0NOJ09ESStERlcrREVMJ1RWTCsxODA5MTc6MDc1NToxOTA5MTc6MDgxMCtERlcrQVVIKzlXKzY1NDY6WSdSUEkrMStOTidUVkwrMTkwOTE3OjEwMTA6MTkwOTE3OjE1MTUrQVVIK0RFTCs5VyswNTgxOlknUlBJKzErTk4nVFZMKzIwMDkxNzowODI1OjIwMDkxNzoxMzEwK0FVSCtCT00rOVcrMDU4NTpZJ1JQSSsxK05OJ1RWTCsyMDA5MTc6MTYzMDoyMDA5MTc6MTgzNStCT00rREVMKzlXKzAzNTc6WSdSUEkrMStOTidPREkrREVMK0RGVydUVkwrMjUwOTE3OjA0MzU6MjUwOTE3OjA2NTUrREVMK0FVSCs5VyswNTgyOlknUlBJKzErTk4nVFZMKzI1MDkxNzowOTEwOjI1MDkxNzoxNjE1K0FVSCtERlcrOVcrNjU0NTpZJ1JQSSsxK05OJ1VOVCsxNysxJ1VOWisxKzUxNzk1Jw==</text>
<propKey>prop_edifact_payload</propKey>
    </Node>


    <Node name="EDIFACT Message Creator" log=""
          type="com.itko.lisa.test.CustJavaNode" 
          version="1" 
          uid="E53B3342A8AD11E78CFDE4F220524153" 
          think="500-1S" 
          useFilters="true" 
          quiet="false" 
          next="MQ-Subscribe" > 

      <class>com.itko.lisa.ext.sabre.step.edifact.EdifactMessageCreator</class>
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
  <name>Name</name>
  </Parameter>
</parameters>
    </Node>


    <Node name="MQ-Subscribe" log=""
          type="com.itko.lisa.esb.ibm.IBMMQStep" 
          version="1" 
          uid="E53B3343A8AD11E78CFDE4F220524153" 
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
<lisa.prefill.jndiServerPWD_enc>l463311dae1bab3de8a30159bde66226d069b46f406b9539ec29c23a8b464e9c8</lisa.prefill.jndiServerPWD_enc>
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
<sonicBrokerPwd_enc>l82579c2230e61778ea9f9987da10c89afa2ec3c267db486c402d71e4fc8766e7</sonicBrokerPwd_enc>
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
          uid="E53B3344A8AD11E78CFDE4F220524153" 
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
          uid="E53B3345A8AD11E78CFDE4F220524153" 
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
<lisa.prefill.jndiServerPWD_enc>l907b8aa7af72acb94a53ff72d3e476eaeec8b7e225241c4e6bebd0e9f14b81a9</lisa.prefill.jndiServerPWD_enc>
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
<sonicBrokerPwd_enc>l11daa630d30ec012ea5356f98fcaa14d855e3bc977b9bcf84645d01c98a8adbc</sonicBrokerPwd_enc>
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
          uid="E53B3346A8AD11E78CFDE4F220524153" 
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
          uid="BEF68BA4BC5511E7B3906C5320524153" 
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
<script>String request = testExec.getStateObject(&quot;prop_edifact_payload&quot;);&#13;&#10;String response = testExec.getStateObject(&quot;lisa.Listen on async_queue_resp.rsp&quot;);&#13;&#10;&#13;&#10;return &quot;REQUEST::\n&quot; + request.replace(&quot;&apos;&quot;, &quot;&apos;\n&quot;) + &quot;\n&quot; + &quot;RESPONSE::\n&quot; + response.replace(&quot;&apos;&quot;, &quot;&apos;\n&quot;);</script>
    </Node>


    <Node name="abort" log=""
          type="com.itko.lisa.test.AbortStep" 
          version="1" 
          uid="E53B3349A8AD11E78CFDE4F220524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="" > 

    </Node>


    <Node name="fail" log=""
          type="com.itko.lisa.test.Abend" 
          version="1" 
          uid="E53B3348A8AD11E78CFDE4F220524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="abort" > 

    </Node>


    <Node name="end" log=""
          type="com.itko.lisa.test.NormalEnd" 
          version="1" 
          uid="E53B3347A8AD11E78CFDE4F220524153" 
          think="0h" 
          useFilters="true" 
          quiet="true" 
          next="fail" > 

    </Node>


</TestCase>
