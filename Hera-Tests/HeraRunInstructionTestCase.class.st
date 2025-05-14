Class {
	#name : 'HeraRunInstructionTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Instructions',
	#package : 'Hera-Tests',
	#tag : 'Instructions'
}

{ #category : 'running' }
HeraRunInstructionTestCase >> describedClass [

	^ HeraRunInstruction
]

{ #category : 'tests' }
HeraRunInstructionTestCase >> testCanBeStepped [

	| stepableInstructionClasses unsteppableInstructionClasses |
	unsteppableInstructionClasses := { 
		HeraEndFeatureInstruction .
		HeraEndRuleInstruction .
		HeraEndScenarioInstruction .
		HeraBeforeScenarioHookInstruction .
		HeraAfterScenarioHookInstruction .
		HeraResultSummaryInstruction }.
	unsteppableInstructionClasses do: [ :each | self deny: each new canBeStepped ].
	stepableInstructionClasses := self describedClass allSubclasses removeAll: unsteppableInstructionClasses; yourself.
	stepableInstructionClasses := stepableInstructionClasses reject: [ :each | each isAbstract ].
	stepableInstructionClasses do: [ :each | self assert: each new canBeStepped ].
]
