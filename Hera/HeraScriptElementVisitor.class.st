Class {
	#name : 'HeraScriptElementVisitor',
	#superclass : 'Object',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraScriptElementVisitor >> visit: heraObject [

	heraObject accept: self
]

{ #category : 'visiting' }
HeraScriptElementVisitor >> visitAndStep: anAndStep [

	self subclassResponsibility
]

{ #category : 'visiting' }
HeraScriptElementVisitor >> visitBackground: aBackground [

	self subclassResponsibility
]

{ #category : 'visiting' }
HeraScriptElementVisitor >> visitButStep: anButStep [

	self subclassResponsibility
]

{ #category : 'visiting' }
HeraScriptElementVisitor >> visitFeature: aFeature [

	self subclassResponsibility
]

{ #category : 'visiting' }
HeraScriptElementVisitor >> visitGivenStep: aGivenStep [

	self subclassResponsibility
]

{ #category : 'visiting' }
HeraScriptElementVisitor >> visitScenario: aScenario [

	self subclassResponsibility
]

{ #category : 'visiting' }
HeraScriptElementVisitor >> visitThenStep: aThenStep [

	self subclassResponsibility
]

{ #category : 'visiting' }
HeraScriptElementVisitor >> visitWhenStep: aWhenStep [

	self subclassResponsibility
]
