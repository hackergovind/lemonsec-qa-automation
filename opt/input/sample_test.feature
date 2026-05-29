Feature: Sample LemonSec QA Test

  Scenario: Verify application homepage loads correctly

    Given I am on the application homepage "https://example.com"
    Then the page title should contain "Example"
    And the page should load within 3 seconds
    And I should see a navigation menu
