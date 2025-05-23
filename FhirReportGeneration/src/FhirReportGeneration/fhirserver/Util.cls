Class FhirReportGeneration.fhirserver.Util
{

ClassMethod update() As %Status
{
	
	
	 Set appKey = "/csp/healthshare/USER/fhir/r4"

 //Get and modify FHIR server's configuration object
 Set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint("/csp/healthshare/USER/fhir/r4")

 Set configData = strategy.GetServiceConfigData()
 Set configData.DefaultPreferHandling = "strict"
 Set configData.DebugMode = 4
 //stringify configData before updating FHIR Server
 Set jsonConfigData = configData.AsJSONString()
 
 // Define additional settings
 Set enabled = 1
 Set serviceConfigName = "HS.InteropPackage.myBusinessService"
 Set oAuthClient = "OAuthClientName"
 
 // Update FHIR Server
 Do ##class(HS.FHIRServer.Installer).UpdateInstance(appKey, jsonConfigData, enabled, "", "")
 
 do $system.OBJ.ImportDir("/opt/FHIRReportGeneration/src/FhirReportGeneration/",,"cbrpsuy",,1)
 Set tSC = $ClassMethod("EnsPortal.AutoStartProduction","ApplyID","FhirReportGeneration.Production",0)
 Do ##class(FhirReportGeneration.fhirserver.Util).initializationData()
}

ClassMethod SetupServer() As %Status
{
	

	
	
	 set currenns=$namespace
	 
	
	 Set appKey = "/csp/healthshare/"_currenns_"/fhir/r4"
     Set strategyClass = "HS.FHIRServer.Storage.Json.InteractionsStrategy"
     Set metadataPackages = $lb("hl7.fhir.r4.core@4.0.1")
     zn "HSLIB"
     //Install a Foundation namespace and change to it
    
        Do ##class(HS.Util.Installer.Foundation).Install(currenns)
         
    
    
    try {
     zn "%sys" 
     
     Set sc("DispatchClass")="FhirReportGeneration.fhirserver.Rest",sc("AutheEnabled")=64,sc("IsNameSpaceDefault")=0,sc("MatchRoles")=":%All",sc("GroupById")="%ISCMgtPortal",sc("NameSpace")="USER",sc("DeepSeeEnabled")=1
	
	 Set tSC=##Class(Security.Applications).Create("/csp/FhirReportGeneration",.sc)
     
     if (##Class(Security.Applications).%OpenId(appKey)=""){ 
     zn currenns
	    
         Do ##class(HS.FHIRServer.Installer).InstallNamespace()
       
         Do ##class(HS.FHIRServer.Installer).InstallInstance(appKey, strategyClass, metadataPackages)
        
     
     }
    
	zn currenns
	
    }catch e{
	  zn "user"   
	 // w 111
	 }
    Quit $$$OK
}

ClassMethod GetID(QueryParam) As %String
{
	set clientObj=##class(HS.FHIRServer.RestClient.FHIRService).%New()
	Set clientObj = ##class(HS.FHIRServer.RestClient.FHIRService).CreateInstance("/test/fhir/r4")
	
 Do clientObj.SetResponseFormat("JSON")
 set clientResponseObj=##class(HS.FHIRServer.API.Data.RestClient.Response).%New()
 //"subject:Patient.identifier=123-45-6789"
 Set clientResponseObj = clientObj.Search("GET", "Patient", "",,QueryParam)
 SET Jsoh= clientResponseObj.Json
 
  //w Jsoh.entry."0".resource.id
 //w clientResponseObj.XMLExportToString(.a)
 //w a
 Quit Jsoh.entry."0".resource.id
}

ClassMethod initializationData() As %Status
{
   set dir = "/opt/FHIRReportGeneration/resource" 
   set dir = ##class(%File).NormalizeDirectory(dir)
   set file=$ZSEARCH(dir_"*")
	 while file'="" {
		 write !,file
		 
		 set tTempFile=##class(%FileCharacterStream).%New()
          set tTempFile.Filename=file
           set JSON={}.%FromJSON(tTempFile.Read())
           Do ..Bundle2(JSON)
			set file=$ZSEARCH("")
	 }
	  Quit $$$OK
}

ClassMethod Bundle2(JSON) As %Status
{
	
  
      Set HttpRequest=##class(%Net.HttpRequest).%New()
	 set HttpRequest.Server="localhost"
	 set HttpRequest.Port="52773"
	
    
	
	
		set id=""
		//W JSON.%ToJSON(),!
			set newOb=##class(%DynamicArray).%New()
			SET newOb= newOb.%FromJSON(JSON.%ToJSON())
			//w newOb.%ToJSON(),!
			set newOb.entry=[]
			
		//	w "---"_newOb.entry,!
			Do newOb.entry.%Push(JSON.entry."0")
			//W newOb.%ToJSON(),!
			//w 2,!
			sET return= ..SendRequest(newOb.%ToJSON(),HttpRequest)
			//w return
			set id=$p(return.entry."0".response.location,"/",*)
			//w "id"_id,!
		   //set id=33
			set newOb=##class(%DynamicArray).%New()
			SET newOb= newOb.%FromJSON(JSON.%ToJSON())
			set newOb=JSON
			//w newOb.%ToJSON(),!
			Do newOb.entry.%Remove(0)
			
			w newOb.entry.%Size()-1,!
		    for i=0:1:(newOb.entry.%Size()-1)
		    {
			   // w newOb.entry.%Get(i),!
			    set newOb.entry.%Get(i).resource.subject.reference="Patient/"_id
			    
			    
			}
			w newOb.%ToJSON(),!
			w ..SendRequest(newOb.%ToJSON(),HttpRequest).%ToJSON(),!
			
			   // w newOb.%ToJSON(),!
			   Quit $$$OK
}

ClassMethod SendRequest(JSON, HttpRequest) As %DynamicObject
{
	

	 
	Do HttpRequest.EntityBody.Clear()
	Do HttpRequest.SetHeader("Content-Type","application/fhir+json")
	Do HttpRequest.SetHeader("Accept","*/*")
	
	
	Do HttpRequest.EntityBody.Write($zcvt(JSON,"O","UTF8"))
	SET STATUS= HttpRequest.Post("/csp/healthshare/USER/fhir/r4")
	
	Set response=HttpRequest.HttpResponse.Data.Read()
   
   	set Result={}.%FromJSON(response)
	Quit Result
}

}
