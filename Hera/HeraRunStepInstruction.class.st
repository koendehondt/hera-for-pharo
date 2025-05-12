Class {
	#name : 'HeraRunStepInstruction',
	#superclass : 'HeraRunInstruction',
	#instVars : [
		'step'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'instance creation' }
HeraRunStepInstruction class >> for: aStep [

	^ self new step: aStep
]

{ #category : 'comparing' }
HeraRunStepInstruction >> = other [

	^ super = other and: [ self step = other step ]
]

{ #category : 'performing' }
HeraRunStepInstruction >> performFor: aScriptRunner [

	aScriptRunner runStep: self step
]

{ #category : 'performing' }
HeraRunStepInstruction >> performFromBackgroundFor: aScriptRunner [

	aScriptRunner runBackgroundStep: self step
]

{ #category : 'accessing' }
HeraRunStepInstruction >> step [

	^ step
]

{ #category : 'accessing' }
HeraRunStepInstruction >> step: aStep [

	step := aStep
]
