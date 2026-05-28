# 1. Ton Token (Token Hash)
$token = "eyJvcmciOiI2NDA2NTFhNTIyZmEwNTAwMDEyOWJiZTEiLCJpZCI6ImI3Y2I3ZjYyZjZjODRjZDg4MmY5MmVkZTI1ODMyMzA5IiwiaCI6Im11cm11cjEyOCJ9"

# 2. Définition des en-têtes (Headers)
$headers = @{
    "Authorization"     = "Bearer $token"
    "SOAPAction"        = "http://opentransportdata.swiss/TDP/Soap_Datex2/Pull/v1/pullTrafficMessages"
    "If-Modified-Since" = "2025-01-01T00:00:00"
}

# 3. Définition du corps de la requête (Body XML)
$xmlBody = @"
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <d2LogicalModel xmlns="http://datex2.eu/schema/2/2_0">
      <exchange>
        <supplierIdentification>
          <country>ch</country>
          <nationalIdentifier>FEDRO</nationalIdentifier>
        </supplierIdentification>
        <subscription>
          <operatingMode>operatingMode1</operatingMode>
          <subscriptionStartTime>2025-05-01T08:00:00.00+01:00</subscriptionStartTime>
          <subscriptionState>active</subscriptionState>
          <updateMethod>singleElementUpdate</updateMethod>
          <target>
            <address></address>
            <protocol>http</protocol>
          </target>
        </subscription>
      </exchange>
    </d2LogicalModel>
  </soap:Body>
</soap:Envelope>
"@

# 4. Exécution de la requête et sauvegarde dans un fichier
Invoke-WebRequest -Uri "https://api.opentransportdata.swiss/TDP/Soap_Datex2/TrafficSituations/Pull" `
                  -Method Post `
                  -Headers $headers `
                  -ContentType "text/xml" `
                  -Body $xmlBody `
                  -OutFile "traffic_situations.xml"

Write-Host "Requête terminée ! Le fichier traffic_situations.xml a été généré dans le dossier courant." -ForegroundColor Green