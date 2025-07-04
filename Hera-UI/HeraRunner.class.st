Class {
	#name : 'HeraRunner',
	#superclass : 'HeraPresenter',
	#instVars : [
		'output',
		'lastRunAcceptanceTest',
		'scriptRunner',
		'continueButton',
		'stepOverButton',
		'resultSummary',
		'stepOverScenarioButton',
		'restartButton'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'accessing' }
HeraRunner class >> defaultPreferredExtent [

	^ 800@400
]

{ #category : 'accessing' }
HeraRunner >> clear [

	output text: Text new
]

{ #category : 'test api' }
HeraRunner >> clickContinueButton [

	^ continueButton performAction
]

{ #category : 'test api' }
HeraRunner >> clickStepButton [

	^ stepOverButton performAction
]

{ #category : 'actions' }
HeraRunner >> continue [

	scriptRunner continue
]

{ #category : 'running' }
HeraRunner >> debugAcceptanceTest: anAcceptanceTest [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	resultSummary model: scriptRunner result.
	self updateButtons.
	scriptRunner debug
]

{ #category : 'running' }
HeraRunner >> debugAcceptanceTest: anAcceptanceTest filteredBy: aFilter [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest filteredBy: aFilter.
	resultSummary model: scriptRunner result.
	self updateButtons.
	scriptRunner debug
]

{ #category : 'running' }
HeraRunner >> debugScenario: aScenario [

	| runner scenarioFilter |
	runner := self instantiate: self class.
	runner open.
	scenarioFilter := HeraScenarioFilter new title: aScenario title.
	runner debugAcceptanceTest: lastRunAcceptanceTest filteredBy: scenarioFilter
]

{ #category : 'layout' }
HeraRunner >> defaultLayout [

	| controls |
	controls := SpBoxLayout newHorizontal
		spacing: 10;
		add: continueButton width: 40;
		add: stepOverScenarioButton width: 40;
		add: stepOverButton width: 40;
		add: restartButton width: 40;
		add: self newLabel width: 40;
		add: resultSummary;
		yourself.
	^ SpBoxLayout newVertical
		spacing: 5;
		add: controls expand: false;
		add: output;
		yourself
]

{ #category : 'actions' }
HeraRunner >> finish [

	self updateButtons
]

{ #category : 'test api' }
HeraRunner >> hasDisabledContinueButton [

	^ self hasEnabledContinueButton not
]

{ #category : 'test api' }
HeraRunner >> hasDisabledStepOverButton [

	^ self hasEnabledStepOverButton not
]

{ #category : 'test api' }
HeraRunner >> hasDisabledStepOverScenarioButton [

	^ self hasEnabledStepOverScenarioButton not
]

{ #category : 'test api' }
HeraRunner >> hasEnabledContinueButton [

	^ continueButton isEnabled
]

{ #category : 'test api' }
HeraRunner >> hasEnabledRestartButton [

	^ restartButton isEnabled
]

{ #category : 'test api' }
HeraRunner >> hasEnabledStepOverButton [

	^ stepOverButton isEnabled
]

{ #category : 'test api' }
HeraRunner >> hasEnabledStepOverScenarioButton [

	^ stepOverScenarioButton isEnabled
]

{ #category : 'testing' }
HeraRunner >> hasRunAllScenarios [

	^ scriptRunner hasRunAllScenarios
]

{ #category : 'testing' }
HeraRunner >> hasRunSteps [

	^ scriptRunner hasRunSteps
]

{ #category : 'initialization' }
HeraRunner >> initializePresenters [

	continueButton := self newButton
		iconName: #go;
		action: [ self continue ];
		help: 'Continue';
		yourself.
	stepOverScenarioButton := self newButton
		iconName: #over;
		action: [ self stepOverScenario ];
		help: 'Step until end of scenario';
		yourself.
	stepOverButton := self newButton
		iconName: #into;
		action: [ self stepOver ];
		help: 'Step';
		yourself.
	restartButton := self newButton
		iconName: #restart;
		action: [ self restart ];
		help: 'Restart from the beginning';
		yourself.
	resultSummary := HeraRunnerResultSummary on: HeraResult new.
	output := self newText
		text: Text new;
		editable: false;
		addStyle: 'featureText';
		yourself
]

{ #category : 'testing' }
HeraRunner >> isRunningScenario [

	^ scriptRunner isRunningScenario
]

{ #category : 'accessing' }
HeraRunner >> report: aText [

	output text: (output text append: aText).
	self scrollToEndOfOutput
]

{ #category : 'closing' }
HeraRunner >> requestWindowClose [

	scriptRunner ifNotNil: [ scriptRunner terminate ].
	^ true
]

{ #category : 'actions' }
HeraRunner >> restart [

	self clear.
	self restartAcceptanceTest: lastRunAcceptanceTest
]

{ #category : 'running' }
HeraRunner >> restartAcceptanceTest: anAcceptanceTest [

	| wasDebugging filter |
	scriptRunner terminate.
	wasDebugging := scriptRunner isDebugging.
	filter := scriptRunner filter.
	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	resultSummary model: scriptRunner result.
	scriptRunner isDebugging: wasDebugging.
	scriptRunner filter: filter.
	self updateButtons
]

{ #category : 'test api' }
HeraRunner >> result [

	^ scriptRunner result
]

{ #category : 'running' }
HeraRunner >> runAcceptanceTest: anAcceptanceTest [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	resultSummary model: scriptRunner result.
	self updateButtons.
	scriptRunner run
]

{ #category : 'running' }
HeraRunner >> runAcceptanceTest: anAcceptanceTest filteredBy: aFilter [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest filteredBy: aFilter.
	resultSummary model: scriptRunner result.
	self updateButtons.
	scriptRunner run
]

{ #category : 'test api' }
HeraRunner >> runLog [

	^ output text
]

{ #category : 'private' }
HeraRunner >> scriptRunnerFor: anAcceptanceTest [

	^ HeraScriptRunner new
		acceptanceTest: anAcceptanceTest;
		reporter: (HeraRunnerReporter for: self)
]

{ #category : 'private' }
HeraRunner >> scriptRunnerFor: anAcceptanceTest filteredBy: aFilter [

	^ HeraScriptRunner new
		acceptanceTest: anAcceptanceTest;
		filter: aFilter;
		reporter: (HeraRunnerReporter for: self)
]

{ #category : 'private' }
HeraRunner >> scrollToEndOfOutput [

	| atEnd |
	atEnd := output text size + 1.
	output selectionInterval: (atEnd to: atEnd)
]

{ #category : 'running' }
HeraRunner >> stepAcceptanceTest: anAcceptanceTest [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	resultSummary model: scriptRunner result.
	self updateButtons
]

{ #category : 'running' }
HeraRunner >> stepAcceptanceTest: anAcceptanceTest filteredBy: aFilter [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest filteredBy: aFilter.
	resultSummary model: scriptRunner result.
	self updateButtons
]

{ #category : 'actions' }
HeraRunner >> stepOver [

	scriptRunner runNext.
	self updateButtons
]

{ #category : 'actions' }
HeraRunner >> stepOverScenario [

	scriptRunner runOverScenario.
	self updateButtons
]

{ #category : 'private' }
HeraRunner >> updateButtons [

	| isFinished |
	isFinished := self hasRunAllScenarios.
	continueButton enabled: isFinished not.
	stepOverButton enabled: isFinished not.
	stepOverScenarioButton enabled: self isRunningScenario
]

{ #category : 'accessing' }
HeraRunner >> windowIcon [

	^ Hera settings iconNamed: #checkedCircle
]

{ #category : 'accessing' }
HeraRunner >> windowTitle [

	^ 'Hera Runner'
]
