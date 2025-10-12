Class {
	#name : 'HeraTextBasedAstSearcher',
	#superclass : 'HeraAstVisitor',
	#instVars : [
		'textPosition',
		'searchTarget'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'initialization' }
HeraTextBasedAstSearcher >> beForSearchingScenario [

	searchTarget := #scenario
]

{ #category : 'initialization' }
HeraTextBasedAstSearcher >> beForSearchingStep [

	searchTarget := #step
]

{ #category : 'private - visiting' }
HeraTextBasedAstSearcher >> default: anAstNode [

	(anAstNode isLocatedAtTextPosition: textPosition) ifTrue: [ ^ anAstNode ].
	^ nil
]

{ #category : 'initialization' }
HeraTextBasedAstSearcher >> textPosition: anInteger [

	textPosition := anInteger
]

{ #category : 'visiting' }
HeraTextBasedAstSearcher >> visitBackgroundAstNode: aBackgroundAstNode [

	aBackgroundAstNode steps do: [ :each |
		(self visit: each) ifNotNil: [ :stepNode | ^ stepNode ] ].
	^ super visitBackgroundAstNode: aBackgroundAstNode
]

{ #category : 'visiting' }
HeraTextBasedAstSearcher >> visitFeatureAstNode: aFeatureAstNode [

	aFeatureAstNode tags do: [ :each |
		(self visit: each) ifNotNil: [ :tagNode | ^ tagNode ] ].
	(self visit: aFeatureAstNode title) ifNotNil: [ :titleNode | ^ titleNode ].
	aFeatureAstNode description ifNotNil: [ :description |
		(self visit: description) ifNotNil: [ :descriptionNode | ^ descriptionNode ] ].
	aFeatureAstNode background ifNotNil: [ :background |
		(self visit: background) ifNotNil: [ :backgroundNode | ^ backgroundNode ] ].
	aFeatureAstNode scenarios do: [ :each |
		(self visit: each) ifNotNil: [ :scenarioNode | ^ scenarioNode ] ].
	aFeatureAstNode rules do: [ :each |
		(self visit: each) ifNotNil: [ :ruleNode | ^ ruleNode ] ].
	^ super visitFeatureAstNode: aFeatureAstNode
]

{ #category : 'visiting' }
HeraTextBasedAstSearcher >> visitRuleAstNode: aRuleAstNode [

	aRuleAstNode description ifNotNil: [ :description |
		(self visit: description) ifNotNil: [ :descriptionNode | ^ descriptionNode ] ].
	aRuleAstNode background ifNotNil: [ :background |
		(self visit: background) ifNotNil: [ :backgroundNode | ^ backgroundNode ] ].
	aRuleAstNode scenarios do: [ :each |
		(self visit: each) ifNotNil: [ :scenarioNode | ^ scenarioNode ] ].
	^ super visitRuleAstNode: aRuleAstNode
]

{ #category : 'visiting' }
HeraTextBasedAstSearcher >> visitScenarioAstNode: aScenarioAstNode [

	(searchTarget = #scenario and: [ aScenarioAstNode isLocatedAtTextPosition: textPosition ]) ifTrue: [ ^ aScenarioAstNode ].
	aScenarioAstNode tags do: [ :each |
		(self visit: each) ifNotNil: [ :tagNode | ^ searchTarget = #scenario ifTrue: [ aScenarioAstNode ] ifFalse: [ tagNode ] ] ].
	(self visit: aScenarioAstNode title) ifNotNil: [ :titleNode | ^ titleNode ].
	aScenarioAstNode description ifNotNil: [ :description |
		(self visit: description) ifNotNil: [ :descriptionNode | ^ descriptionNode ] ].
	aScenarioAstNode steps do: [ :each |
		(self visit: each) ifNotNil: [ :stepNode | ^ stepNode ] ].
	^ super visitScenarioAstNode: aScenarioAstNode
]

{ #category : 'visiting' }
HeraTextBasedAstSearcher >> visitStepAstNode: aStepAstNode [

	(searchTarget = #step and: [ aStepAstNode isLocatedAtTextPosition: textPosition ]) ifTrue: [ ^ aStepAstNode ].
	^ super visitStepAstNode: aStepAstNode
]
