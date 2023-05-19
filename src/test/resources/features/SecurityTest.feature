@Smoke @Regression
Feature: API Test Security Section

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  Scenario: Create token with valid username and password.
    #prepare request
    And request {"username": "supervisor", "password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 200
    And print response

  Scenario: Validate token with invalid username
    And request {"username": "supervisor2", "password": "tek_supervisor"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  #The second assertion should fail because of defect
  Scenario: Validate token with valid username and invalid password
    And request {"username": "supervisor", "password": "teks_supervisor"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
    And assert response.httpStatus == "BAD_REQUEST"
