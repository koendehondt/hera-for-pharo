Class {
	#name : 'HeraAstVisitor',
	#superclass : 'Object',
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'private - visiting' }
HeraAstVisitor >> default: anAstNode [

	"Do nothing. Subclasses should override."
	^ nil
]

{ #category : 'visiting' }
HeraAstVisitor >> visit: anAstNode [

	^ anAstNode accept: self
]

{ #category : 'visiting' }
HeraAstVisitor >> visitAndAstNode: anAndAstNode [

	^ self visitStepAstNode: anAndAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitBackgroundAstNode: aBackgroundAstNode [

	^ self default: aBackgroundAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitButAstNode: aButAstNode [

	^ self visitStepAstNode: aButAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitDataTableStepArgumentAstNode: aDataTableStepArgumentAstNode [

	^ self default: aDataTableStepArgumentAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitDataTreeStepArgumentAstNode: aDataTreeStepArgumentAstNode [

	^ self default: aDataTreeStepArgumentAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitDescriptionAstNode: aDescriptionAstNode [

	^ self default: aDescriptionAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitDocStringStepArgumentAstNode: aDocStringStepArgumentAstNode [

	^ self default: aDocStringStepArgumentAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitFeatureAstNode: aFeatureAstNode [

	^ self default: aFeatureAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitGivenAstNode: aGivenAstNode [

	^ self visitStepAstNode: aGivenAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitRuleAstNode: aRuleAstNode [

	^ self default: aRuleAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitScenarioAstNode: aScenarioAstNode [

	^ self default: aScenarioAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitStarAstNode: aStarAstNode [

	^ self visitStepAstNode: aStarAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitStepAstNode: aStepAstNode [

	^ self default: aStepAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitTagAstNode: aTagAstNode [

	^ self default: aTagAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitThenAstNode: aThenAstNode [

	^ self visitStepAstNode: aThenAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitTitleAstNode: aTitleAstNode [

	^ self default: aTitleAstNode
]

{ #category : 'visiting' }
HeraAstVisitor >> visitWhenAstNode: aWhenAstNode [

	^ self visitStepAstNode: aWhenAstNode
]
