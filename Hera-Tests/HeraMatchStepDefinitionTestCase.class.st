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

	subject pattern: '{} is visible in the list'.
	self assert: (subject match: 'John Doe is visible in the list') equals: #('John Doe')
]

{ #category : 'tests - anything' }
HeraMatchStepDefinitionTestCase >> testMatchAnythingAtTheEndOfTheLine [

	subject pattern: 'I send a GET request to {}'.
	self assert: (subject match: 'I send a GET request to https://api.mysite.test/users') equals: #('https://api.mysite.test/users')
]

{ #category : 'tests - anything' }
HeraMatchStepDefinitionTestCase >> testMatchAnythingAtTheMiddleOfTheLine [

	subject pattern: 'I send a {} request'.
	self assert: (subject match: 'I send a POST request') equals: #('POST')
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchDate [

	subject pattern: 'today is {date}'.
	self assert: (subject match: 'today is 2025-08-16') equals: { Date year: 2025 month: 8 day: 16 }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchDateDmy [

	subject pattern: 'today is {date:dmy}'.
	self assert: (subject match: 'today is 16/08/2025') equals: { Date year: 2025 month: 8 day: 16 }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchDateIso [

	subject pattern: 'today is {date:iso}'.
	self assert: (subject match: 'today is 2025-08-16') equals: { Date year: 2025 month: 8 day: 16 }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchDateMdy [

	subject pattern: 'today is {date:mdy}'.
	self assert: (subject match: 'today is 08/16/2025') equals: { Date year: 2025 month: 8 day: 16 }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchDateYmd [

	subject pattern: 'today is {date:ymd}'.
	self assert: (subject match: 'today is 2025/08/16') equals: { Date year: 2025 month: 8 day: 16 }
]

{ #category : 'tests - string' }
HeraMatchStepDefinitionTestCase >> testMatchEmptyString [

	subject pattern: 'I see {string} in the field'.
	self assert: (subject match: 'I see "" in the field') equals: #('')
]

{ #category : 'tests- float' }
HeraMatchStepDefinitionTestCase >> testMatchFloatRequiresDecimalPart [

	subject pattern: 'I see the amount {float}'.
	self assert: (subject match: 'I see the amount 3') isNil
]

{ #category : 'tests' }
HeraMatchStepDefinitionTestCase >> testMatchMultipleArguments [

	subject pattern: 'I press the button labeled {string} {int} times'.
	self assert: (subject match: 'I press the button labeled "Increase" 5 times') equals: #('Increase' 5)
]

{ #category : 'tests- float' }
HeraMatchStepDefinitionTestCase >> testMatchNegativeFloat [

	subject pattern: 'I see the amount {float}'.
	self assert: (subject match: 'I see the amount -3.1415') equals: #(-3.1415)
]

{ #category : 'tests - integer' }
HeraMatchStepDefinitionTestCase >> testMatchNegativeInteger [

	subject pattern: 'I see the field value {int}'.
	self assert: (subject match: 'I see the field value -1') equals: #(-1)
]

{ #category : 'tests- float' }
HeraMatchStepDefinitionTestCase >> testMatchPositiveFloat [

	subject pattern: 'I see the amount {float}'.
	self assert: (subject match: 'I see the amount 3.1415') equals: #(3.1415)
]

{ #category : 'tests - integer' }
HeraMatchStepDefinitionTestCase >> testMatchPositiveInteger [

	subject pattern: 'I press the button {int} times'.
	self assert: (subject match: 'I press the button 5 times') equals: #(5)
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

	subject pattern: 'I fill in the field labeled {string}'.
	subject preferSingleQuotedStringArguments.
	self assert: (subject match: 'I fill in the field labeled ''First name:''') equals: #('First name:')
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchTime [

	subject pattern: 'time is frozen at {time}'.
	self assert: (subject match: 'time is frozen at 23:59') equals: { Time hour: 23 minute: 59 second: 0 }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchTime12h [

	| expectedTime |
	subject pattern: 'time is frozen at {time:12h}'.
	expectedTime := Time hour: 21 minute: 59 second: 0.
	self assert: (subject match: 'time is frozen at 09:59 pm') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59pm') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59 PM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59PM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 9:59 PM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 9:59PM') equals: { expectedTime }.

	expectedTime := Time hour: 9 minute: 59 second: 0.
	self assert: (subject match: 'time is frozen at 09:59 am') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59am') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59 AM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59AM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 9:59 AM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 9:59AM') equals: { expectedTime }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchTime12hWithSeconds [

	| expectedTime |
	subject pattern: 'time is frozen at {time:12h}'.
	expectedTime := Time hour: 21 minute: 59 second: 47.
	self assert: (subject match: 'time is frozen at 09:59:47 pm') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59:47pm') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59:47 PM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59:47PM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 9:59:47 PM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 9:59:47PM') equals: { expectedTime }.

	expectedTime := Time hour: 9 minute: 59 second: 47.
	self assert: (subject match: 'time is frozen at 09:59:47 am') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59:47am') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59:47 AM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 09:59:47AM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 9:59:47 AM') equals: { expectedTime }.
	self assert: (subject match: 'time is frozen at 9:59:47AM') equals: { expectedTime }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchTime24h [

	subject pattern: 'time is frozen at {time:24h}'.
	self assert: (subject match: 'time is frozen at 23:59') equals: { Time hour: 23 minute: 59 second: 0 }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchTime24hWithSeconds [

	subject pattern: 'time is frozen at {time:24h}'.
	self assert: (subject match: 'time is frozen at 23:59:15') equals: { Time hour: 23 minute: 59 second: 15 }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchTimeWithSeconds [

	subject pattern: 'time is frozen at {time}'.
	self assert: (subject match: 'time is frozen at 23:59:15') equals: { Time hour: 23 minute: 59 second: 15 }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchTimestamp [

	subject pattern: 'the creation time is {timestamp}'.
	self
		assert: (subject match: 'the creation time is 2025-08-16T21:05:34+02:00')
		equals: { DateAndTime year: 2025 month: 8 day: 16 hour: 21 minute: 5 second: 34 offset: 2 hours }.
	self
		assert: (subject match: 'the creation time is 2025-08-16T21:05:34-02:00')
		equals: { DateAndTime year: 2025 month: 8 day: 16 hour: 21 minute: 5 second: 34 offset: -2 hours }.
	self
		assert: (subject match: 'the creation time is 2025-08-16T21:05:34Z')
		equals: { DateAndTime year: 2025 month: 8 day: 16 hour: 21 minute: 5 second: 34 offset: 0 hours }
]

{ #category : 'tests - word' }
HeraMatchStepDefinitionTestCase >> testMatchWord [

	subject pattern: 'I see {word} in the field'.
	self assert: (subject match: 'I see something in the field') equals: #('something')
]
