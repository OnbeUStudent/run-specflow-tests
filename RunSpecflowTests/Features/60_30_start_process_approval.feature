Feature: 60/30 start process approval
  As a 60/30 file service user
  I want created files from earlier steps to be approved and saved to sharepoint
  So that the relevant files can be archived in these places

  
  
  @Ready 
  Scenario: Start approval process
    Given a 60/30 file upload log is queued
    Then upload the text file to @OneDrivePath
    And upload the refund file to @RefundFilePath
    Then create an e-mail with links to each submission component: @Submitter, @TextFileName, @RefundFileName, @RefundFileInfo, @ChannelName
    And dispatch the e-mail to Client Operations
    Then create a Teams card with the information: @TextFileName, @RefundFileName, @RefundFileInfo
    And post the Teams card to @ChannelName

  @Ready 
  Scenario: Confirm approval
    Given a Teams card is posted to @ChannelName 
    When a user clicks Approve on the Teams card
    And the user among @ApprovedUsers:
      | ApprovedUsers |
      | Maria Vasquez |
      | Christopher Gutkowski |
      | Dana Denise Dela Fuente |

    Then submit the file to FIS


