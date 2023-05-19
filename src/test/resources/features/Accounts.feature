Feature: Get Account API
@Regression
  #Scenario 9
  Scenario: Get API account
    Given url "https://tek-insurance-api.azurewebsites.net"
    When path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    #def step is to define new variable in karate framework
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And param primaryPersonId = 6815
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.email == "tayyabarasouly@gmail.com"
