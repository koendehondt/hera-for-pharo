Class {
	#name : 'HeraRunnerToolTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tools-Tests',
	#package : 'Hera-Tools-Tests'
}

{ #category : 'running' }
HeraRunnerToolTestCase >> describedClass [

	^ HeraRunnerTool
]

{ #category : 'running' }
HeraRunnerToolTestCase >> tearDown [

	subject resultsFileReference deleteIfAbsent: [ ].
	super tearDown
]

{ #category : 'tests' }
HeraRunnerToolTestCase >> testRunAllSelfAcceptanceTests [

	| script |
	subject run: (HeraScope new includeHierarchy: HeraSelfAcceptanceTest).
	script := subject resultsFileReference readStreamDo: [ :stream | stream contents ].
	self assert: script equals: 'Feature: Basic browsing

	Scenario: Browsing when no features exist
		Given no features exist
		When I open the Feature Browser
		Then I see an empty list of features

	Scenario: Browsing features
		Given two features exist
		When I open the Feature Browser
		Then I see two features in the list
		When I select the first feature
		Then I see the script of the first feature in the browser
		When I select the second feature
		Then I see the script of the second feature in the browser


Feature: Running features

	Scenario: Application of initial run button enablement
		When I open the Runner from the Feature Browser to step through a feature
		Then I see an enabled "Continue" button
		And I see a disabled "Step until end of scenario" button
		And I see an enabled "Step" button

	Scenario: Running a feature from the Feature Browser
		When I open the Runner from the Feature Browser to run a feature
		Then I see the full output of the test run
		And the run buttons are disabled

	Scenario: Debugging a feature from the Feature Browser
		When I open the Runner from the Feature Browser to debug a feature
		Then I see the output of the test run upto the failing step
		And a debugger is open on the definition of the failing step
		And the run buttons are disabled

	Scenario: Stepping a feature from the Feature Browser
		Given a feature with one scenario
		When I open the Runner from the Feature Browser to step through the feature
		Then I see no output
		When I press the "Step" button
		Then I see the feature line of the script in the output
		When I press the "Step" button
		Then I see the scenario line of the script in the output
		When I press the "Step" button multiple times
		Then I see the executed steps
		When I press the "Continue" button
		Then I see the full output of the test run
		And the run buttons are disabled


Feature: Running scenarios in isolation

	Scenario: Storing a value in an instance variable
		When the first scenario stores a value in an instance variable
		Then the instance variable holds the value

	Scenario: No impact of other scenario
		When the second scenario runs
		Then the instance variable does not hold the value stored by the first scenario


Number of features: 3
Number of scenarios: 8
Passed: 8
Failed: 0
Error: 0'
]
