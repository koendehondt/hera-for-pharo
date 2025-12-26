Class {
	#name : 'HeraRunnableScript',
	#superclass : 'Object',
	#instVars : [
		'instructions',
		'instructionPointer',
		'filter',
		'acceptanceTests',
		'totalScenarioCount'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'instance creation' }
HeraRunnableScript class >> forAll: acceptanceTests [

	^ self new acceptanceTests: acceptanceTests
]

{ #category : 'initialization' }
HeraRunnableScript >> acceptanceTests: acceptanceTestsCollection [

	acceptanceTests := acceptanceTestsCollection.
	instructionPointer := 0
]

{ #category : 'testing' }
HeraRunnableScript >> atEndOfScenario [

	^ self peekNextInstruction isScenarioEnd
]

{ #category : 'accessing' }
HeraRunnableScript >> filter [

	^ filter
]

{ #category : 'initialization' }
HeraRunnableScript >> filter: aFilter [

	filter := aFilter
]

{ #category : 'testing' }
HeraRunnableScript >> hasMoreInstructions [

	^ instructionPointer < self instructions size
]

{ #category : 'initialization' }
HeraRunnableScript >> initialize [

	super initialize.
	filter := HeraNoFilter new.
	totalScenarioCount := 0
]

{ #category : 'initialization' }
HeraRunnableScript >> initializeInstructions [

	| filteredScenarios |
	instructions := OrderedCollection new.
	instructions add: (HeraStartFeaturesInstruction for: acceptanceTests size).
	totalScenarioCount := 0.
	acceptanceTests do: [ :acceptanceTest | | feature |
		feature := acceptanceTest feature.
		instructions add: (HeraStartFeatureInstruction for: acceptanceTest).
		feature background ifNotNil: [ :background |
			instructions add: (HeraBackgroundInstruction new background: background) ].
		filteredScenarios := feature scenariosWithResolvedParameters select: [ :each | filter selects: each ].
		filteredScenarios do: [ :eachScenario |
			totalScenarioCount := totalScenarioCount + 1.
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
			instructions add: HeraEndScenarioInstruction new ].
		feature rules do: [ :eachRule |
			filteredScenarios := eachRule scenarios select: [ :each | filter selects: each ].
			filteredScenarios ifNotEmpty: [
				instructions add: (HeraStartRuleInstruction for: eachRule).
				eachRule background ifNotNil: [ :background |
					instructions add: (HeraBackgroundInstruction new background: background) ] ].
			filteredScenarios do: [ :eachScenario |
				instructions add: (HeraStartScenarioInstruction for: eachScenario).
				instructions add: HeraBeforeScenarioHookInstruction new.
				eachRule background ifNotNil: [ :background |
					background steps do: [ :eachStep | | stepInstruction backgroundStepInstruction |
						stepInstruction := self instructionForStep: eachStep.
						backgroundStepInstruction := HeraBackgroundStepInstruction new stepInstruction: stepInstruction. self flag: 'This uses the feature background'.
						instructions add: backgroundStepInstruction ] ].
				eachScenario steps do: [ :eachStep |
					instructions add: (self instructionForStep: eachStep) ].
				instructions add: HeraAfterScenarioHookInstruction new.
				instructions add: HeraEndScenarioInstruction new ].
			filteredScenarios ifNotEmpty: [ instructions add: HeraEndRuleInstruction new ] ].
		instructions add: HeraEndFeatureInstruction new ].
	instructions add: HeraEndFeaturesInstruction new.
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

{ #category : 'accessing' }
HeraRunnableScript >> totalScenarioCount [

	^ totalScenarioCount
]
