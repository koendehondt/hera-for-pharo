Class {
	#name : 'HeraHookInstruction',
	#superclass : 'HeraRunInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'testing' }
HeraHookInstruction class >> isAbstract [

	^ true
]

{ #category : 'testing' }
HeraHookInstruction >> canBeStepped [

	^ false
]
