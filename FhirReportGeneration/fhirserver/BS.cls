Class FhirReportGeneration.fhirserver.BS Extends Ens.BusinessService
{

Parameter ADAPTER;

Method OnProcessInput(pInput As FhirReportGeneration.fhirserver.ReuqestMsg, Output pOutput As %RegisteredObject) As %Status
{

    

	Set tSC=..SendRequestSync("FhirReportGeneration.fhirserver.BP",pInput,.pOutput)
	Quit $$$OK
}

}
