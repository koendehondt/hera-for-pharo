Class {
	#name : 'HeraAcceptanceTestWithLintIssuesForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'accessing' }
HeraAcceptanceTestWithLintIssuesForTesting class >> nameInBrowser [

	^ 'Example with lint issues'
]

{ #category : 'features' }
HeraAcceptanceTestWithLintIssuesForTesting >> featureWithLintIssues [

	<heraFeature: 'show lint issues'>

	^ (self feature: 'show lint issues')
		scenarios: {
			(self scenario: 'A Given step should come before any other step')
				when: 'I open the sign-in page';
				given: 'I have credentials to sign in';
				then: 'I can sign in' .
			(self scenario: 'A single Given indicates a scenario that is not finished yet')
				given: 'I have credentials to sign in' .
			(self scenario: 'An And step should not be the first step')
				and: 'I have credentials to sign in' .
			(self scenario: 'A But step should not be the first step')
				but: 'I do not have credentials to sign in' .
			(self scenario: 'A Then step should not be the first step')
				then: 'I can see the home page' .
			(self scenario: 'a title should start with an uppercase letter')
				given: 'I have credentials to sign in' .
			(self scenario: 'A colon after a step keyword is not necessary')
				given: ': I have credentials to sign in' }
]
