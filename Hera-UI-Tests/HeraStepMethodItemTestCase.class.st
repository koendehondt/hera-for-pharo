Class {
	#name : 'HeraStepMethodItemTestCase',
	#superclass : 'HeraTestCase',
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
