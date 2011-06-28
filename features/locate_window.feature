Feature: locate window
  As a tester 
  I want to be able to locate windows on the screen
  In order to retrieve information from or interact with it

  Scenario: locate visible window
    Given the default text editor is not running
    When I run the default text editor
    Then I should see a window containing "Untitled" on the title

