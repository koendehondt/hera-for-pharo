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
		'currentAstNodeWithSteps',
		'currentScenarioOutlineAstNode',
		'currentScenarioAstNode',
		'scenarioTitles',
		'currentRuleAstNode',
		'ruleTitles'
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

	(self stepDefinitionExists: aStepAstNode) ifTrue: [ ^ self ].
	self warnMissingStepDefinitionFrom: aStepAstNode start to: aStepAstNode end
]

{ #category : 'private' }
HeraLinter >> checkStepParametersFor: aStepAstNode [

	| parametersInDataTable parametersInStep unboundParametersInStep message |
	currentScenarioAstNode ifNotNil: [
		(HeraParameterizedString new string: aStepAstNode description) hasParameters ifTrue: [
			self warn: 'Parameters in steps are only allowed in a scenario outline' from: aStepAstNode start to: aStepAstNode end ] ].
	currentScenarioOutlineAstNode ifNil: [ ^ self ].
	currentScenarioOutlineAstNode examples ifNotNil: [ :examples|
		examples examplesDataTable ifNotNil: [ :examplesDataTable |
			examplesDataTable dataTable ifNotNil: [ :dataTable |
				dataTable isEmpty ifFalse: [
					parametersInDataTable := dataTable columnHeaders asSet.
					parametersInStep := (HeraParameterizedString new string: aStepAstNode description) parameters.
					unboundParametersInStep := parametersInStep difference: parametersInDataTable.
					unboundParametersInStep ifNotEmpty: [
						message := 'This step includes unbound parameters: {1}.' format: { unboundParametersInStep heraSorted asCommaSeparatedDoubleQuotedStrings }.
						self warn: message from: aStepAstNode start to: aStepAstNode end ] ] ] ] ]
]

{ #category : 'private' }
HeraLinter >> isImplicitlyDefinedStep: stepDescription [

	^ stepDescription = 'I pause'
]

{ #category : 'linting' }
HeraLinter >> lint: anAstNode [

	warnings := OrderedCollection new.
	scenarioTitles := Set new.
	ruleTitles := Set new.
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
HeraLinter >> stepDefinitionExists: aStepAstNode [

	(self isImplicitlyDefinedStep: aStepAstNode description) ifTrue: [ ^ true ].
	^ (acceptanceTest methodFor: aStepAstNode in: currentScenarioOutlineAstNode) isNotNil
]

{ #category : 'visiting' }
HeraLinter >> visitAndAstNode: anAndAstNode [

	self checkColonAfterKeyword: anAndAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'An And step should not be the first step in a scenario' from: anAndAstNode start to: anAndAstNode end ].
	self checkStepDefinitionFor: anAndAstNode.
	self checkStepParametersFor: anAndAstNode.
	anAndAstNode argument ifNotNil: [ :argument | self visit: argument ]
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
	self checkStepDefinitionFor: aButAstNode.
	self checkStepParametersFor: aButAstNode.
	aButAstNode argument ifNotNil: [ :argument | self visit: argument ]
]

{ #category : 'visiting' }
HeraLinter >> visitDataTableStepArgumentAstNode: aDataTableStepArgumentAstNode [

	currentScenarioAstNode ifNil: [ ^ self ].
	aDataTableStepArgumentAstNode hasParameters ifFalse: [ ^ self ].
	self warn: 'Parameters are only allowed in data tables of a scenario outline' from: aDataTableStepArgumentAstNode start to: aDataTableStepArgumentAstNode end
]

{ #category : 'visiting' }
HeraLinter >> visitDataTreeStepArgumentAstNode: aDataTreeStepArgumentAstNode [

	currentScenarioAstNode ifNil: [ ^ self ].
	aDataTreeStepArgumentAstNode hasParameters ifFalse: [ ^ self ].
	self warn: 'Parameters are only allowed in data trees of a scenario outline' from: aDataTreeStepArgumentAstNode start to: aDataTreeStepArgumentAstNode end
]

{ #category : 'visiting' }
HeraLinter >> visitDocStringStepArgumentAstNode: aDocStringStepArgumentAstNode [

	currentScenarioAstNode ifNil: [ ^ self ].
	aDocStringStepArgumentAstNode hasParameters ifFalse: [ ^ self ].
	self warn: 'Parameters are only allowed in doc strings of a scenario outline' from: aDocStringStepArgumentAstNode start to: aDocStringStepArgumentAstNode end
]

{ #category : 'visiting' }
HeraLinter >> visitExamplesAstNode: anExamplesAstNode [

	anExamplesAstNode examplesDataTable dataTable isEmpty
		ifTrue: [ self warn: 'A scenario outline should have at least one example' from: anExamplesAstNode start to: anExamplesAstNode end ]
		ifFalse: [ (self visit: anExamplesAstNode examplesDataTable) ifNotNil: [ :dataTable | ^ dataTable ] ]
]

{ #category : 'visiting' }
HeraLinter >> visitExamplesDataTableAstNode: anExamplesDataTableAstNode [

	| parametersInDataTable usedParameters unusedParametersInDataTable message |
	parametersInDataTable := anExamplesDataTableAstNode dataTable columnHeaders asSet.
	usedParameters := currentScenarioOutlineAstNode steps flatCollect: [ :step | step parameters ] as: Set.
	unusedParametersInDataTable := parametersInDataTable difference: usedParameters.
	unusedParametersInDataTable ifNotEmpty: [
		message := 'The examples include unused parameters: {1}.' format: { unusedParametersInDataTable heraSorted asCommaSeparatedDoubleQuotedStrings }.
		self warn: message from: anExamplesDataTableAstNode start to: anExamplesDataTableAstNode end ]
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
	self checkStepDefinitionFor: aGivenAstNode.
	self checkStepParametersFor: aGivenAstNode.
	aGivenAstNode argument ifNotNil: [ :argument | self visit: argument ]
]

{ #category : 'visiting' }
HeraLinter >> visitRuleAstNode: aRuleAstNode [

	currentRuleAstNode := aRuleAstNode.
	self visitTitleAstNode: aRuleAstNode title.
	aRuleAstNode background ifNotNil: [ :background | self visit: background ].
	aRuleAstNode scenarios do: [ :each | self visit: each ].
	currentRuleAstNode := nil
]

{ #category : 'visiting' }
HeraLinter >> visitScenarioAstNode: aScenarioAstNode [

	currentAstNodeWithSteps := aScenarioAstNode.
	currentScenarioAstNode := aScenarioAstNode.
	self visitTitleAstNode: aScenarioAstNode title.
	aScenarioAstNode steps withIndexDo: [ :stepNode :stepIndex |
		currentStepIndex := stepIndex.
		self visit: stepNode ].
	currentScenarioAstNode := nil
]

{ #category : 'visiting' }
HeraLinter >> visitScenarioOutlineAstNode: aScenarioOutlineAstNode [

	currentAstNodeWithSteps := aScenarioOutlineAstNode.
	currentScenarioOutlineAstNode := aScenarioOutlineAstNode.
	self visitTitleAstNode: aScenarioOutlineAstNode title.
	aScenarioOutlineAstNode steps withIndexDo: [ :stepNode :stepIndex |
		currentStepIndex := stepIndex.
		self visit: stepNode ].
	aScenarioOutlineAstNode examples
		ifNil: [ self warn: 'A scenario outline should have an Examples section' from: aScenarioOutlineAstNode start to: aScenarioOutlineAstNode title end ]
		ifNotNil: [ :examples | self visit: examples ].
	currentScenarioOutlineAstNode := nil
]

{ #category : 'visiting' }
HeraLinter >> visitStarAstNode: aStarAstNode [

	currentStepIndex = 1 ifTrue: [
		self warn: 'A * step should not be the first step in a scenario' from: aStarAstNode start to: aStarAstNode end ].
	self checkStepDefinitionFor: aStarAstNode.
	self checkStepParametersFor: aStarAstNode.
	aStarAstNode argument ifNotNil: [ :argument | self visit: argument ]
]

{ #category : 'visiting' }
HeraLinter >> visitThenAstNode: aThenAstNode [

	self checkColonAfterKeyword: aThenAstNode.
	currentStepIndex = 1 ifTrue: [
		self warn: 'A Then step should not be the first step in a scenario' from: aThenAstNode start to: aThenAstNode end ].
	self checkStepDefinitionFor: aThenAstNode.
	self checkStepParametersFor: aThenAstNode.
	aThenAstNode argument ifNotNil: [ :argument | self visit: argument ]
]

{ #category : 'visiting' }
HeraLinter >> visitTitleAstNode: aTitleAstNode [

	| title |
	title := aTitleAstNode text.
	title first isUppercase ifFalse: [
		self warn: 'A title should start with an uppercase letter' from: aTitleAstNode start to: aTitleAstNode end ].
	currentScenarioAstNode ifNotNil: [
		(HeraParameterizedString new string: title) hasParameters ifTrue: [
			self warn: 'Parameters are only allowed in the title of a scenario outline' from: aTitleAstNode start to: aTitleAstNode end ] ].
	(currentScenarioAstNode isNotNil or: [ currentScenarioOutlineAstNode isNotNil ]) ifTrue: [
		(scenarioTitles includes: title) ifTrue: [
			self warn: 'This scenario has the same title as a previous one.' from: aTitleAstNode start to: aTitleAstNode end ].
		scenarioTitles add: title ].
	currentRuleAstNode ifNotNil: [
		(ruleTitles includes: title) ifTrue: [
			self warn: 'This rule has the same title as a previous one.' from: aTitleAstNode start to: aTitleAstNode end ].
		ruleTitles add: title ]
]

{ #category : 'visiting' }
HeraLinter >> visitWhenAstNode: aWhenAstNode [

	self checkColonAfterKeyword: aWhenAstNode.
	self checkStepDefinitionFor: aWhenAstNode.
	self checkStepParametersFor: aWhenAstNode.
	aWhenAstNode argument ifNotNil: [ :argument | self visit: argument ]
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
