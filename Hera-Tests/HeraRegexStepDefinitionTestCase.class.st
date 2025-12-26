Class {
	#name : 'HeraRegexStepDefinitionTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Step definitions',
	#package : 'Hera-Tests',
	#tag : 'Step definitions'
}

{ #category : 'running' }
HeraRegexStepDefinitionTestCase >> describedClass [

	^ HeraRegexStepDefinition
]

{ #category : 'tests' }
HeraRegexStepDefinitionTestCase >> testMatchMultipleArguments [

	| actualArguments |
	subject pattern: 'I press the button labeled "(.+)" (\d+) times'.
	actualArguments := subject match: 'I press the button labeled "Increase the value" 5 times'.
	self assert: actualArguments equals: #('Increase the value' '5')
]

{ #category : 'tests' }
HeraRegexStepDefinitionTestCase >> testMatchNoArgument [

	| actualArguments |
	subject pattern: 'I press the button labeled "Increase" 5 times'.
	actualArguments := subject match: 'I press the button labeled "Increase" 5 times'.
	self assert: actualArguments equals: #()
]

{ #category : 'tests' }
HeraRegexStepDefinitionTestCase >> testMatchSingleArgument [

	| actualArguments |
	subject pattern: 'I press the button labeled (\w+) 5 times'.
	actualArguments := subject match: 'I press the button labeled Increase 5 times'.
	self assert: actualArguments equals: #('Increase')
]

{ #category : 'tests - with parameters' }
HeraRegexStepDefinitionTestCase >> testMatchWithParameter [

	| actualArguments |
	subject pattern: 'I press the <field> labeled "(.+)" (\d+) times'.
	actualArguments := subject match: 'I press the button labeled "Increase the value" 5 times'.
	self assert: actualArguments equals: #('Increase the value' '5')
]
