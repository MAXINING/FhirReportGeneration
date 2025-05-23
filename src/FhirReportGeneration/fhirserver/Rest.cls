Class FhirReportGeneration.fhirserver.Rest Extends %CSP.REST
{

Parameter HandleCorsRequest = "true";

XData UrlMap [ XMLNamespace = "http://www.bjgoodwill.com/urlmap" ]
{
<Routes>
  <Route Url="/getReport" Method="POST" Call="GetReport"/>
</Routes>
}

ClassMethod GetReport() As %Status
{
       Set BS =##class(FhirReportGeneration.fhirserver.BS).%New()
       Set tSC=##class(Ens.Director).CreateBusinessService("FhirReportGeneration.fhirserver.BS",.BS)
       Set request =##class(FhirReportGeneration.fhirserver.ReuqestMsg).%New()
       set request.Name=%request.Get("Name")
       set request.identifier=%request.Get("identifier")
      
       set output =##class(Ens.StringResponse).%New()

       Set tSC1=BS.ProcessInput(request,.output)

       set message =output.StringValue
       Do %response.SetHeader("Content-Type", "application/json;charset=UTF-8")   
       w $ZCVT(message,"O","UTF8")
	Quit $$$OK
}

}
