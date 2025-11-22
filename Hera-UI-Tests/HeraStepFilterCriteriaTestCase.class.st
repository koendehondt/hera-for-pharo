Class {
	#name : 'HeraStepFilterCriteriaTestCase',
	#superclass : 'HeraUnitTestCase',
	#instVars : [
		'changedAspect'
	],
	#category : 'Hera-UI-Tests-Step Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Step Browser'
}

{ #category : 'running' }
HeraStepFilterCriteriaTestCase >> describedClass [

	^ HeraStepFilterCriteria
]

{ #category : 'running' }
HeraStepFilterCriteriaTestCase >> initializeSubject [

	super initializeSubject.
	subject includeGivenSteps: false.
	subject includeWhenSteps: false.
	subject includeThenSteps: false
]

{ #category : 'running' }
HeraStepFilterCriteriaTestCase >> setUp [

	super setUp.
	subject addDependent: self
]

{ #category : 'running' }
HeraStepFilterCriteriaTestCase >> tearDown [

	subject ifNotNil: [subject removeDependent: self].
	super tearDown
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testChangeNotifications [

	subject includeGivenSteps: true.
	self assert: changedAspect equals: #includeGivenSteps.

	subject includeWhenSteps: true.
	self assert: changedAspect equals: #includeWhenSteps.

	subject includeThenSteps: true.
	self assert: changedAspect equals: #includeThenSteps.

	subject query: 'I see'.
	self assert: changedAspect equals: #query.

	subject onlyDeprecatedSteps: true.
	self assert: changedAspect equals: #onlyDeprecatedSteps.
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterBasedOnQueryAllowsHash [

	| stepMethodItem |
	subject includeThenSteps: true.
	subject query: 'p#ge'.
	stepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self assert: (subject satisfiedBy: stepMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterBasedOnQueryAllowsStar [

	| stepMethodItem |
	subject includeThenSteps: true.
	subject query: 'the*page'.
	stepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self assert: (subject satisfiedBy: stepMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterBasedOnQueryMatchesCaseInsensitively [

	| stepMethodItem |
	subject includeThenSteps: true.
	subject query: 'i'.
	stepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self assert: stepMethodItem stepDescription first isUppercase.
	self assert: (subject satisfiedBy: stepMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterBasedOnQueryMatchesSubstring [

	| matchingStepMethodItem nonMatchingMethodItem |
	subject includeThenSteps: true.
	subject query: 'see'.
	matchingStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self assert: (subject satisfiedBy: matchingStepMethodItem).
	
	nonMatchingMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepTheAPIRespondsWith:).
	self deny: (subject satisfiedBy: nonMatchingMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterCombination [

	| givenStepMethodItem whenStepMethodItem thenStepMethodItem nonMatchingMethodItem deprecatedStepMethodItem emptyStepMethodItem |
	subject includeGivenSteps: true.
	subject includeWhenSteps: true.
	subject includeThenSteps: true.
	subject query: 'S'.
	givenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIHaveCredentialsToSignIn).
	self assert: (subject satisfiedBy: givenStepMethodItem).
	whenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIPressTheButtonToSignIn).
	self assert: (subject satisfiedBy: whenStepMethodItem).
	thenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self assert: (subject satisfiedBy: thenStepMethodItem).
	deprecatedStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepDeprecated).
	self assert: (subject satisfiedBy: deprecatedStepMethodItem).
	emptyStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepAPassword).
	self assert: (subject satisfiedBy: emptyStepMethodItem).
	
	nonMatchingMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting>>#stepNoEmail).
	self deny: (subject satisfiedBy: nonMatchingMethodItem).

	subject onlyDeprecatedSteps: true.
	self deny: (subject satisfiedBy: givenStepMethodItem).
	self deny: (subject satisfiedBy: whenStepMethodItem).
	self deny: (subject satisfiedBy: thenStepMethodItem).
	self assert: (subject satisfiedBy: deprecatedStepMethodItem).
	self deny: (subject satisfiedBy: emptyStepMethodItem).
	self deny: (subject satisfiedBy: nonMatchingMethodItem).

	subject onlyEmptySteps: true.
	self deny: (subject satisfiedBy: givenStepMethodItem).
	self deny: (subject satisfiedBy: whenStepMethodItem).
	self deny: (subject satisfiedBy: thenStepMethodItem).
	self assert: (subject satisfiedBy: deprecatedStepMethodItem).
	self deny: (subject satisfiedBy: emptyStepMethodItem).
	self deny: (subject satisfiedBy: nonMatchingMethodItem).

	subject onlyDeprecatedSteps: false.
	self assert: (subject satisfiedBy: givenStepMethodItem).
	self assert: (subject satisfiedBy: whenStepMethodItem).
	self assert: (subject satisfiedBy: thenStepMethodItem).
	self assert: (subject satisfiedBy: deprecatedStepMethodItem).
	self assert: (subject satisfiedBy: emptyStepMethodItem).
	self deny: (subject satisfiedBy: nonMatchingMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterDeprecatedStep [

	|  deprecatedStepMethodItem nonDeprecatedStepMethodItem |
	subject includeGivenSteps: true.
	subject includeWhenSteps: true.
	subject includeThenSteps: true.
	subject onlyDeprecatedSteps: true.
	deprecatedStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepDeprecated).
	self assert: (subject satisfiedBy: deprecatedStepMethodItem).
	
	nonDeprecatedStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIPressTheButtonToSignIn).
	self deny: (subject satisfiedBy: nonDeprecatedStepMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterEmptyStep [

	|  emptyStepMethodItem nonEmptyStepMethodItem |
	subject includeGivenSteps: true.
	subject includeWhenSteps: true.
	subject includeThenSteps: true.
	subject onlyDeprecatedSteps: false.
	subject onlyEmptySteps: true.
	emptyStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepAPassword).
	self assert: (subject satisfiedBy: emptyStepMethodItem).
	
	nonEmptyStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepTheFollowingUsersExist:).
	self deny: (subject satisfiedBy: nonEmptyStepMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterGivenStep [

	|  givenStepMethodItem whenStepMethodItem thenStepMethodItem |
	subject includeGivenSteps: true.
	givenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIHaveCredentialsToSignIn).
	self assert: (subject satisfiedBy: givenStepMethodItem).
	
	whenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIPressTheButtonToSignIn).
	self deny: (subject satisfiedBy: whenStepMethodItem).

	thenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self deny: (subject satisfiedBy: thenStepMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterThenStep [

	|  thenStepMethodItem givenStepMethodItem whenStepMethodItem |
	subject includeThenSteps: true.
	thenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self assert: (subject satisfiedBy: thenStepMethodItem).

	givenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIHaveCredentialsToSignIn).
	self deny: (subject satisfiedBy: givenStepMethodItem).
	
	whenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIPressTheButtonToSignIn).
	self deny: (subject satisfiedBy: whenStepMethodItem)

]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterWhenStep [

	| whenStepMethodItem givenStepMethodItem thenStepMethodItem |
	subject includeWhenSteps: true.
	whenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIPressTheButtonToSignIn).
	self assert: (subject satisfiedBy: whenStepMethodItem).

	givenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIHaveCredentialsToSignIn).
	self deny: (subject satisfiedBy: givenStepMethodItem).
	
	thenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self deny: (subject satisfiedBy: thenStepMethodItem)
]

{ #category : 'tests' }
HeraStepFilterCriteriaTestCase >> testFilterYieldsNothingWithoutStepType [

	| whenStepMethodItem givenStepMethodItem thenStepMethodItem |
	givenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIHaveCredentialsToSignIn).
	self deny: (subject satisfiedBy: givenStepMethodItem).
	whenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepIPressTheButtonToSignIn).
	self deny: (subject satisfiedBy: whenStepMethodItem).
	thenStepMethodItem := HeraStepMethodItem new stepMethod: (HeraAcceptanceTestExamplesForTesting >> #stepISeeTheHomePage).
	self deny: (subject satisfiedBy: thenStepMethodItem)
]

{ #category : 'updating' }
HeraStepFilterCriteriaTestCase >> update: anAspect [

	changedAspect := anAspect
]
