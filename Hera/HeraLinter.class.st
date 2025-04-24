"
I lint a feature and produce a `HeraLintIssue` for every issue I find.
"
Class {
	#name : 'HeraLinter',
	#superclass : 'HeraAstVisitor',
	#instVars : [
		'warnings',
		'currentStepIndex',
		'acceptanceTest',
		'currentAstNodeWithSteps'
	],
	#category : 'Hera-Linter',
	#package : 'Hera',
	#tag : 'Linter'
}

{ #category : 'linting' }
HeraLinter >> acceptanceTest: anAcceptanceTest [

	acceptanceTest := anAcceptanceTest
]

{ #category : 'private' }
HeraLinter >> checkColonAfterKeyword: aStepAstNode [

	aStepAstNode description first = $: ifTrue: [
		self warn: 'A colon after a step keyword is not necessary' from: aStepAstNode start to: aStepAstNode end ]
]

{ #category : 'private' }
HeraLinter >> checkStepDefinitionFor: aStepAstNode [

	(self stepDefinitionExists: aStepAstNode description) ifTrue: [ ^ self ].
	self warnMissingStepDefinitionFrom: aStepAstNode start to: aStepAstNode end
]

{ #category : 'linting' }
HeraLinter >> lint: anAstNode [

	warnings := OrderedCollection new.
	self visit: anAstNode.
	^ warnings isEmpty
]

{ #category : 'private' }
HeraLinter >> previousStepsAreAllGivenSteps [

	| steps |
	steps := currentAstNodeWithSteps steps.
	^ (1 to: currentStepIndex - 1) allSatisfy: [ :index |
		(steps at: index) isGivenStepNode ]
]

{ #category : 'private' }
HeraLinter >> stepDefinitionExists: stepDescription [

	^ (acceptanceTest methodForStepDescription: stepDescription) notNil
]

{ #category : 'visiting' }
HeraLinter >> visitAndAstNode: anAndAstNode [

	self checkColonAfterKeyword: anAndAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'An And step should not be the first step in a scenario' from: anAndAstNode start to: anAndAstNode end ].
	self checkStepDefinitionFor: anAndAstNode
]

{ #category : 'visiting' }
HeraLinter >> visitBackgroundAstNode: aBackgroundAstNode [

	currentAstNodeWithSteps := aBackgroundAstNode.
	aBackgroundAstNode steps withIndexDo: [ :stepNode :stepIndex |
		currentStepIndex := stepIndex.
		self visit: stepNode ]
]

{ #category : 'visiting' }
HeraLinter >> visitButAstNode: aButAstNode [

	self checkColonAfterKeyword: aButAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'A But step should not be the first step in a scenario' from: aButAstNode start to: aButAstNode end ].
	self checkStepDefinitionFor: aButAstNode
]

{ #category : 'visiting' }
HeraLinter >> visitFeatureAstNode: aFeatureAstNode [

	| titleNode |
	aFeatureAstNode title text first isUppercase ifFalse: [
		titleNode := aFeatureAstNode title.
		self warn: 'A feature title should start with an uppercase letter' from: titleNode start to: titleNode end ].
	aFeatureAstNode background ifNotNil: [ :background | self visit: background ].
	aFeatureAstNode scenarios do: [ :each | self visit: each ].
	aFeatureAstNode rules do: [ :each | self visit: each ]
]

{ #category : 'visiting' }
HeraLinter >> visitGivenAstNode: aGivenAstNode [

	self checkColonAfterKeyword: aGivenAstNode.
	self previousStepsAreAllGivenSteps ifFalse: [
		self warn: 'A Given step should come before any other step' from: aGivenAstNode start to: aGivenAstNode end ].
	self checkStepDefinitionFor: aGivenAstNode
]

{ #category : 'visiting' }
HeraLinter >> visitRuleAstNode: aRuleAstNode [

	| titleNode |
	aRuleAstNode title text first isUppercase ifFalse: [
		titleNode := aRuleAstNode title.
		self warn: 'A rule title should start with an uppercase letter' from: titleNode start to: titleNode end ].
	aRuleAstNode background ifNotNil: [ :background | self visit: background ].
	aRuleAstNode scenarios do: [ :each | self visit: each ]
]

{ #category : 'visiting' }
HeraLinter >> visitScenarioAstNode: aScenarioAstNode [

	| titleNode |
	currentAstNodeWithSteps := aScenarioAstNode.
	aScenarioAstNode title text first isUppercase ifFalse: [
		titleNode := aScenarioAstNode title.
		self warn: 'A scenario title should start with an uppercase letter' from: titleNode start to: titleNode end ].
	aScenarioAstNode steps withIndexDo: [ :stepNode :stepIndex |
		currentStepIndex := stepIndex.
		self visit: stepNode ]
]

{ #category : 'visiting' }
HeraLinter >> visitThenAstNode: aThenAstNode [

	self checkColonAfterKeyword: aThenAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'A Then step should not be the first step in a scenario' from: aThenAstNode start to: aThenAstNode end ].
	self checkStepDefinitionFor: aThenAstNode
]

{ #category : 'visiting' }
HeraLinter >> visitWhenAstNode: aWhenAstNode [

	self checkColonAfterKeyword: aWhenAstNode.
	self checkStepDefinitionFor: aWhenAstNode
]

{ #category : 'private' }
HeraLinter >> warn: aString from: sourceStartIndex to: sourceEndIndex [

	| warning |
	warning := HeraLintWarning new
		message: aString;
		start: sourceStartIndex;
		end: sourceEndIndex.
	warnings add: warning
]

{ #category : 'private' }
HeraLinter >> warnMissingStepDefinitionFrom: sourceStartIndex to: sourceEndIndex [

	| warning |
	warning := HeraLintMissingStepDefinitionWarning new
		message: 'This step has no definition';
		start: sourceStartIndex;
		end: sourceEndIndex.
	warnings add: warning
]

{ #category : 'accessing' }
HeraLinter >> warnings [

	^ warnings
]
