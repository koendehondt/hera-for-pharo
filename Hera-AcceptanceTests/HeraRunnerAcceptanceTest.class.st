Class {
	#name : 'HeraRunnerAcceptanceTest',
	#superclass : 'HeraSelfAcceptanceTest',
	#instVars : [
		'instanceVariable'
	],
	#category : 'Hera-AcceptanceTests',
	#package : 'Hera-AcceptanceTests'
}

{ #category : 'accessing' }
HeraRunnerAcceptanceTest class >> nameInBrowser [

	^ 'Hera Runner'
]

{ #category : 'features' }
HeraRunnerAcceptanceTest >> featureRunningFeatures [

	<heraFeature: 'Running features'>

	^ (self feature: 'Running features')
		scenarios: {
			(self scenario: 'Application of initial run button enablement')
				when: 'I open the Runner from the Feature Browser to step through a feature';
				then: 'I see an enabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see an enabled "Step" button' .
			(self scenario: 'Running a feature from the Feature Browser')
				when: 'I open the Runner from the Feature Browser to run a feature';
				then: 'I see the full output of the test run';
				and: 'the run buttons are disabled' .
			(self scenario: 'Debugging a feature from the Feature Browser')
				when: 'I open the Runner from the Feature Browser to debug a feature';
				then: 'I see the output of the test run upto the failing step';
				and: 'a debugger is open on the definition of the failing step';
				and: 'the run buttons are disabled' .
			(self scenario: 'Stepping a feature from the Feature Browser')
				given: 'a feature with one scenario';
				when: 'I open the Runner from the Feature Browser to step through the feature';
				then: 'I see no output';
				when: 'I press the "Step" button';
				then: 'I see the feature line of the script in the output';
				when: 'I press the "Step" button';
				then: 'I see the scenario line of the script in the output';
				when: 'I press the "Step" button multiple times';
				then: 'I see the executed steps';
				when: 'I press the "Continue" button';
				then: 'I see the full output of the test run';
				and: 'the run buttons are disabled' }
]

{ #category : 'features' }
HeraRunnerAcceptanceTest >> featureRunningScenariosInIsolation [

	<heraFeature: 'Running scenarios in isolation'>

	^ (self feature: 'Running scenarios in isolation')
		scenarios: {
			(self scenario: 'Storing a value in an instance variable')
				when: 'the first scenario stores a value in an instance variable';
				then: 'the instance variable holds the value' .
			(self scenario: 'No impact of other scenario')
				when: 'the second scenario runs';
				then: 'the instance variable does not hold the value stored by the first scenario' }
]

{ #category : 'test api' }
HeraRunnerAcceptanceTest >> instanceVariable [

	^ instanceVariable
]

{ #category : 'test api' }
HeraRunnerAcceptanceTest >> instanceVariable: anObject [

	instanceVariable := anObject
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheFirstScenarioStoresAValueInAnInstanceVariable [

	<heraStepDefinition: #(When 'the first scenario stores a value in an instance variable')>

	instanceVariable := 123
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheInstanceVariableDoesNotHoldTheValueStoredByTheFirstScenario [

	<heraStepDefinition: #(When 'the instance variable does not hold the value stored by the first scenario')>

	self assertNil: instanceVariable
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheInstanceVariableHoldsTheValue [

	<heraStepDefinition: #(When 'the instance variable holds the value')>

	self assert: instanceVariable equals: 123
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheSecondScenarioRuns [

	<heraStepDefinition: #(When 'the second scenario runs')>

	"Nothing to do."
]
