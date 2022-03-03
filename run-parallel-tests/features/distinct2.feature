Feature: Search in hello App

Background:
  Given I try to search using hello App

Scenario: Search for a term
  When I type in "lambdatest"
  Then I should see results
