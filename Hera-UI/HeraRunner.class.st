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
		'isStepping',
		'results',
		'reporter'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'accessing' }
HeraRunner class >> defaultPreferredExtent [

	^ 800@400
]

{ #category : 'private - menus' }
HeraRunner >> addRerunMenuGroupTo: parentGroup [

		parentGroup addGroupWith: [ :group |
			group
				beDisplayedAsGroup;
				addActionWith: [ :action |
					action		
						name: 'Rerun';
						description: 'Rerun';
						shortcutKey: $r meta;
						actionEnabled: [ self canRerun ];
						action: [ self rerun ] ];
				addActionWith: [ :action |
					action		
						name: 'Rerun and step';
						description: 'Rerun and step';
						shortcutKey: $r meta shift;
						actionEnabled: [ self canRerun ];
						action: [ self rerunAndStep ] ];
				addActionWith: [ :action |
					action		
						name: 'Rerun and debug';
						description: 'Rerun and debug';
						shortcutKey: $d meta;
						actionEnabled: [ self canRerun ];
						action: [ self rerunAndDebug ] ] ]
]

{ #category : 'testing' }
HeraRunner >> canRerun [

	^ results selectedItem isNotNil
]

{ #category : 'actions' }
HeraRunner >> clear [

	results items: OrderedCollection new.
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

{ #category : 'initialization' }
HeraRunner >> connectPresenters [

	results whenSelectionChangedDo: [ self resultSelectionChanged ].
	self installContextMenu
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

	| controls feedback |
	controls := SpBoxLayout newHorizontal
		spacing: 10;
		add: continueButton width: 30;
		add: stepOverScenarioButton width: 30;
		add: stepOverButton width: 30;
		add: restartButton width: 30;
		add: self newLabel width: 30;
		add: resultSummary expand: true;
		yourself.
	feedback := SpPanedLayout newLeftToRight
		positionOfSlider: 33 percent;
		add: results;
		add: output;
		yourself.
	^ SpBoxLayout newVertical
		spacing: 5;
		add: controls expand: false;
		add: feedback;
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
	isStepping := false
]

{ #category : 'initialization' }
HeraRunner >> initializeButtonPresenters [

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
		yourself
]

{ #category : 'initialization' }
HeraRunner >> initializePresenters [

	self initializeButtonPresenters.
	resultSummary := HeraRunnerResultSummary on: HeraResult new.
	self initializeResultsPresenter.
	output := self newText
		text: Text new;
		editable: false;
		addStyle: 'featureText';
		yourself
]

{ #category : 'initialization' }
HeraRunner >> initializeResultsPresenter [

	results := self newListView
		items: OrderedCollection new;
		setup: [ :aPresenter |
			| presenter |
			(presenter := aPresenter newPresenter)
				layout: (SpBoxLayout newHorizontal
					spacing: 5;
					vAlignCenter;
					add: presenter newLabel expand: false;
					add: presenter newImage expand: false;
					add: presenter newLabel expand: false;
					add: presenter newLabel expand: false;
					yourself);
				yourself ];
		bind: [ :aPresenter :item | | elements indentationLabel image descriptionLabel durationLabel |
			elements := aPresenter layout children.
			indentationLabel := elements first.
			indentationLabel label: (String new: (item level - 1) * 5 withAll: Character space).
			elements := aPresenter layout children.
			image := elements second.
			image image: (item iconName ifNotNil: [ :iconName | Hera settings iconNamed: iconName ]).
			descriptionLabel := elements third.
			descriptionLabel label: item descriptionLabel.
			durationLabel := elements fourth.
			durationLabel label: item durationLabel ];
		yourself
]

{ #category : 'initialization' }
HeraRunner >> initializeScriptRunnerFor: aRunnerScope [

	reporter := HeraRunnerReporter for: self.
	scriptRunner := HeraScriptRunner new
		scope: aRunnerScope;
		reporter: reporter
]

{ #category : 'initialization' }
HeraRunner >> initializeScriptRunnerFor: aRunnerScope filteredBy: aFilter [

	reporter := HeraRunnerReporter for: self.
	scriptRunner := HeraScriptRunner new
		scope: aRunnerScope;
		filter: aFilter;
		reporter: reporter
]

{ #category : 'private - menus' }
HeraRunner >> installContextMenu [

	results
		actionsWith: [ :rootGroup |
			self addRerunMenuGroupTo: rootGroup ]
]

{ #category : 'testing' }
HeraRunner >> isRunningScenario [

	^ scriptRunner isRunningScenario
]

{ #category : 'private' }
HeraRunner >> newRunner [

	^ self instantiate: self class
]

{ #category : 'actions' }
HeraRunner >> record: aResultItem [

	results items add: aResultItem.
	results refresh
]

{ #category : 'actions' }
HeraRunner >> report: aText [

	output text: (output text append: aText).
	self scrollToEndOfOutput
]

{ #category : 'closing' }
HeraRunner >> requestWindowClose [

	scriptRunner ifNotNil: [ scriptRunner terminate ].
	^ true
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerun [

	results selectedItem rerunFromRunner: self
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunAndDebug [

	results selectedItem rerunDebuggingFromRunner: self
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunAndDebugFeatureResult: aFeatureResult [

	self newRunner
		open;
		debugScope: aFeatureResult acceptanceTest copyForRunning asRunnerScope
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunAndDebugRootResult: aRootResultaRootResult [

	self newRunner
		open;
		debugScope: scriptRunner scope
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunAndDebugScenarioResult: aScenarioResult [

	| scenarioFilter |
	scenarioFilter := HeraScenarioFilter new title: aScenarioResult scenarioTitle.
	self newRunner
		open;
		debugScope: aScenarioResult acceptanceTest copyForRunning asRunnerScope filteredBy: scenarioFilter
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunAndStep [

	results selectedItem rerunSteppingFromRunner: self
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunAndStepFeatureResult: aFeatureResult [

	self newRunner
		open;
		stepScope: aFeatureResult acceptanceTest copyForRunning asRunnerScope
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunAndStepRootResult: aRootResultaRootResult [

	self newRunner
		open;
		stepScope: scriptRunner scope
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunAndStepScenarioResult: aScenarioResult [

	| scenarioFilter |
	scenarioFilter := HeraScenarioFilter new title: aScenarioResult scenarioTitle.
	self newRunner
		open;
		stepScope: aScenarioResult acceptanceTest copyForRunning asRunnerScope filteredBy: scenarioFilter
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunFeatureResult: aFeatureResult [

	self newRunner
		open;
		runScope: aFeatureResult acceptanceTest copyForRunning asRunnerScope
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunRootResult: aRootResult [

	self newRunner
		open;
		runScope: scriptRunner scope
]

{ #category : 'actions - rerunning' }
HeraRunner >> rerunScenarioResult: aScenarioResult [

	| scenarioFilter |
	scenarioFilter := HeraScenarioFilter new title: aScenarioResult scenarioTitle.
	self newRunner
		open;
		runScope: aScenarioResult acceptanceTest copyForRunning asRunnerScope filteredBy: scenarioFilter
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
HeraRunner >> resultItemDescriptions [

	^ self resultItems collect: [ :each | each description ] as: Array
]

{ #category : 'test api' }
HeraRunner >> resultItemIconNames [

	^ self resultItems collect: [ :each | each iconName ] as: Array
]

{ #category : 'test api' }
HeraRunner >> resultItems [

	^ results items
]

{ #category : 'private' }
HeraRunner >> resultSelectionChanged [

	results selection selectedItem
		ifNil: [ output text: Text new ]
		ifNotNil: [ :resultItem | | resultItemLog |
			resultItemLog := resultItem logFrom: reporter text.
			output text: (self trimLog: resultItemLog) ]
]

{ #category : 'test api' }
HeraRunner >> resultSummaryCounts [

	^ resultSummary counts
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
HeraRunner >> scrollLastResultIntoView [

	results verticalAlignment desiredVisibleRow: results items size
]

{ #category : 'private' }
HeraRunner >> scrollToEndOfOutput [

	| atEnd |
	atEnd := output text size + 1.
	output selectionInterval: (atEnd to: atEnd)
]

{ #category : 'test api' }
HeraRunner >> selectResultItemAt: anInteger [

	results clickAtIndex: anInteger
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
	isStepping := true.
	self updateButtons.
	self updateWindowTitle
]

{ #category : 'running' }
HeraRunner >> stepScope: aRunnerScope filteredBy: aFilter [

	self initializeScriptRunnerFor: aRunnerScope filteredBy: aFilter.
	isStepping := true.
	self updateButtons.
	self updateWindowTitle.
	resultSummary model: scriptRunner result
]

{ #category : 'private' }
HeraRunner >> trimLog: aText [

	| lastCrIndex |
	lastCrIndex := 0.
	(1 to: aText size)
		detect: [ :index | | char |
			char := aText at: index.
			char = Character cr ifTrue: [ lastCrIndex := index ].
			char isSeparator not ]
		ifNone: [ ^ aText ].
	^ aText copyFrom: lastCrIndex + 1 to: aText size
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

	self updateWindowTitle.
	results refresh.
	self scrollLastResultIntoView.
	self currentWorld doOneCycle "Otherwise the runner does not update and the described application does not update either."
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
