Class {
	#name : 'HeraTextBasedAstSearcherTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'private' }
HeraTextBasedAstSearcherTestCase >> ast [

	^ HeraParser new
		initializeParserWith: self script;
		parseFeature
]

{ #category : 'private' }
HeraTextBasedAstSearcherTestCase >> astForRule [

	^ HeraParser new
		initializeParserWith: self scriptWithRule;
		parseFeature
]

{ #category : 'running' }
HeraTextBasedAstSearcherTestCase >> describedClass [

	^ HeraTextBasedAstSearcher
]

{ #category : 'helpers' }
HeraTextBasedAstSearcherTestCase >> endPositionOf: aString [

	^ self endPositionOf: aString in: self script

]

{ #category : 'helpers' }
HeraTextBasedAstSearcherTestCase >> endPositionOf: aString in: aScript [

	^ (aScript indexOfSubCollection: aString) + aString size - 1
]

{ #category : 'private' }
HeraTextBasedAstSearcherTestCase >> script [

	^ '@accessing_the_system
@signing_in
Feature: Signing in
	Signing in is required to have access to the application.
	Signing in requires credentials: an email address and a password.

	Background:
		Given my account is active

	@successful_sign_in
	Scenario: Successful sign-in
		Access is allowed when the credentials are recognized.

		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page'
]

{ #category : 'private' }
HeraTextBasedAstSearcherTestCase >> scriptWithRule [

	^ '
Feature: Signing in

	Rule: There is only one administrator'
]

{ #category : 'helpers' }
HeraTextBasedAstSearcherTestCase >> startPositionOf: aString [

	^ self startPositionOf: aString in: self script
]

{ #category : 'helpers' }
HeraTextBasedAstSearcherTestCase >> startPositionOf: aString in: aScript [

	^ aScript indexOfSubCollection: aString
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFeatureBackgroundFromEndPosition [

	| astNode endPosition |
	endPosition := self endPositionOf: 'Background:'.
	astNode := subject
		textPosition: endPosition;
		visit: self ast.
	self assert: astNode class equals: HeraBackgroundAstNode
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFeatureBackgroundFromStartPosition [

	| astNode startPosition |
	startPosition := self startPositionOf: 'Background:'.
	astNode := subject
		textPosition: startPosition;
		visit: self ast.
	self assert: astNode class equals: HeraBackgroundAstNode
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFeatureDescriptionFromEndPosition [

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
HeraTextBasedAstSearcherTestCase >> testSearchFeatureDescriptionFromStartPosition [

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
HeraTextBasedAstSearcherTestCase >> testSearchFeatureFromEndPositionAnswersLastNode [

	| astNode |
	astNode := subject
		textPosition: self script size;
		visit: self ast.
	self assert: astNode class equals: HeraThenAstNode.
	self assert: astNode description equals: 'I see the home page'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFeatureFromPositionOutsideAnyNode [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: 'Access is allowed when the credentials are recognized.') + 1;
		visit: self ast.
	self deny: astNode class equals: HeraFeatureAstNode
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFeatureFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Feature: Signing in');
		visit: self ast.
	self assert: astNode class equals: HeraFeatureAstNode
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFeatureTitleFromEndPosition [

	| astNode endPosition |
	endPosition := self endPositionOf: 'Signing in'.
	astNode := subject
		textPosition: endPosition;
		visit: self ast.
	self assert: astNode class equals: HeraTitleAstNode.
	self assert: astNode text equals: 'Signing in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFeatureTitleFromStartPosition [

	| astNode startPosition |
	startPosition := self startPositionOf: 'Signing in'.
	astNode := subject
		textPosition: startPosition;
		visit: self ast.
	self assert: astNode class equals: HeraTitleAstNode.
	self assert: astNode text equals: 'Signing in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFirstFeatureTagFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: '@accessing_the_system');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'accessing_the_system'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFirstFeatureTagFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: '@accessing_the_system');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'accessing_the_system'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFirstStepFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: 'Given I have credentials to sign in');
		visit: self ast.
	self assert: astNode class equals: HeraGivenAstNode.
	self assert: astNode description equals: 'I have credentials to sign in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchFirstStepFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Given I have credentials to sign in');
		visit: self ast.
	self assert: astNode class equals: HeraGivenAstNode.
	self assert: astNode description equals: 'I have credentials to sign in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchRuleFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: 'Rule: There is only one administrator' in: self scriptWithRule);
		visit: self astForRule.
	self assert: astNode class equals: HeraRuleAstNode.
	self assert: astNode title text equals: 'There is only one administrator'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchRuleFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Rule: There is only one administrator' in: self scriptWithRule);
		visit: self astForRule.
	self assert: astNode class equals: HeraRuleAstNode.
	self assert: astNode title text equals: 'There is only one administrator'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchScenarioDescriptionFromEndPosition [

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
HeraTextBasedAstSearcherTestCase >> testSearchScenarioDescriptionFromStartPosition [

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
HeraTextBasedAstSearcherTestCase >> testSearchScenarioFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Scenario: Successful sign-in');
		visit: self ast.
	self assert: astNode class equals: HeraScenarioAstNode.
	self assert: astNode title text equals: 'Successful sign-in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchScenarioTagFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: '@successful_sign_in');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'successful_sign_in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchScenarioTagFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: '@successful_sign_in');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'successful_sign_in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchScenarioTitleFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'Successful sign-in');
		visit: self ast.
	self assert: astNode class equals: HeraTitleAstNode.
	self assert: astNode text equals: 'Successful sign-in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchSecondFeatureTagFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: '@signing_in');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'signing_in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchSecondFeatureTagFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: '@signing_in');
		visit: self ast.
	self assert: astNode class equals: HeraTagAstNode.
	self assert: astNode name equals: 'signing_in'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchSecondStepFromEndPosition [

	| astNode |
	astNode := subject
		textPosition: (self endPositionOf: 'When I enter my credentials');
		visit: self ast.
	self assert: astNode class equals: HeraWhenAstNode.
	self assert: astNode description equals: 'I enter my credentials'
]

{ #category : 'tests' }
HeraTextBasedAstSearcherTestCase >> testSearchSecondStepFromStartPosition [

	| astNode |
	astNode := subject
		textPosition: (self startPositionOf: 'When I enter my credentials');
		visit: self ast.
	self assert: astNode class equals: HeraWhenAstNode.
	self assert: astNode description equals: 'I enter my credentials'
]
