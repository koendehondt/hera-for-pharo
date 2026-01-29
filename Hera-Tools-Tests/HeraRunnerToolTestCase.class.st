Class {
	#name : 'HeraRunnerToolTestCase',
	#superclass : 'HeraUnitTestCase',
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
	subject run: (HeraScope new addHierarchy: HeraSelfAcceptanceTest).
	script := subject resultsFileReference readStreamDo: [ :stream | stream contents ].
	self assert: script matches: 'Running 4 features.


Feature\: Basic browsing

	In order to read features
	As a test author
	I want to browse the available features

	Scenario\: Opening the Feature Browser from the Pharo menu bar
		When I select the "Browse >> Hera Feature Browser" menu item from the Pharo menu bar
		Then the "Hera Feature Browser" window opens
		Then I see an empty list of features

	Scenario\: Browsing features
		When I select the "Browse >> Hera Documentation & Examples" menu item from the Pharo menu bar
		Then the "Documentation & Examples" window opens
		Then I see the following "Features" tree\:
			>  Spec documentation and examples
			>>   Checkboxes
			>>   Fields
			>>   Lists
			>>   Menus
			>>   Radio buttons
			>>   Trees
			>>   Windows
		When I select "Spec documentation and examples >> Checkboxes" in the "Features" tree
		Then I see this script\:
			"""
			Feature\: Checkboxes
			
				Background\:
					Given a family tree\:
						> John
			
				Scenario\: Checked state, unchecked state, checking and unchecking
					When I start the Family Tree application on "John"
					Then the "Family tree of John" window opens
					And I select "John" in the "Family" tree
					Then the "Disabled" checkbox is unchecked
					When I check the "Disabled" checkbox
					Then the "Disabled" checkbox is checked
					When I uncheck the "Disabled" checkbox
					Then the "Disabled" checkbox is unchecked
			
			
			"""
		When I select "Spec documentation and examples >> Fields" in the "Features" tree
		Then I see this script\:
			"""
			Feature\: Fields
			
				Background\:
					Given a family tree\:
						>   John
						>>    Jane
						>>>     William
						>>    Mary
						>>    Charles
			
				Scenario\: Reading
					When I start the Family Tree application on "John"
					Then the "Family tree of John" window opens
					And I select "John" in the "Family" tree
					Then I see "John" in the "Name" field
			
				Scenario\: Filling in
					When I start the Family Tree application on "John"
					Then the "Family tree of John" window opens
					And I select "John" in the "Family" tree
					And I fill in "John" in the "Name" field
					Then I see "John" in the "Name" field
			
			
			"""


Feature\: Running features

	Scenario\: Application of initial run button enablement
		When I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar
		Then the "Hera Feature Browser" window opens
		When I select "Examples for testing >> With single step scenario" in the "Features" tree
		And I press the "Step selected features" button
		Then the "Running 0/1 – Stepping" window opens
		And I see an enabled "Continue" button
		And I see a disabled "Step until end of scenario" button
		And I see an enabled "Step" button
		And I see an enabled "Restart" button

	Scenario\: Running a passing feature from the Feature Browser
		When I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar
		Then the "Hera Feature Browser" window opens
		When I select "Examples for testing >> With single step scenario" in the "Features" tree
		And I press the "Run selected features" button
		Then the "Finished 1/1" window opens
		And I see the full run log of the passed test
		And I see a disabled "Continue" button
		And I see a disabled "Step until end of scenario" button
		And I see a disabled "Step" button
		And I see an enabled "Restart" button

	Scenario\: Running a feature with an error from the Feature Browser
		When I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar
		Then the "Hera Feature Browser" window opens
		When I select "Examples for testing >> With error" in the "Features" tree
		And I press the "Run selected features" button
		Then the "Finished 1/1" window opens
		Then I see the full run log of the errored test
		And I see a disabled "Continue" button
		And I see a disabled "Step until end of scenario" button
		And I see a disabled "Step" button
		And I see an enabled "Restart" button

	Scenario\: Debugging a feature from the Feature Browser

		This scenario uses a special step to press the debug button
		because the exception will be unhandled, which normally opens a debugger.
		However, opening the debugger will stop the scenario.
		The special step handles the exception to keep the scenario running.

		When I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar
		Then the "Hera Feature Browser" window opens
		When I select "Examples for testing >> With error" in the "Features" tree
		And I press the debug button
		Then an unhandled exception is raised
		And the "Running 1/1 – Running this scenario in debug mode opens the debugger" window opens
		And I see the run log upto the failing step
		And I see an enabled "Continue" button
		And I see a disabled "Step until end of scenario" button
		And I see an enabled "Step" button
		And I see an enabled "Restart" button

	Scenario\: Stepping a feature from the Feature Browser
		When I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar
		Then the "Hera Feature Browser" window opens
		When I select "Examples for testing >> With single step scenario" in the "Features" tree
		And I press the "Step selected features" button
		Then the "Running 0/1 – Stepping" window opens
		And I see an empty run log
		When I press the "Step" button
		Then I see the feature line of the script in the run log
		When I press the "Step" button
		Then I see the scenario line of the script in the run log
		When I press the "Step" button
		Then I see the executed steps
		When I press the "Continue" button
		Then I see the full run log of the test
		And I see a disabled "Continue" button
		And I see a disabled "Step until end of scenario" button
		And I see a disabled "Step" button
		And I see an enabled "Restart" button


Feature\: Running single scenarios

	Scenario\: Run one scenario of a feature with two scenarios
		When I open the Feature Browser on\:
			\| HeraAcceptanceTestWithPassForTesting \|
		When I select "Example with pass and unimplemented step >> Signing in" in the "Features" tree
		Then I see the script of the feature in the browser
		When I click in a step of the second scenario
		And I press Command-R
		Then the "Finished 1/1" window opens, identified by "Hera Runner"
		And I see the run log of the second scenario
		And I see the following text in the "Run log" field\:
			"""
			Running 1 feature.
			
			
			@accessing_the_system
			@signing_in
			Feature\: Signing in
			
				Signing in is required to have access to the application.
			
				Signing in requires credentials\: an email address and a password.
			
				Scenario\: Unsuccessful sign-in
					Given I have credentials to sign in
					When I enter the wrong credentials
					And I press the button to sign in
					Then I am still on the sign-in page
					But I see a message that the credentials are wrong
			
			
			Total\: 1 scenario. Passed\: 1. Failed\: 0. Error\: 0. Duration\: 0 seconds.
			
			"""
		When I click the close box of the window identified by "Hera Runner"
		And I activate the "Signing in" window
		When I click in a step of the first scenario
		And I press Command-R
		Then the "Finished 1/1" window opens
		And I see the following text in the "Run log" field\:
			"""
			Running 1 feature.
			
			
			@accessing_the_system
			@signing_in
			Feature\: Signing in
			
				Signing in is required to have access to the application.
			
				Signing in requires credentials\: an email address and a password.
			
				@sign_in
				Scenario\: Successful sign-in
			
					Access is allowed when the credentials are recognized.
			
					Given I have credentials to sign in
					When I enter my credentials
					And I press the button to sign in
					Then I see the home page
			
			
			Total\: 1 scenario. Passed\: 1. Failed\: 0. Error\: 0. Duration\: 0 seconds.
			
			"""


Feature\: Scenarios run in isolation

	Scenario\: Storing a value in an instance variable
		When the first scenario stores a value in an instance variable
		Then the instance variable holds the value

	Scenario\: No impact of other scenario
		When the second scenario runs
		Then the instance variable does not hold the value stored by the first scenario


Total\: 10 scenarios. Passed\: 10. Failed\: 0. Error\: 0. Duration\: (1 second|\d+ seconds).
'
]
