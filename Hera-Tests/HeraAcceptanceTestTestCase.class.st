Class {
	#name : 'HeraAcceptanceTestTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestTestCase >> describedClass [

	^ HeraAcceptanceTest
]

{ #category : 'running' }
HeraAcceptanceTestTestCase >> initializeSubject [

	subject := HeraAcceptanceTestWithStepArgumentsForTesting selector: #featureSigningInWithEmailAndPassword
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testDsl [

	| feature |
	feature := subject feature.
	self assert: (feature isMemberOf: HeraFeature).
	self assert: feature scenarios size equals: 1
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testInstanceCreation [

	self assert: subject featureSelector equals: #featureSigningInWithEmailAndPassword
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testMethodForStepDescription [

	self
		assert: (subject methodForStepDescription: 'I am on the sign-in page')
		equals: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIAmOnTheSignInPage.
	self
		assert: (subject methodForStepDescription: 'I fill in the field labeled "Email:"')
		equals: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIFillInTheFieldLabeled:.
	self
		assert: (subject methodForStepDescription: 'I fill in the field labeled "Password:"')
		equals: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIFillInTheFieldLabeled:.
	self
		assert: (subject methodForStepDescription: 'I press the button labeled "Sign in"')
		equals: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIPressTheButtonLabeled:.
	self
		assert: (subject methodForStepDescription: 'I see the home page')
		equals: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepISeeTheHomePage
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testRunExactStepDefinition [

	subject runStep: (HeraThenStep new description: 'I see the home page').
	self assert: subject seenTheHomePage
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testRunMatchStepDefinition [

	subject runStep: (HeraThenStep new description: 'I fill in the field labeled "First name:"').
	self assert: subject givenFieldLabelArgument equals: 'First name:'.
	subject runStep: (HeraThenStep new description: 'I fill in the field labeled "Last name:"').
	self assert: subject givenFieldLabelArgument equals: 'Last name:'
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testRunRegexStepDefinition [
	
	subject runStep: (HeraThenStep new description: 'I press the button labeled "Save"').
	self assert: subject givenButtonLabelArgument equals: 'Save'.
	subject runStep: (HeraThenStep new description: 'I press the button labeled "Cancel"').
	self assert: subject givenButtonLabelArgument equals: 'Cancel'
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testRunningUnknowStepRaisesException [

	self
		should: [ subject runStep: (HeraThenStep new description: 'I see the landing page') ]
		raise: HeraStepDefinitionNotFoundError
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testStepMethodsForAcceptanceTestWithTrait [

	| classWithTrait sortedStepMethods |
	classWithTrait := HeraAcceptanceTestWithTraitForTesting.
	self deny: (classWithTrait >> #stepIAmOnTheSignInPage) isFromTrait.
	self assert: (classWithTrait >> #stepIFillInTheFieldLabeled:) isFromTrait.
	self assert: (classWithTrait >> #stepIPressTheButtonLabeled:) isFromTrait.
	self assert: (classWithTrait >> #stepISeeTheHomePage) isFromTrait.
	sortedStepMethods := classWithTrait stepMethods
		sorted: [ :some :other | some selector <= other selector ].
	self
		assert: sortedStepMethods
		equals: {
			classWithTrait >> #stepIAmOnTheSignInPage .
			classWithTrait >> #stepIFillInTheFieldLabeled: .
			classWithTrait >> #stepIPressTheButtonLabeled: .
			classWithTrait >> #stepISeeTheHomePage }
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testStepMethodsForAcceptanceTestWithoutTraits [

	| classWithoutTraits sortedStepMethods |
	classWithoutTraits := HeraAcceptanceTestWithStepArgumentsForTesting.
	sortedStepMethods := classWithoutTraits stepMethods
		sorted: [ :some :other | some selector <= other selector ].
	self
		assert: sortedStepMethods
		equals: {
			classWithoutTraits >> #stepIAmOnTheSignInPage .
			classWithoutTraits >> #stepIFillInTheFieldLabeled: .
			classWithoutTraits >> #stepIPressTheButtonLabeled: .
			classWithoutTraits >> #stepISeeTheHomePage }
]
