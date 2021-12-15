Feature: Self service tool email update
  As a self-service portal user
  I want to have dynamically formatted e-mails
  So that the approval process has more pertinent information

  
  
  @Ready 
  Scenario: Approval e-mail received
    Given a request for @ToolName access is queued:
      | ToolName |
      | PID |
      | Token Cancellation |
      | RAN List |
      | Token Increments |
      | URL Allowlisting |

    Then an e-mail is populated with the generic template that includes the requester's name
    And the e-mail is formatted with @ToolName and its corresponding description from Sharepoint reference instead of the placeholders
    Then the e-mail is dispatched to the self service admin


