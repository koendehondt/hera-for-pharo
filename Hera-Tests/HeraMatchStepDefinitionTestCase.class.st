Class {
	#name : 'HeraMatchStepDefinitionTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Step definitions',
	#package : 'Hera-Tests',
	#tag : 'Step definitions'
}

{ #category : 'running' }
HeraMatchStepDefinitionTestCase >> describedClass [

	^ HeraMatchStepDefinition
]

{ #category : 'tests - anything' }
HeraMatchStepDefinitionTestCase >> testMatchAnythingAtTheBeginningOfTheLine [

	| actualArguments |
	subject pattern: '{} is visible in the list'.
	actualArguments := subject match: 'John Doe is visible in the list'.
	self assert: actualArguments equals: #('John Doe')
]

{ #category : 'tests - anything' }
HeraMatchStepDefinitionTestCase >> testMatchAnythingAtTheEndOfTheLine [

	| actualArguments |
	subject pattern: 'I send a GET request to {}'.
	actualArguments := subject match: 'I send a GET request to https://api.mysite.test/users'.
	self assert: actualArguments equals: #('https://api.mysite.test/users')
]

{ #category : 'tests - anything' }
HeraMatchStepDefinitionTestCase >> testMatchAnythingAtTheMiddleOfTheLine [

	| actualArguments |
	subject pattern: 'I send a {} request'.
	actualArguments := subject match: 'I send a POST request'.
	self assert: actualArguments equals: #('POST')
]

{ #category : 'tests - string' }
HeraMatchStepDefinitionTestCase >> testMatchEmptyString [

	| actualArguments |
	subject pattern: 'I see {string} in the field'.
	actualArguments := subject match: 'I see "" in the field'.
	self assert: actualArguments equals: #('')
]

{ #category : 'tests- float' }
HeraMatchStepDefinitionTestCase >> testMatchFloatRequiresDecimalPart [

	| actualArguments |
	subject pattern: 'I see the amount {float}'.
	actualArguments := subject match: 'I see the amount 3'.
	self assert: actualArguments isNil
]

{ #category : 'tests' }
HeraMatchStepDefinitionTestCase >> testMatchMultipleArguments [

	| actualArguments |
	subject pattern: 'I press the button labeled {string} {int} times'.
	actualArguments := subject match: 'I press the button labeled "Increase" 5 times'.
	self assert: actualArguments equals: #('Increase' 5)
]

{ #category : 'tests- float' }
HeraMatchStepDefinitionTestCase >> testMatchNegativeFloat [

	| actualArguments |
	subject pattern: 'I see the amount {float}'.
	actualArguments := subject match: 'I see the amount -3.1415'.
	self assert: actualArguments equals: #(-3.1415)
]

{ #category : 'tests - integer' }
HeraMatchStepDefinitionTestCase >> testMatchNegativeInteger [

	| actualArguments |
	subject pattern: 'I see the field value {int}'.
	actualArguments := subject match: 'I see the field value -1'.
	self assert: actualArguments equals: #(-1)
]

{ #category : 'tests- float' }
HeraMatchStepDefinitionTestCase >> testMatchPositiveFloat [

	| actualArguments |
	subject pattern: 'I see the amount {float}'.
	actualArguments := subject match: 'I see the amount 3.1415'.
	self assert: actualArguments equals: #(3.1415)
]

{ #category : 'tests - integer' }
HeraMatchStepDefinitionTestCase >> testMatchPositiveInteger [

	| actualArguments |
	subject pattern: 'I press the button {int} times'.
	actualArguments := subject match: 'I press the button 5 times'.
	self assert: actualArguments equals: #(5)
]

{ #category : 'tests - string' }
HeraMatchStepDefinitionTestCase >> testMatchStringSurroundedByDoubleQuotes [

	| actualArguments |
	subject pattern: 'I fill in the field labeled {string}'.
	actualArguments := subject match: 'I fill in the field labeled "First name:"'.
	self assert: actualArguments equals: #('First name:')
]

{ #category : 'tests - string' }
HeraMatchStepDefinitionTestCase >> testMatchStringSurroundedBySingleQuotes [

	| actualArguments |
	subject pattern: 'I fill in the field labeled {string}'.
	subject preferSingleQuotedStringArguments.
	actualArguments := subject match: 'I fill in the field labeled ''First name:'''.
	self assert: actualArguments equals: #('First name:')
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchWord [

	| actualArguments |
	subject pattern: 'I see {word} in the field'.
	actualArguments := subject match: 'I see something in the field'.
	self assert: actualArguments equals: #('something')
]
