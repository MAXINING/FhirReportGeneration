Class FhirReportGeneration.fhirserver.BO Extends Ens.BusinessOperation
{

Property APIKEY As %String(MAXLEN = "");

Property MODELNAME As %String;

Property URL As %String;

Parameter SETTINGS = "APIKEY:Basic,URL:Basic,MODELNAME:Basic";

Method GetResource(input As FhirReportGeneration.fhirserver.ReuqestMsg, Output pResponse As Ens.StringResponse) As %Status
{
 set QueryParam="identifier="_input.identifier_"&name="_input.Name_"&_include=Patient:general-practitioner&_revinclude=Observation:subject&_revinclude=MedicationRequest:subject"
 Set clientObj=##class(HS.FHIRServer.RestClient.FHIRService).%New()
 Set clientObj = ##class(HS.FHIRServer.RestClient.FHIRService).CreateInstance("/csp/healthshare/USER/fhir/r4")	
 Do clientObj.SetResponseFormat("JSON")
 set clientResponseObj=##class(HS.FHIRServer.API.Data.RestClient.Response).%New()
 Set clientResponseObj = clientObj.Search("GET", "Patient", "",,QueryParam)
 SET Jsoh= clientResponseObj.Json
 SET pResponse=##class(Ens.StringResponse).%New()
 SET pResponse.StringValue=Jsoh.%ToJSON()
 Quit $$$OK
}

Method GetReport(input As Ens.StringRequest, Output pResponse As Ens.StringResponse) As %Status
{
	
	set Question="Please generate a patient report based on the following fhir information and provide prompts to the patient:"_input.StringValue
	set Answer=##class(FhirReportGeneration.Python.Util).GetAnswer(Question,..APIKEY,..URL,..MODELNAME)
	set pResponse=##class(Ens.StringResponse).%New()
	set pResponse.StringValue=Answer
	Quit $$$OK
}

XData MessageMap
{
<MapItems>
	
	<MapItem MessageType="FhirReportGeneration.fhirserver.ReuqestMsg"> 
		<Method>GetResource</Method>
	</MapItem>
		<MapItem MessageType="Ens.StringRequest"> 
		<Method>GetReport</Method>
	</MapItem>
	
</MapItems>
}

}
