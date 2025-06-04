Class {
	#name : 'HeraAcceptanceTestWithFeatureTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestWithFeatureTestCase >> describedClass [

	^ HeraAcceptanceTestWithStepArgumentsForTesting
]

{ #category : 'running' }
HeraAcceptanceTestWithFeatureTestCase >> initializeSubject [

	subject := self describedClass selector: #featureSigningInWithEmailAndPassword
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testFeature [

	| feature |
	feature := subject feature.
	self assert: (feature isMemberOf: HeraFeature).
	self assert: feature scenarios size equals: 1
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testFeatureMethods [

	| featureMethodSelectors |
	featureMethodSelectors := subject featureMethods collect: [ :each | each selector ].
	self assert: featureMethodSelectors equals: { #featureSigningInWithEmailAndPassword }
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testInstanceCreation [

	self assert: subject featureSelector equals: #featureSigningInWithEmailAndPassword
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testMethodForStepDescription [

	self assert: (subject methodForStepDescription: 'I am on the sign-in page') selector  equals: #stepIAmOnTheSignInPage.
	self assert: (subject methodForStepDescription: 'I fill in the field labeled "Email:"') selector equals: #stepIFillInTheFieldLabeled:.
	self assert: (subject methodForStepDescription: 'I fill in the field labeled "Password:"') selector equals: #stepIFillInTheFieldLabeled:.
	self assert: (subject methodForStepDescription: 'I press the button labeled "Sign in"') selector equals: #stepIPressTheButtonLabeled:.
	self assert: (subject methodForStepDescription: 'I see the home page') selector equals: #stepISeeTheHomePage
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testRunExactStepDefinition [

	subject runStep: (HeraThenStep new description: 'I see the home page').
	self assert: subject seenTheHomePage
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testRunMatchStepDefinition [

	subject runStep: (HeraThenStep new description: 'I fill in the field labeled "First name:"').
	self assert: subject givenFieldLabelArgument equals: 'First name:'.
	subject runStep: (HeraThenStep new description: 'I fill in the field labeled "Last name:"').
	self assert: subject givenFieldLabelArgument equals: 'Last name:'
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testRunRegexStepDefinition [
	
	subject runStep: (HeraThenStep new description: 'I press the button labeled "Save"').
	self assert: subject givenButtonLabelArgument equals: 'Save'.
	subject runStep: (HeraThenStep new description: 'I press the button labeled "Cancel"').
	self assert: subject givenButtonLabelArgument equals: 'Cancel'
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testRunningUnknowStepRaisesException [

	self
		should: [ subject runStep: (HeraThenStep new description: 'I see the landing page') ]
		raise: HeraStepDefinitionNotFoundError
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testStepMethods [
	
	| sortedStepMethodSelectors |
	sortedStepMethodSelectors := (subject class stepMethods collect: [ :each | each selector ]) sorted.
	self assert: sortedStepMethodSelectors equals: {
		#stepIAmOnTheSignInPage .
		#stepIFillInTheFieldLabeled: .
		#stepIPressTheButtonLabeled: .
		#stepISeeTheHomePage }
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testStepMethodsForAcceptanceTestWithTrait [

	| classWithTrait sortedStepMethodSelectors |
	classWithTrait := HeraAcceptanceTestWithTraitForTesting.
	self deny: (classWithTrait >> #stepIAmOnTheSignInPage) isFromTrait.
	self assert: (classWithTrait >> #stepIFillInTheFieldLabeled:) isFromTrait.
	self assert: (classWithTrait >> #stepIPressTheButtonLabeled:) isFromTrait.
	self assert: (classWithTrait >> #stepISeeTheHomePage) isFromTrait.
	sortedStepMethodSelectors := (classWithTrait stepMethods collect: [ :each | each selector ]) sorted.
	self
		assert: sortedStepMethodSelectors
		equals: {
			#stepIAmOnTheSignInPage .
			#stepIFillInTheFieldLabeled: .
			#stepIPressTheButtonLabeled: .
			#stepISeeTheHomePage }
]

{ #category : 'tests' }
HeraAcceptanceTestWithFeatureTestCase >> testStepMethodsForAcceptanceTestWithoutTraits [

	| classWithoutTraits sortedStepMethodSelectors |
	classWithoutTraits := HeraAcceptanceTestWithStepArgumentsForTesting.
	sortedStepMethodSelectors := (classWithoutTraits stepMethods collect: [ :each | each selector ]) sorted.
	self
		assert: sortedStepMethodSelectors
		equals: {
			#stepIAmOnTheSignInPage .
			#stepIFillInTheFieldLabeled: .
			#stepIPressTheButtonLabeled: .
			#stepISeeTheHomePage }
]
