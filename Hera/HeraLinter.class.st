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

{ #category : 'private' }
HeraLinter >> isImplicitlyDefinedStep: stepDescription [

	^ stepDescription = 'I pause'
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

	(self isImplicitlyDefinedStep: stepDescription) ifTrue: [ ^ true ].
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

	self visitTitleAstNode: aFeatureAstNode title.
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

	currentAstNodeWithSteps := aScenarioAstNode.
	self visitTitleAstNode: aScenarioAstNode title.
	aScenarioAstNode steps withIndexDo: [ :stepNode :stepIndex |
		currentStepIndex := stepIndex.
		self visit: stepNode ]
]

{ #category : 'visiting' }
HeraLinter >> visitStarAstNode: aStarAstNode [

	currentStepIndex = 1 ifTrue: [
		self warn: 'A * step should not be the first step in a scenario' from: aStarAstNode start to: aStarAstNode end ].
	self checkStepDefinitionFor: aStarAstNode
]

{ #category : 'visiting' }
HeraLinter >> visitThenAstNode: aThenAstNode [

	self checkColonAfterKeyword: aThenAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'A Then step should not be the first step in a scenario' from: aThenAstNode start to: aThenAstNode end ].
	self checkStepDefinitionFor: aThenAstNode
]

{ #category : 'visiting' }
HeraLinter >> visitTitleAstNode: aTitleAstNode [

	aTitleAstNode text first isUppercase ifTrue: [ ^ self ].
	self warn: 'A title should start with an uppercase letter' from: aTitleAstNode start to: aTitleAstNode end
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
