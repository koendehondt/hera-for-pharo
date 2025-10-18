Class {
	#name : 'HeraRunner',
	#superclass : 'HeraPresenter',
	#instVars : [
		'output',
		'scriptRunner',
		'continueButton',
		'stepOverButton',
		'resultSummary',
		'stepOverScenarioButton',
		'restartButton',
		'afterOpenDebugRunnerBlock',
		'isStepping'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'accessing' }
HeraRunner class >> defaultPreferredExtent [

	^ 800@400
]

{ #category : 'test api' }
HeraRunner >> afterOpenDebugRunnerBlock: aBlock [

	afterOpenDebugRunnerBlock := aBlock
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

	isStepping := false.
	scriptRunner continue.
	self updateWindowTitle
]

{ #category : 'test api' }
HeraRunner >> currentWindowTitle [

	^ self withWindowDo: [ :window | window title ]
]

{ #category : 'running' }
HeraRunner >> debugScenario: aScenario [

	| runner scenarioFilter |
	runner := self instantiate: self class.
	runner open.
	afterOpenDebugRunnerBlock value: runner.
	scenarioFilter := HeraScenarioFilter new title: aScenario title.
	runner debugScope: scriptRunner scope filteredBy: scenarioFilter
]

{ #category : 'running' }
HeraRunner >> debugScope: aRunnerScope [

	self initializeScriptRunnerFor: aRunnerScope.
	resultSummary model: scriptRunner result.
	self updateButtons.
	self updateWindowTitle.
	scriptRunner debug
]

{ #category : 'running' }
HeraRunner >> debugScope: aRunnerScope filteredBy: aFilter [

	self initializeScriptRunnerFor: aRunnerScope filteredBy: aFilter.
	resultSummary model: scriptRunner result.
	self updateButtons.
	self updateWindowTitle.
	scriptRunner debug
]

{ #category : 'layout' }
HeraRunner >> defaultLayout [

	| controls |
	controls := SpBoxLayout newHorizontal
		spacing: 10;
		add: continueButton width: 30;
		add: stepOverScenarioButton width: 30;
		add: stepOverButton width: 30;
		add: restartButton width: 30;
		add: self newLabel width: 30;
		add: resultSummary expand: true;
		yourself.
	^ SpBoxLayout newVertical
		spacing: 5;
		add: controls expand: false;
		add: output;
		yourself
]

{ #category : 'actions' }
HeraRunner >> finish [

	isStepping := false.
	self updateButtons.
	self updateWindowTitle
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
HeraRunner >> initialize [

	super initialize.
	isStepping := false.
	afterOpenDebugRunnerBlock := [ :ignore| ]
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

{ #category : 'initialization' }
HeraRunner >> initializeScriptRunnerFor: aRunnerScope [

	scriptRunner := HeraScriptRunner new
		scope: aRunnerScope;
		reporter: (HeraRunnerReporter for: self)
]

{ #category : 'initialization' }
HeraRunner >> initializeScriptRunnerFor: aRunnerScope filteredBy: aFilter [

	scriptRunner := HeraScriptRunner new
		scope: aRunnerScope;
		filter: aFilter;
		reporter: (HeraRunnerReporter for: self)
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
	self restartScope
]

{ #category : 'running' }
HeraRunner >> restartScope [

	| wasDebugging filter |
	scriptRunner terminate.
	isStepping := true.
	wasDebugging := scriptRunner isDebugging.
	filter := scriptRunner filter.
	self initializeScriptRunnerFor: scriptRunner scope.
	resultSummary model: scriptRunner result.
	scriptRunner isDebugging: wasDebugging.
	scriptRunner filter: filter.
	self updateButtons.
	self updateWindowTitle
]

{ #category : 'test api' }
HeraRunner >> result [

	^ scriptRunner result
]

{ #category : 'test api' }
HeraRunner >> runLog [

	^ output text
]

{ #category : 'running' }
HeraRunner >> runScope: aRunnerScope [

	self initializeScriptRunnerFor: aRunnerScope.
	resultSummary model: scriptRunner result.
	self updateButtons.
	self updateWindowTitle.
	scriptRunner run
]

{ #category : 'running' }
HeraRunner >> runScope: aRunnerScope filteredBy: aFilter [

	self initializeScriptRunnerFor: aRunnerScope filteredBy: aFilter.
	resultSummary model: scriptRunner result.
	self updateButtons.
	self updateWindowTitle.
	scriptRunner run
]

{ #category : 'private' }
HeraRunner >> scrollToEndOfOutput [

	| atEnd |
	atEnd := output text size + 1.
	output selectionInterval: (atEnd to: atEnd)
]

{ #category : 'actions' }
HeraRunner >> stepOver [

	isStepping := true.
	scriptRunner runNext.
	self updateButtons.
	self updateWindowTitle
]

{ #category : 'actions' }
HeraRunner >> stepOverScenario [

	isStepping := true.
	scriptRunner runOverScenario.
	self updateButtons.
	self updateWindowTitle
]

{ #category : 'running' }
HeraRunner >> stepScope: aRunnerScope [

	self initializeScriptRunnerFor: aRunnerScope.
	resultSummary model: scriptRunner result.
	self updateButtons.
	self updateWindowTitle
]

{ #category : 'running' }
HeraRunner >> stepScope: aRunnerScope filteredBy: aFilter [

	self initializeScriptRunnerFor: aRunnerScope filteredBy: aFilter.
	self updateButtons.
	self updateWindowTitle.
	resultSummary model: scriptRunner result
]

{ #category : 'private' }
HeraRunner >> updateButtons [

	| isFinished |
	isFinished := self hasRunAllScenarios.
	continueButton enabled: isFinished not.
	stepOverButton enabled: isFinished not.
	stepOverScenarioButton enabled: self isRunningScenario
]

{ #category : 'updating' }
HeraRunner >> updateFromReporter [

	self updateWindowTitle
]

{ #category : 'updating' }
HeraRunner >> updateWindowTitle [

	| title paused |
	title := scriptRunner hasRunAllScenarios
		ifTrue: [ 'Finished {1}/{2}' format: { scriptRunner currentScenarioIndex . scriptRunner totalScenarioCount } ]
		ifFalse: [
			paused := scriptRunner isPaused ifTrue: [ ' - Paused' ] ifFalse: [ isStepping ifTrue: [ ' - Stepping' ] ifFalse: [ '' ] ].
			'Running {1}/{2}{3}' format: { scriptRunner currentScenarioIndex . scriptRunner totalScenarioCount . paused } ].
	self withWindowDo: [ :window | window title: title ]
]

{ #category : 'accessing' }
HeraRunner >> windowIcon [

	^ Hera settings iconNamed: #checkedCircle
]

{ #category : 'accessing' }
HeraRunner >> windowTitle [

	^ 'Hera Runner'
]
