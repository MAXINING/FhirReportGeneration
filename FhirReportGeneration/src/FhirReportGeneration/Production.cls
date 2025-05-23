Class FhirReportGeneration.Production Extends Ens.Production [ Not ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="FhirReportGeneration.Production" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="FhirReportGeneration.fhirserver.BS" Category="" ClassName="FhirReportGeneration.fhirserver.BS" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="FhirReportGeneration.fhirserver.BO" Category="" ClassName="FhirReportGeneration.fhirserver.BO" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="APIKEY"></Setting>
    <Setting Target="Host" Name="MODELNAME"></Setting>
    <Setting Target="Host" Name="URL"></Setting>
  </Item>
  <Item Name="FhirReportGeneration.fhirserver.BP" Category="" ClassName="FhirReportGeneration.fhirserver.BP" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
