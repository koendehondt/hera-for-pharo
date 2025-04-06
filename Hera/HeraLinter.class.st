Class {
	#name : 'HeraLinter',
	#superclass : 'HeraAstVisitor',
	#instVars : [
		'warnings',
		'currentScenarioAstNode',
		'currentStepIndex'
	],
	#category : 'Hera-Linter',
	#package : 'Hera',
	#tag : 'Linter'
}

{ #category : 'private' }
HeraLinter >> checkColonAfterKeyword: aStepAstNode [

	aStepAstNode description first = $: ifTrue: [
		self warn: 'A colon after a step keyword is not necessary' from: aStepAstNode start to: aStepAstNode end ]
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
	steps := currentScenarioAstNode steps.
	^ (1 to: currentStepIndex - 1) allSatisfy: [ :index |
		(steps at: index) isGivenStepNode ]
]

{ #category : 'visiting' }
HeraLinter >> visitAndAstNode: anAndAstNode [

	self checkColonAfterKeyword: anAndAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'An And step should not be the first step in a scenario' from: anAndAstNode start to: anAndAstNode end ]
]

{ #category : 'visiting' }
HeraLinter >> visitButAstNode: aButAstNode [

	self checkColonAfterKeyword: aButAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'A But step should not be the first step in a scenario' from: aButAstNode start to: aButAstNode end ]
]

{ #category : 'visiting' }
HeraLinter >> visitFeatureAstNode: aFeatureAstNode [

	aFeatureAstNode name first isUppercase ifFalse: [
			self warn: 'A feature name should start with an uppercase letter' from: aFeatureAstNode start to: aFeatureAstNode start + 'Feature: ' size + aFeatureAstNode name size - 1 ].
	aFeatureAstNode scenarios do: [ :each | self visit: each ]
]

{ #category : 'visiting' }
HeraLinter >> visitGivenAstNode: aGivenAstNode [

	self checkColonAfterKeyword: aGivenAstNode.
	self previousStepsAreAllGivenSteps ifFalse: [
		self warn: 'A Given step should come before any other step' from: aGivenAstNode start to: aGivenAstNode end ]
]

{ #category : 'visiting' }
HeraLinter >> visitScenarioAstNode: aScenarioAstNode [

	currentScenarioAstNode := aScenarioAstNode.
	aScenarioAstNode title first isUppercase
		ifFalse: [ self warn: 'A scenario title should start with an uppercase letter' from: aScenarioAstNode start to: aScenarioAstNode start + 'Scenario: ' size + aScenarioAstNode title size - 1 ].
	aScenarioAstNode steps withIndexDo: [ :stepNode :stepIndex |
		currentStepIndex := stepIndex.
		self visit: stepNode ]
]

{ #category : 'visiting' }
HeraLinter >> visitThenAstNode: aThenAstNode [

	self checkColonAfterKeyword: aThenAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'A Then step should not be the first step in a scenario' from: aThenAstNode start to: aThenAstNode end ]
]

{ #category : 'visiting' }
HeraLinter >> visitWhenAstNode: aWhenAstNode [

	self checkColonAfterKeyword: aWhenAstNode
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

{ #category : 'accessing' }
HeraLinter >> warnings [

	^ warnings
]
