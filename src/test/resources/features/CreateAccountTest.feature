Feature: Create Account Test

  #Scenario 10
  Background: API Test Setup
  # callonce read is karate step to execute and read another feature file
  #the result of callonce can store into new variable using def step 
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"
    
    Scenario: Create Account
    Given path "/api/accounts/add-primary-account"
    And request {"email": "tayy3289@gmail.com","firstName": "Tayyaba","lastName": "Ali","title": "Miss.","gender": "FEMALE","maritalStatus": "SINGLE","employmentStatus": "student","dateOfBirth": "1996-09-23"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
    And assert response.email == "tayy3289@gmail.com"
     #Delete the created account
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = response.id
    And header Authorization = "Bearer " + generatedToken
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
