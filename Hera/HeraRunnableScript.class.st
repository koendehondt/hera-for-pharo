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

{ #category : 'building' }
HeraRunnableScript >> addInstructionsForScenarios: scenarios of: aRuleOrFeature to: instructionCollection [

	scenarios do: [ :eachScenario |
		totalScenarioCount := totalScenarioCount + 1.
		instructionCollection add: (HeraStartScenarioInstruction for: eachScenario).
		instructionCollection add: HeraBeforeScenarioHookInstruction new.
		aRuleOrFeature background ifNotNil: [ :background |
			background steps do: [ :eachStep | | stepInstruction backgroundStepInstruction |
				stepInstruction := self instructionForStep: eachStep.
				backgroundStepInstruction := HeraBackgroundStepInstruction new stepInstruction: stepInstruction.
				instructionCollection add: backgroundStepInstruction ] ].
		eachScenario steps do: [ :eachStep |
			instructionCollection add: (self instructionForStep: eachStep) ].
		instructionCollection add: HeraAfterScenarioHookInstruction new.
		instructionCollection add: HeraEndScenarioInstruction new ]
]

{ #category : 'testing' }
HeraRunnableScript >> atEndOfScenario [

	^ self peekNextInstruction isScenarioEnd
]

{ #category : 'building' }
HeraRunnableScript >> featureInstructionsFor: feature [

	| featureInstructions filteredScenarios |
	featureInstructions := OrderedCollection new.
	filteredScenarios := feature scenariosWithResolvedParameters select: [ :each | filter selects: each ].
	filteredScenarios ifNotEmpty: [
		feature background ifNotNil: [ :background |
			featureInstructions add: (HeraBackgroundInstruction new background: background) ].
		self addInstructionsForScenarios: filteredScenarios of: feature to: featureInstructions ].
	feature rules do: [ :eachRule |
		filteredScenarios := eachRule scenarios select: [ :each | filter selects: each ].
		filteredScenarios ifNotEmpty: [
			featureInstructions add: (HeraStartRuleInstruction for: eachRule).
			eachRule background ifNotNil: [ :background |
				featureInstructions add: (HeraBackgroundInstruction new background: background) ].
			self addInstructionsForScenarios: filteredScenarios of: eachRule to: featureInstructions.
			featureInstructions add: HeraEndRuleInstruction new ] ].
		^ featureInstructions
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

{ #category : 'building' }
HeraRunnableScript >> initializeInstructions [

	| featureCount  |
	instructions := OrderedCollection new.
	instructions add: (HeraStartFeaturesInstruction for: acceptanceTests size).
	featureCount := 0.
	acceptanceTests do: [ :acceptanceTest |
		(self featureInstructionsFor: acceptanceTest feature) ifNotEmpty: [ :featureInstructions |
			featureCount := featureCount + 1.
			instructions
				add: (HeraStartFeatureInstruction for: acceptanceTest);
				addAll: featureInstructions;
				add: HeraEndFeatureInstruction new ] ] .
	instructions add: HeraEndFeaturesInstruction new.
	instructions add: HeraResultSummaryInstruction new.
	instructions first featureCount: featureCount.
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
