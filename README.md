# FhirReportGeneration
Combining FHIR medical information to obtain AI medical reports
Retrieve the corresponding patient's past medical records from the fhir resource using their name and SSN, and combine the case information with AI to generate a report to remind the patient.

## How to install
 Docker Store the code in/opt/FhirReportGeneration Execute docker compose up - d
 
## Setting

Set the address, model, and key of the large oracle model that needs to be called for BO

![image](https://github.com/user-attachments/assets/ff83c81a-1089-4ed7-b7d3-26d498a37a60)

## How to use

Visit as shown in the picture http://ip:52773/csp/FhirReportGeneration/getReport?Name=Bob&identifier=456 -78-9012 (name and identifier can be replaced with other data)

![image](https://github.com/user-attachments/assets/25f02141-faf8-4ebf-8ae1-c9025a1908b2)



