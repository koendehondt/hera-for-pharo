Class {
	#name : 'HeraAstTextBasedSearchVisitor',
	#superclass : 'HeraAstVisitor',
	#instVars : [
		'textPosition'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'private - visiting' }
HeraAstTextBasedSearchVisitor >> default: anAstNode [

	(anAstNode isLocatedAtTextPosition: textPosition) ifTrue: [ ^ anAstNode ].
	^ nil
]

{ #category : 'initialization' }
HeraAstTextBasedSearchVisitor >> textPosition: anInteger [

	textPosition := anInteger
]

{ #category : 'visiting' }
HeraAstTextBasedSearchVisitor >> visitFeatureAstNode: aFeatureAstNode [

	aFeatureAstNode tags do: [ :each |
		(self visit: each) ifNotNil: [ :tagNode | ^ tagNode ] ].
	aFeatureAstNode description ifNotNil: [ :description |
		(self visit: description) ifNotNil: [ :descriptionNode | ^ descriptionNode ] ].
	aFeatureAstNode scenarios do: [ :each |
		(self visit: each) ifNotNil: [ :scenarioNode | ^ scenarioNode ] ].
	^ super visitFeatureAstNode: aFeatureAstNode
]

{ #category : 'visiting' }
HeraAstTextBasedSearchVisitor >> visitScenarioAstNode: aScenarioAstNode [

	aScenarioAstNode tags do: [ :each |
		(self visit: each) ifNotNil: [ :tagNode | ^ tagNode ] ].
	aScenarioAstNode description ifNotNil: [ :description |
		(self visit: description) ifNotNil: [ :descriptionNode | ^ descriptionNode ] ].
	aScenarioAstNode steps do: [ :each |
		(self visit: each) ifNotNil: [ :stepNode | ^ stepNode ] ].
	^ super visitScenarioAstNode: aScenarioAstNode
]
