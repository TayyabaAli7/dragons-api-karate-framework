
@Smoke @Regression
Feature: Token verify Tests

  Background: Setup Test URL
    Given url "https://tek-insurance-api.azurewebsites.net"

  #Scenario 5
  Scenario: Verify Valid Token
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response
    And assert response == "true"

  #Scenario 6
  Scenario: Negative test validate token verify with wrong username
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/token/verify"
    And param token = response.token
    And param username = "NotSupervisor"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  #Scenario 7
  Scenario: Negative test validate token with invalid token and valid username
    And path "/api/token/verify"
    And param token = "wrong_token"
    And param username = "supervisor"
    When method get
    Then status 400
    And print response
    And assert response.httpStatus == "BAD_REQUEST"
    And assert response.errorMessage == "Token Expired or Invalid Token"
