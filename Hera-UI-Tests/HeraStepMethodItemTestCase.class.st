Class {
	#name : 'HeraStepMethodItemTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Step Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Step Browser'
}

{ #category : 'running' }
HeraStepMethodItemTestCase >> describedClass [

	^ HeraStepMethodItem
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testAcceptanceTestClass [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIAmOnTheSignInPage.
	self assert: subject acceptanceTestClass equals: HeraAcceptanceTestWithStepArgumentsForTesting
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testFullStepDescriptionForGivenStep [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIAmOnTheSignInPage.
	self assert: subject fullStepDescription equals: 'Given I am on the sign-in page'
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testFullStepDescriptionForThenStep [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepISeeTheHomePage.
	self assert: subject fullStepDescription equals: 'Then I see the home page'
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testSaveSourcePutsMethodInGivenProtocol [

	subject stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepNoEmail.
	self deny: (HeraAcceptanceTestExamplesForTesting class includesSelector: #stepTest).
	[
		subject saveSource: 'stepTest

	<heraStepDefinition: #(When ''I test'')>

	"Do something"' inProtocol: 'just testing'.
		self assert: (HeraAcceptanceTestExamplesForTesting>>#stepTest) protocol name equals: #'just testing' ]
		ensure: [
			(HeraAcceptanceTestExamplesForTesting includesSelector: #stepTest)
				ifTrue: [ (HeraAcceptanceTestExamplesForTesting>>#stepTest) removeFromSystem ] ]
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testStepDescriptionForExactStepDefinition [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIAmOnTheSignInPage.
	self assert: subject stepDescription equals: 'I am on the sign-in page'
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testStepDescriptionForMatchStepDefinition [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIFillInTheFieldLabeled:.
	self assert: subject stepDescription equals: 'I fill in the field labeled {string}'
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testStepDescriptionForRegexStepDefinition [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIPressTheButtonLabeled:.
	self assert: subject stepDescription equals: 'I press the button labeled "([^"]+)"'
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testStepFullDescriptionForWhenStep [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIFillInTheFieldLabeled:.
	self assert: subject fullStepDescription equals: 'When I fill in the field labeled {string}'
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testStepPatternForExactStepDefinition [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIAmOnTheSignInPage.
	self assert: subject stepPattern isNil
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testStepPatternForMatchStepDefinition [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIFillInTheFieldLabeled:.
	self assert: subject stepPattern equals: 'match'
]

{ #category : 'tests' }
HeraStepMethodItemTestCase >> testStepPatternForRegexStepDefinition [

	subject stepMethod: HeraAcceptanceTestWithStepArgumentsForTesting >> #stepIPressTheButtonLabeled:.
	self assert: subject stepPattern equals: 'regex'
]
