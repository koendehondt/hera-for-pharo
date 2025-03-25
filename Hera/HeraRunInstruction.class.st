Class {
	#name : 'HeraRunInstruction',
	#superclass : 'Object',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'comparing' }
HeraRunInstruction >> = other [

	^ self class = other class
]

{ #category : 'testing' }
HeraRunInstruction >> canBeStepped [

	^ true
]

{ #category : 'testing' }
HeraRunInstruction >> isScenarioEnd [

	^ false
]

{ #category : 'performing' }
HeraRunInstruction >> performFor: aScriptRunner [

	self subclassResponsibility
]
