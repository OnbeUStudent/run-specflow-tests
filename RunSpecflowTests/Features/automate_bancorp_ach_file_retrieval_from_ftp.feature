Feature: Automate Bancorp ACH file retrieval from FTP
  As a Finance user
  I want automated ACH payment file synchronization
  So that the files do not need to be copied and decrypted manually

  
  
  @Ready 
  Scenario: ACH file read from pipeline
    When the flow is triggered (5 days a week at 02:00)
    Given the ADF pipeline has been activated for a valid @FileName:
      | FileName |
      | DailyIncomingACHCredits_A_[Date].CSV.PGP |
      | DailyIncomingACHCredits_B_[Date].CSV.PGP |

    Then the flow inspects the FTP destination for any of @FileName every 15 minutes
    And file A or B is found
    Then the flow downloads the file and passes it to the decryption API
    Then the decrypted contents are obtained and forwarded as a .xlsx to SharePoint at @SharepointPath
    Then the rows are posted to a SharePoint list at @SharepointSheetPath with additional @ReferenceData columns incl. the new row IDs
    Then post a Teams card notifying Finance about the upload at @SharepointPath
    Then post a Kosmos database entry with the current date, @ReferenceData, SharePoint row IDs, and success flag
    Then terminate if both files have been processed

  @WIP 
  Scenario: ACH file not read
    When the flow is triggered (5 days a week at 02:00)
    Given the ADF pipeline has been not been activated or failed
    Then the flow inspects the FTP destination for any of @FileName every 15 minutes
    And one or two files are still missing by end of day at 17:30
    Then post a Teams card notifying Finance about the missing file or files
    Then post a Kosmos database entry with the current date, @ReferenceData, and failure flag


