

Feature: Generating random email id
Background: Setup Test Generate Token

* def tokenFeature = callonce read('GenerateToken.feature')
* def token = tokenFeature.response.token
Given url "https://tek-insurance-api.azurewebsites.net"
@Regression
#Call Java class and method with karate
Scenario: Create Account with random email
* def dataGenerator = Java.type('api.data.GenerateData')
* def autoEmail = dataGenerator.getEmail()
 
    Given path "/api/accounts/add-primary-account"
    And request {"email": "#(autoEmail)","firstName": "Tayyaba","lastName": "Ali","title": "Miss.","gender": "FEMALE","maritalStatus": "SINGLE","employmentStatus": "student","dateOfBirth": "1996-09-23"}
    And header Authorization = "Bearer " + token
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail