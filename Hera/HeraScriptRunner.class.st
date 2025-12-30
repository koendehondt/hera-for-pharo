Class {
	#name : 'HeraScriptRunner',
	#superclass : 'Object',
	#instVars : [
		'reporter',
		'result',
		'acceptanceTest',
		'isDebugging',
		'currentScenario',
		'currentScenarioPassed',
		'currentFeature',
		'hasRunSteps',
		'runnableScript',
		'paused',
		'scenarioCount',
		'currentAcceptanceTest',
		'currentRule',
		'beforeScenarioHookFailed',
		'suppressPauseAndDebugSteps',
		'scope',
		'currentScenarioIndex'
	],
	#category : 'Hera-Running',
	#package : 'Hera',
	#tag : 'Running'
}

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> afterScenarioHook [

	beforeScenarioHookFailed ifTrue: [^self].
	[currentAcceptanceTest afterScenario] on: self errorClass
		do: 
			[:error |
			reporter reportAfterScenarioHookError: error.
			self recordErrorScenario]
]

{ #category : 'private - running' }
HeraScriptRunner >> basicRunStep: aStep [

	isDebugging
		ifTrue: [
			aStep runIn: currentAcceptanceTest.
			reporter reportPassedStep: aStep  ]
		ifFalse: [
			[
				[
					aStep runIn: currentAcceptanceTest.
					reporter reportPassedStep: aStep
				] on: self failureClass	do: [ :failure |
					failure heraReportStep: aStep of: currentScenario in: reporter.
					self recordFailedScenario ]
			] on: self errorClass do: [ :exception |
				exception heraReportStep: aStep of: currentScenario in: reporter.
				self recordErrorScenario ] ]
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> beforeScenarioHook [

	[currentAcceptanceTest beforeScenario] on: self errorClass
		do: 
			[:error |
			beforeScenarioHookFailed := true.
			reporter reportBeforeScenarioHookError: error.
			self recordErrorScenario]
]

{ #category : 'running' }
HeraScriptRunner >> continue [

	paused := false.
	[ runnableScript hasMoreInstructions and: [ paused not ] ] whileTrue: [
		runnableScript performNextFor: self ]
]

{ #category : 'accessing' }
HeraScriptRunner >> currentAcceptanceTest [

	^ currentAcceptanceTest
]

{ #category : 'accessing' }
HeraScriptRunner >> currentScenarioIndex [

	^ currentScenarioIndex
]

{ #category : 'running' }
HeraScriptRunner >> debug [

	self isDebugging: true.
	^ self run
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> endFeature [

	self hasRunScenarios ifFalse: [
		result recordEmptyFeature: currentFeature.
		reporter reportEmptyFeature: currentFeature ].
	reporter reportEndOfFeature: currentFeature
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> endFeatures [

	result recordEndTime.
	reporter reportEndOfFeatures
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> endRule [

	reporter reportEndOfRule: currentRule
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> endScenario [

	beforeScenarioHookFailed ifFalse: [
		self hasRunSteps
			ifTrue: [
				currentScenarioPassed ifTrue: [
					result recordPassedScenario: currentScenario.
					reporter reportPassedScenario: currentScenario ] ]
			ifFalse: [
				result recordEmptyScenario: currentScenario.
				reporter reportEmptyScenario: currentScenario ] ].
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
HeraScriptRunner >> filter [

	^ runnableScript filter
]

{ #category : 'accessing' }
HeraScriptRunner >> filter: aFilter [

	runnableScript filter: aFilter
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
	currentScenarioIndex := 0.
	paused := false.
	self reporter: HeraNoReporter new.
	suppressPauseAndDebugSteps := false
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
HeraScriptRunner >> isPaused [

	^ paused
]

{ #category : 'testing' }
HeraScriptRunner >> isRunningScenario [

	^ currentScenario isNotNil
]

{ #category : 'running' }
HeraScriptRunner >> pause: aStep [

	paused := suppressPauseAndDebugSteps not.
	reporter reportPauseStep: aStep asSuppressed: suppressPauseAndDebugSteps
]

{ #category : 'private - running' }
HeraScriptRunner >> performUnsteppableInstructions [

	[ runnableScript hasMoreInstructions and: [ runnableScript nextInstructionCannotBeStepped ] ]
		whileTrue: [ runnableScript performNextFor: self ]
]

{ #category : 'private - running' }
HeraScriptRunner >> recordErrorScenario [

	result recordErrorScenario: currentScenario.
	reporter reportErrorScenario: currentScenario.
	currentScenarioPassed := false
]

{ #category : 'private - running' }
HeraScriptRunner >> recordFailedScenario [

	result recordFailedScenario: currentScenario.
	reporter reportFailedScenario: currentScenario.
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

{ #category : 'accessing' }
HeraScriptRunner >> result: aResult [

	result := aResult
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

	reporter reportStartOfBackground: aBackground.
	aBackground steps do: [ :each |
		reporter reportStartOfStep: each.
		reporter reportEndOfStep: each ].
	reporter reportEndOfBackground: aBackground
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
						failure heraReportStep: aStep of: currentScenario in: reporter.
						self recordFailedScenario ]
			] on: self errorClass do: [ :exception |
				exception heraReportStep: aStep of: currentScenario in: reporter.
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
	suppressPauseAndDebugSteps
		ifTrue: [
			[ self basicRunStep: aStep ]
				on: Halt
				do: [ :halt | reporter reportSuppressed ] ]
		ifFalse: [
			self basicRunStep: aStep ].
	reporter reportEndOfStep: aStep
]

{ #category : 'accessing' }
HeraScriptRunner >> scope [

	^ scope
]

{ #category : 'accessing' }
HeraScriptRunner >> scope: aHeraRunnerScope [

	scope := aHeraRunnerScope.
	self result: HeraResult new.
	runnableScript := HeraRunnableScript forAll: self scope acceptanceTests
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> startFeature: aFeature in: anAcceptanceTest [

	currentFeature := aFeature.
	acceptanceTest := anAcceptanceTest.
	reporter reportStartOfFeature: aFeature in: anAcceptanceTest
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> startFeatures: featureCount [

	result recordStartTime.
	reporter reportStartOfFeatures: featureCount
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> startRule: aRule [

	currentRule := aRule.
	reporter reportStartOfRule: aRule
]

{ #category : 'instruction double dispatch' }
HeraScriptRunner >> startScenario: aScenario [

	currentScenario := aScenario.
	beforeScenarioHookFailed := false.
	currentScenarioPassed := true.
	hasRunSteps := false.
	currentAcceptanceTest := acceptanceTest copyForRunning.
	paused := false.
	currentScenarioIndex := currentScenarioIndex + 1.
	reporter reportStartOfScenario: aScenario
]

{ #category : 'accessing' }
HeraScriptRunner >> suppressPauseAndDebugSteps [

	suppressPauseAndDebugSteps := true
]

{ #category : 'running' }
HeraScriptRunner >> terminate [

	self isRunningScenario ifFalse: [ ^ self ].
	self afterScenarioHook
]

{ #category : 'accessing' }
HeraScriptRunner >> totalScenarioCount [

	^ runnableScript totalScenarioCount
]
