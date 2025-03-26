Class {
	#name : 'HeraScriptRunner',
	#superclass : 'Object',
	#instVars : [
		'reporter',
		'filter',
		'result',
		'acceptanceTest',
		'isDebugging',
		'currentScenario',
		'currentScenarioPassed',
		'currentFeature',
		'hasRunSteps',
		'runnableScript',
		'paused',
		'scenarioCount'
	],
	#category : 'Hera-Running',
	#package : 'Hera',
	#tag : 'Running'
}

{ #category : 'accessing' }
HeraScriptRunner >> acceptanceTest: anAcceptanceTest [

	acceptanceTest := anAcceptanceTest
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> afterScenarioHook [

	acceptanceTest afterScenario
]

{ #category : 'private - running' }
HeraScriptRunner >> basicRunStep: aStep [

	aStep runIn: acceptanceTest.
	reporter reportPassedStep: aStep
]

{ #category : 'accessing' }
HeraScriptRunner >> beForDebugging [

	isDebugging := true
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> beforeScenarioHook [

	acceptanceTest beforeScenario
]

{ #category : 'running' }
HeraScriptRunner >> continue [

	paused := false.
	[ runnableScript hasMoreInstructions and: [ paused not ] ] whileTrue: [
		runnableScript performNextFor: self ]
]

{ #category : 'running' }
HeraScriptRunner >> debug [

	self isDebugging: true.
	^ self run
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> endFeature [

	result recordEndTime.
	self hasRunScenarios ifFalse: [
		result recordEmptyFeature: currentFeature.
		reporter reportEmptyFeature: currentFeature ].
	reporter reportEndOfFeature: currentFeature
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> endScenario [

	self hasRunSteps
		ifTrue: [
			currentScenarioPassed ifTrue: [ result recordPassedScenario: currentScenario ] ]
		ifFalse: [
			result recordEmptyScenario: currentScenario.
			reporter reportEmptyScenario: currentScenario ].
	reporter reportEndOfScenario: currentScenario.
	scenarioCount := scenarioCount + 1.
	currentScenario := nil
]

{ #category : 'private - running' }
HeraScriptRunner >> errorClass [

	^ Error
]

{ #category : 'private - running' }
HeraScriptRunner >> failureClass [

	^ HeraFailure
]

{ #category : 'accessing' }
HeraScriptRunner >> filter: aFilter [

	filter := aFilter
]

{ #category : 'testing' }
HeraScriptRunner >> hasRunAllScenarios [

	^ runnableScript hasMoreInstructions not
]

{ #category : 'testing' }
HeraScriptRunner >> hasRunScenarios [

	^ scenarioCount > 0
]

{ #category : 'testing' }
HeraScriptRunner >> hasRunSteps [

	^ hasRunSteps
]

{ #category : 'initialization' }
HeraScriptRunner >> initialize [

	super initialize.
	isDebugging := false.
	hasRunSteps := false.
	scenarioCount := 0.
	self filter: HeraNoFilter new.
	self reporter: HeraNoReporter new
]

{ #category : 'accessing' }
HeraScriptRunner >> isDebugging [

	^ isDebugging
]

{ #category : 'accessing' }
HeraScriptRunner >> isDebugging: aBoolean [

	isDebugging := aBoolean
]

{ #category : 'testing' }
HeraScriptRunner >> isRunningScenario [

	^ currentScenario isNotNil
]

{ #category : 'private - running' }
HeraScriptRunner >> newResult [

	^ HeraResult new
]

{ #category : 'running' }
HeraScriptRunner >> pause: aStep [

	reporter reportStartOfStep: aStep.
	reporter reportEndOfStep: aStep.
	paused := true
]

{ #category : 'private - running' }
HeraScriptRunner >> performUnsteppableInstructions [

	[ runnableScript hasMoreInstructions and: [ runnableScript nextInstructionCannotBeStepped ] ]
		whileTrue: [ runnableScript performNextFor: self ]
]

{ #category : 'initialization' }
HeraScriptRunner >> prepareForRunning [

	runnableScript := HeraRunnableScript for: acceptanceTest feature.
	result := self newResult.
	paused := false
]

{ #category : 'private - running' }
HeraScriptRunner >> recordErrorScenario [

	result recordErrorScenario: currentScenario.
	currentScenarioPassed := false
]

{ #category : 'private - running' }
HeraScriptRunner >> recordFailedScenario [

	result recordFailedScenario: currentScenario.
	currentScenarioPassed := false
]

{ #category : 'accessing' }
HeraScriptRunner >> reporter: aReporter [

	reporter := aReporter
]

{ #category : 'accessing' }
HeraScriptRunner >> result [

	^ result
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> resultSummary [

	reporter reportResult: result
]

{ #category : 'running' }
HeraScriptRunner >> run [

	self continue
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> runBackground: aBackground [

	reporter reportBackground: aBackground.
	aBackground steps do: [ :each |
		reporter reportStartOfStep: each.
		reporter reportEndOfStep: each ]
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> runBackgroundStep: aStep [

	currentScenarioPassed ifFalse: [ ^ self ].

	hasRunSteps := true.
	reporter reportStartOfBackgroundStep: aStep.
	isDebugging
		ifTrue: [ self basicRunStep: aStep ]
		ifFalse: [
			[
				[ self basicRunStep: aStep ]
					on: self failureClass	do: [ :failure |
						failure heraReportStep: aStep in: reporter.
						self recordFailedScenario ]
			] on: self errorClass do: [ :exception |
				exception heraReportStep: aStep in: reporter.
				self recordErrorScenario ] ].
	reporter reportEndOfBackgroundStep: aStep
]

{ #category : 'running' }
HeraScriptRunner >> runNext [

	paused := false.
	self performUnsteppableInstructions.
	runnableScript hasMoreInstructions ifFalse: [ ^ self ].
	runnableScript performNextFor: self
]

{ #category : 'running' }
HeraScriptRunner >> runOverScenario [

	paused := false.	
	[ paused not and: [ runnableScript hasMoreInstructions and: [ runnableScript atEndOfScenario not ] ] ] whileTrue: [
		runnableScript performNextFor: self ].
	self runNext.
	paused := true
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> runStep: aStep [

	currentScenarioPassed ifFalse: [ ^ self ].

	hasRunSteps := true.
	reporter reportStartOfStep: aStep.
	isDebugging
		ifTrue: [ self basicRunStep: aStep ]
		ifFalse: [
			[
				[ self basicRunStep: aStep ]
					on: self failureClass	do: [ :failure |
						failure heraReportStep: aStep in: reporter.
						self recordFailedScenario ]
			] on: self errorClass do: [ :exception |
				exception heraReportStep: aStep in: reporter.
				self recordErrorScenario ] ].
	reporter reportEndOfStep: aStep
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> startFeature: aFeature [

	currentFeature := aFeature.
	result recordStartTime.
	reporter reportStartOfFeature: aFeature
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> startScenario: aScenario [

	currentScenario := aScenario.
	currentScenarioPassed := true.
	hasRunSteps := false.
	reporter reportStartOfScenario: aScenario
]
