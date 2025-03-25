Class {
	#name : 'HeraRunnableScript',
	#superclass : 'Object',
	#instVars : [
		'feature',
		'instructions',
		'instructionPointer'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'instance creation' }
HeraRunnableScript class >> for: aFeature [

	^ self new feature: aFeature
]

{ #category : 'testing' }
HeraRunnableScript >> atEndOfScenario [

	^ self peekNextInstruction isScenarioEnd
]

{ #category : 'initialization' }
HeraRunnableScript >> feature: aFeature [

	feature := aFeature.
	instructionPointer := 0
]

{ #category : 'testing' }
HeraRunnableScript >> hasMoreInstructions [

	^ instructionPointer < self instructions size
]

{ #category : 'initialization' }
HeraRunnableScript >> initializeInstructions [

	instructions := OrderedCollection new.
	instructions add: (HeraStartFeatureInstruction for: feature).
	feature background ifNotNil: [ :background |
		instructions add: (HeraBackgroundInstruction new background: background) ].
	feature scenarios do: [ :eachScenario |
		instructions add: (HeraStartScenarioInstruction for: eachScenario).
		instructions add: HeraBeforeScenarioHookInstruction new.
		feature background ifNotNil: [ :background |
			background steps do: [ :eachStep | | stepInstruction backgroundStepInstruction |
				stepInstruction := self instructionForStep: eachStep.
				backgroundStepInstruction := HeraBackgroundStepInstruction new stepInstruction: stepInstruction.
				instructions add: backgroundStepInstruction ] ].
		eachScenario steps do: [ :eachStep |
			instructions add: (self instructionForStep: eachStep) ].
		instructions add: HeraAfterScenarioHookInstruction new.
		instructions add: HeraEndScenarioInstruction new. ].
	instructions add: HeraEndFeatureInstruction new.
	instructions add: HeraResultSummaryInstruction new.
	^ instructions
]

{ #category : 'private' }
HeraRunnableScript >> instructionForStep: aStep [

	aStep description = 'I pause' ifTrue: [ ^ HeraPauseInstruction for: aStep ].
	^ HeraRunStepInstruction for: aStep
]

{ #category : 'accessing' }
HeraRunnableScript >> instructions [

	^ instructions ifNil: [ self initializeInstructions ]
]

{ #category : 'performing' }
HeraRunnableScript >> nextInstruction [

	instructionPointer := instructionPointer + 1.
	^ self instructions at: instructionPointer
]

{ #category : 'testing' }
HeraRunnableScript >> nextInstructionCannotBeStepped [

	^ self peekNextInstruction canBeStepped not
]

{ #category : 'performing' }
HeraRunnableScript >> peekNextInstruction [

	^ self instructions at: instructionPointer + 1 ifAbsent: [ ^ nil ]
]

{ #category : 'performing' }
HeraRunnableScript >> performNextFor: aRunner [

	self nextInstruction performFor: aRunner
]
