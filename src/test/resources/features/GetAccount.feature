Feature: Get Account


Background: Setup Test Generate Token

* def tokenFeature = callonce read('GenerateToken.feature')
* def token = tokenFeature.response.token
Given url "https://tek-insurance-api.azurewebsites.net"


Scenario: Get Account info
When path "/api/accounts/get-all-accounts"
And header Authorization = "Bearer " + token
When method get
Then status 200