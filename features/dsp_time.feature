Feature: Updated default time for (DSP) students
  As a TA for CS61AS
  So that I don't have to remember to change the quiz length
  I want to have the default time be whatever it was last time

Background:
  Given the web site is set up
  Given cs61as-ta is logged in

Scenario: using default time
  When cs61as-st requests a quiz for lesson 1
  When I click "Requests"
  Then selected time should be "60" minutes

Scenario: changing time updates next time
  When cs61as-st requests a quiz for lesson 1
  When I click "Requests"
  Then selected time should be "60" minutes
  Then I select "120 minutes" from "quiz_time"
  And I press "Approve Quiz"
  When I click "Dashboard"
  Then cs61as-st requests a quiz for lesson 2
  When I click "Requests"
  Then selected time should be "120" minutes