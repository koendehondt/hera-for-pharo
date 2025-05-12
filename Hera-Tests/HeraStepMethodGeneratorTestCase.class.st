Class {
	#name : 'HeraStepMethodGeneratorTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Generation',
	#package : 'Hera-Tests',
	#tag : 'Generation'
}

{ #category : 'running' }
HeraStepMethodGeneratorTestCase >> describedClass [

	^ HeraStepMethodGenerator
]

{ #category : 'tests' }
HeraStepMethodGeneratorTestCase >> testEmptyStepMethod [

	subject
		type: 'Given';
		description: 'I am on the sign-in page';
		source: 'stepIAmOnTheSignInPage';
		acceptanceTestClass: HeraAcceptanceTest.
	self assert: subject generatedCode equals: 'stepIAmOnTheSignInPage

	<heraStepDefinition: #(Given ''I am on the sign-in page'')>'
]

{ #category : 'tests' }
HeraStepMethodGeneratorTestCase >> testEmptyStepMethodWithComment [

	subject
		type: 'Given';
		description: 'I am on the sign-in page';
		source: 'stepIAmOnTheSignInPage
	"comment"';
		acceptanceTestClass: HeraAcceptanceTest.
	self assert: subject generatedCode equals: 'stepIAmOnTheSignInPage
	"comment"

	<heraStepDefinition: #(Given ''I am on the sign-in page'')>'
]

{ #category : 'tests' }
HeraStepMethodGeneratorTestCase >> testStepMethodWithBody [

	subject
		type: 'Given';
		description: 'I am on the sign-in page';
		source: 'stepIAmOnTheSignInPage

	self yourself';
		acceptanceTestClass: HeraAcceptanceTest.
	self assert: subject generatedCode equals: 'stepIAmOnTheSignInPage

	<heraStepDefinition: #(Given ''I am on the sign-in page'')>

	self yourself'
]

{ #category : 'tests' }
HeraStepMethodGeneratorTestCase >> testStepMethodWithBodyAndComment [

	subject
		type: 'Given';
		description: 'I am on the sign-in page';
		source: 'stepIAmOnTheSignInPage
	"comment"

	self yourself';
		acceptanceTestClass: HeraAcceptanceTest.
	self assert: subject generatedCode equals: 'stepIAmOnTheSignInPage
	"comment"

	<heraStepDefinition: #(Given ''I am on the sign-in page'')>

	self yourself'
]

{ #category : 'tests' }
HeraStepMethodGeneratorTestCase >> testStepMethodWithBodyAndCommentAndTemporaries [

	subject
		type: 'Given';
		description: 'I am on the sign-in page';
		source: 'stepIAmOnTheSignInPage
	"comment"

	| temp |
	self yourself';
		acceptanceTestClass: HeraAcceptanceTest.
	self assert: subject generatedCode equals: 'stepIAmOnTheSignInPage
	"comment"

	<heraStepDefinition: #(Given ''I am on the sign-in page'')>

	| temp |
	self yourself'
]

{ #category : 'tests' }
HeraStepMethodGeneratorTestCase >> testStepMethodWithBodyAndTemporaries [

	subject
		type: 'Given';
		description: 'I am on the sign-in page';
		source: 'stepIAmOnTheSignInPage

	| temp |
	self yourself';
		acceptanceTestClass: HeraAcceptanceTest.
	self assert: subject generatedCode equals: 'stepIAmOnTheSignInPage

	<heraStepDefinition: #(Given ''I am on the sign-in page'')>

	| temp |
	self yourself'
]

{ #category : 'tests' }
HeraStepMethodGeneratorTestCase >> testStepMethodWithMatch [

	subject
		type: 'Given';
		pattern: 'match';
		description: 'I am on the sign-in page';
		source: 'stepIAmOnTheSignInPage';
		acceptanceTestClass: HeraAcceptanceTest.
	self assert: subject generatedCode equals: 'stepIAmOnTheSignInPage

	<heraStepDefinition: #(Given match ''I am on the sign-in page'')>'
]

{ #category : 'tests' }
HeraStepMethodGeneratorTestCase >> testStepMethodWithRegex [

	subject
		type: 'Given';
		pattern: 'regex';
		description: 'I am on the sign-in page';
		source: 'stepIAmOnTheSignInPage';
		acceptanceTestClass: HeraAcceptanceTest.
	self assert: subject generatedCode equals: 'stepIAmOnTheSignInPage

	<heraStepDefinition: #(Given regex ''I am on the sign-in page'')>'
]
