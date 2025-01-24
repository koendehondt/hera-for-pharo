Class {
	#name : 'HeraAstTextBasedSearchVisitorTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'private' }
HeraAstTextBasedSearchVisitorTestCase >> ast [

	^ HeraGherkinParser new
		initializeParserWith: self script;
		parseFeature
]

{ #category : 'running' }
HeraAstTextBasedSearchVisitorTestCase >> describedClass [

	^ HeraAstTextBasedSearchVisitor
]

{ #category : 'helpers' }
HeraAstTextBasedSearchVisitorTestCase >> endPositionOf: aString [

	^ (self script indexOfSubCollection: aString) + aString size - 1
]

{ #category : 'private' }
HeraAstTextBasedSearchVisitorTestCase >> script [

	^ '@accessing_the_system
@signing_in
Feature: Signing in
	Signing in is required to have access to the application.
	Signing in requires credentials: an email address and a password.

	@successful_sign_in
	Scenario: Successful sign-in
		Access is allowed when the credentials are recognized.

		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page'
]

{ #category : 'helpers' }
HeraAstTextBasedSearchVisitorTestCase >> startPositionOf: aString [

	^ self script indexOfSubCollection: aString
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFeatureDescriptionFromEndPosition [

	| astNode endPosition |
	endPosition := self endPositionOf: 'Signing in is required to have access to the application.
	Signing in requires credentials: an email address and a password.'.
	astNode := subject
		textPosition: endPosition;
		visit: self ast.
	self assert: astNode class equals: HeraDescriptionAstNode.
	self
		assert: astNode lines
		equals: (OrderedCollection
			with: 	'Signing in is required to have access to the application.'
			with: 'Signing in requires credentials: an email address and a password.')
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFeatureDescriptionFromStartPosition [

	| astNode startPosition |
	startPosition := self startPositionOf: 'Signing in is required to have access to the application.
	Signing in requires credentials: an email address and a password.'.
	astNode := subject
		textPosition: startPosition;
		visit: self ast.
	self assert: astNode class equals: HeraDescriptionAstNode.
	self
		assert: astNode lines
		equals: (OrderedCollection
			with: 	'Signing in is required to have access to the application.'
			with: 'Signing in requires credentials: an email address and a password.')
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFeatureFromEndPositionAnswersLastNode [

	| astNode |
	astNode := subject
		textPosition: self script size;
		visit: self ast.
	self assert: astNode class equals: HeraThenAstNode.
	self assert: astNode description equals: 'I see the home page'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFeatureFromPositionOutsideAnyNode [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: 'Access is allowed when the credentials are recognized.') + 1;
		visit: self ast.
	self deny: astNode class equals: HeraFeatureAstNode
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFeatureFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Feature: Signing in');
		visit: self ast.
	self assert: astNode class equals: HeraFeatureAstNode
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFirstFeatureTagFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: '@accessing_the_system');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'accessing_the_system'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFirstFeatureTagFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: '@accessing_the_system');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'accessing_the_system'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFirstStepFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: 'Given I have credentials to sign in');
		visit: self ast.
	self assert: astNode class equals: HeraGivenAstNode.
	self assert: astNode description equals: 'I have credentials to sign in'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchFirstStepFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Given I have credentials to sign in');
		visit: self ast.
	self assert: astNode class equals: HeraGivenAstNode.
	self assert: astNode description equals: 'I have credentials to sign in'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchScenarioDescriptionFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: 'Access is allowed when the credentials are recognized.');
		visit: self ast.
	self assert: astNode class equals: HeraDescriptionAstNode.
	self
		assert: astNode lines
		equals: (OrderedCollection with: 'Access is allowed when the credentials are recognized.')
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchScenarioDescriptionFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Access is allowed when the credentials are recognized.');
		visit: self ast.
	self assert: astNode class equals: HeraDescriptionAstNode.
	self
		assert: astNode lines
		equals: (OrderedCollection with: 'Access is allowed when the credentials are recognized.')
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchScenarioFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Scenario: Successful sign-in');
		visit: self ast.
	self assert: astNode class equals: HeraScenarioAstNode.
	self assert: astNode title equals: 'Successful sign-in'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchScenarioTagFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: '@successful_sign_in');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'successful_sign_in'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchScenarioTagFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: '@successful_sign_in');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'successful_sign_in'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchSecondFeatureTagFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: '@signing_in');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'signing_in'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchSecondFeatureTagFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: '@signing_in');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'signing_in'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchSecondStepFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: 'When I enter my credentials');
		visit: self ast.
	self assert: astNode class equals: HeraWhenAstNode.
	self assert: astNode description equals: 'I enter my credentials'
]

{ #category : 'tests' }
HeraAstTextBasedSearchVisitorTestCase >> testSearchSecondStepFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'When I enter my credentials');
		visit: self ast.
	self assert: astNode class equals: HeraWhenAstNode.
	self assert: astNode description equals: 'I enter my credentials'
]
