Class {
	#name : 'HeraRunnerAcceptanceTest',
	#superclass : 'HeraSelfAcceptanceTest',
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
				and: 'a debugger is open on the defintion of the failing step';
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
