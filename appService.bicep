param location string // The location where the resources will be deployed
param appServiceAppName string // The name of the App Service application

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'toy-product-launch-plan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
  // This code declares that an output for this module, which will be named appServiceAppHostName, will be of type string. The output will take its value from the defaultHostName property of the App Service app.
