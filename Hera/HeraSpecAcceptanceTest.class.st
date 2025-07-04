Class {
	#name : 'HeraSpecAcceptanceTest',
	#superclass : 'HeraAcceptanceTest',
	#instVars : [
		'openPresenters'
	],
	#category : 'Hera-Web',
	#package : 'Hera',
	#tag : 'Web'
}

{ #category : 'hooks' }
HeraSpecAcceptanceTest >> afterScenario [

	super afterScenario.
	self closeWindows
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> check: aTogglePresenterPathArray [

	| presenter |
	presenter := self presenterAtPath: aTogglePresenterPathArray.
	self assert: presenter isEnabled description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is not enabled.' ] .
	self assert: presenter state not description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is already checked.' ] .
	presenter click
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> click: aPresenterPathArray [

	| presenter |
	presenter := self presenterAtPath: aPresenterPathArray.
	self assert: presenter isEnabled description: [ 'The presenter at ' , aPresenterPathArray printString , ' is not enabled.' ] .
	presenter click
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> closePresenterAt: aNameSymbol [

	(self presenterAt: aNameSymbol) window close.
	openPresenters removeKey: aNameSymbol
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> closeWindows [

	openPresenters do: [ :each | each window close ].
	openPresenters := Dictionary new
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> detectPresenterInTopWindowAs: aNameSymbol [

	^ openPresenters at: aNameSymbol put: SystemWindow topWindow model presenter
]

{ #category : 'initialization' }
HeraSpecAcceptanceTest >> initialize [

	super initialize.
	openPresenters := Dictionary new
]

{ #category : 'helpers - simulating events' }
HeraSpecAcceptanceTest >> keyDownEventFromChar: aCharacter alt: useAlt ctrl: useCtrl command: useCommand shift: useShift [

	| event modifier code |
	event := KeyboardEvent new.
	modifier := 0.
	useShift ifTrue: [ modifier := modifier + 8 ].
	useCtrl ifTrue: [ modifier := modifier + 16 ].
	useAlt ifTrue: [ modifier := modifier + 32 ].
	useCommand ifTrue: [ modifier := modifier + 64 ].
	code := aCharacter asInteger.
	event
		setType: #keyDown
		buttons: modifier
		position: 0 @ 0
		keyValue: code
		charCode: code
		hand: self currentWorld currentHand
		stamp: Time now.
	event key: (KeyboardKey fromCharacter: aCharacter).
	^ event
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> openPresenter: aPresenter as: aNameSymbol [

	aPresenter open.
	^ openPresenters at: aNameSymbol put: aPresenter
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> openPresenterAs: aNameSymbol with: aBlock [

	^ openPresenters at: aNameSymbol put: aBlock value
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> presenterAt: aNameSymbol [

	^ openPresenters at: aNameSymbol ifAbsent: [ self error: ('Presenter with name "{1}" not found.' format: { aNameSymbol }) ]
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> presenterAtPath: aPresenterPathArray [

	^ aPresenterPathArray allButFirst
		inject: (self presenterAt: aPresenterPathArray first)
		into: [ :accu :each | accu perform: each ]
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> presenterAtPath: aPresenterPathArray do: aBlock [

	aBlock value: (self presenterAtPath: aPresenterPathArray)
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> uncheck: aTogglePresenterPathArray [

	| presenter |
	presenter := self presenterAtPath: aTogglePresenterPathArray.
	self assert: presenter isEnabled description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is not enabled.' ] .
	self assert: presenter state description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is already unchecked.' ] .
	presenter click
]
