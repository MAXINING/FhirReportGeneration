Class FhirReportGeneration.fhirserver.ReuqestMsg Extends Ens.Request
{

Property Name As %String;

Property identifier As %String;

Storage Default
{
<Data name="ReuqestMsgDefaultData">
<Subscript>"ReuqestMsg"</Subscript>
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>identifier</Value>
</Value>
</Data>
<DefaultData>ReuqestMsgDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
