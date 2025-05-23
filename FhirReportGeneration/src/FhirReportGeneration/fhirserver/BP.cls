/// 
Class FhirReportGeneration.fhirserver.BP Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='questionRequest' type='Ens.StringRequest' instantiate='0' />
</context>
<sequence xend='200' yend='450' >
<call name='Get FHIR information' target='FhirReportGeneration.fhirserver.BO' async='0' xpos='200' ypos='250' >
<request type='Ens.Request' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Ens.StringResponse' >
<assign property="context.questionRequest.StringValue" value="callresponse.StringValue" action="set" languageOverride="" />
</response>
</call>
<call name='Reporting' target='FhirReportGeneration.fhirserver.BO' async='0' xpos='200' ypos='350' >
<request type='Ens.Request' >
<assign property="callrequest" value="context.questionRequest" action="set" languageOverride="" />
</request>
<response type='Ens.Response' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</sequence>
</process>
}

}
