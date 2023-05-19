#End 2 End Account Testing
#Create Account
#Add Address
#Add phone
#Add Car
#Get account

Feature: Create entire user profile

Background:


* def result = callonce read('Generatetoken.feature')
And print result
* def generatedToken = result.response.token
Given url "https://tek-insurance-api.azurewebsites.net"

Scenario: Create an entire profile
* def dataGenerator = Java.type('api.data.GenerateData')
* def autoEmail = dataGenerator.getEmail()
#Add account
Given path "/api/accounts/add-primary-account"
And header Authorization = "Bearer " + generatedToken
And request 
"""
{
  "id": 0,
  "email": "#(autoEmail)",
  "firstName": "Tayyaba",
  "lastName": "Ali",
  "title": "Miss.",
  "gender": "FEMALE",
  "maritalStatus": "SINGLE",
  "employmentStatus": "student",
  "dateOfBirth": "1996-09-23"
}
"""

When method post
Then status 201
And print response
And assert response.email == autoEmail


# Add address
Given path "/api/accounts/add-account-address"
And header Authorization = "Bearer " + generatedToken
And param primaryPersonId = response.id

And request 
"""
{
  
  "id": 0,
  "addressType": "House",
  "addressLine1": "856 mccauig avenue",
  "city": "milton",
  "state": "ontario",
  "postalCode": "l9t6s7",
  "countryCode": "001",
  "current": true

  
}

"""
When method post
Then status 201
And print response
And assert response.addressType == "House"

#Add phone
Given path "/api/accounts/add-account-phone"
And header Authorization = "Bearer " + generatedToken
And param primaryPersonId = response.id
And request 
"""
{
  
  "phoneNumber": "1234564125",
  "phoneExtension": "004",
  "phoneTime": "Morning",
  "phoneType": "Work"
}

"""
When method post
Then status 201
And print response
And assert response.phoneNumber == "1234564125"

#Add car
Given path "/api/accounts/add-account-car"
And header Authorization = "Bearer " + generatedToken
And param primaryPersonId = response.id
And request 
"""
{
  "id": 0,
  "make": "toyota",
  "model": "x7",
  "year": "2019",
  "licensePlate": "ckch667"
}
"""
When method post
Then status 201
And print response
And assert response.model == "x7"
#get account
Given path "/api/accounts/get-primary-account"
And header Authorization = "Bearer " + generatedToken
And param primaryPersonId = response.id
When method get
Then status 200
And print response




