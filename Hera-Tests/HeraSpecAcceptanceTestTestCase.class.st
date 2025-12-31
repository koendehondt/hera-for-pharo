Class {
	#name : 'HeraSpecAcceptanceTestTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraSpecAcceptanceTestTestCase >> describedClass [

	^ HeraSpecAcceptanceTest
]

{ #category : 'tests - helpers - presenters' }
HeraSpecAcceptanceTestTestCase >> testCheck [

	| finder |
	finder := StFinderPresenter newApplication: StPresenter currentApplication model: StFinderModel new.
	self deny: finder searchOptions caseCheckBox state.
	subject openPresenterAs: #finder with: [ finder ].
	subject check: { #finder . #searchOptions . #caseCheckBox }.
	self assert: finder searchOptions caseCheckBox state
]

{ #category : 'tests - helpers - presenters' }
HeraSpecAcceptanceTestTestCase >> testClick [

	| finder |
	finder := StFinderPresenter newApplication: StPresenter currentApplication model: StFinderModel new.
	self assert: finder searchOptions substringBox state.
	subject openPresenterAs: #finder with: [ finder ].
	subject click: { #finder . #searchOptions . #substringBox }.
	self deny: finder searchOptions substringBox state
]

{ #category : 'tests - helpers - presenters' }
HeraSpecAcceptanceTestTestCase >> testPresenterAt [

	| finder |
	finder := StFinderPresenter newApplication: StPresenter currentApplication model: StFinderModel new.
	subject
		openPresenterAs: #finder
		with: [ finder ].
	self assert: (subject presenterAt: #finder) identicalTo: finder
]

{ #category : 'tests - helpers - presenters' }
HeraSpecAcceptanceTestTestCase >> testPresenterAtPath [

	subject
		openPresenterAs: #finder
		with: [ StFinderPresenter newApplication: StPresenter currentApplication model: StFinderModel new ].
	self assert: ((subject presenterAtPath: { #finder . #searchOptions . #substringBox }) isMemberOf: SpCheckBoxPresenter)
]

{ #category : 'tests - helpers - presenters' }
HeraSpecAcceptanceTestTestCase >> testPresenterAtPathDo [

	| actualCheckbox |
	subject
		openPresenterAs: #finder
		with: [ StFinderPresenter newApplication: StPresenter currentApplication model: StFinderModel new ].
	subject
		presenterAtPath: { #finder . #searchOptions . #substringBox }
		do: [ :checkbox | actualCheckbox := checkbox ].
	self assert: (actualCheckbox isMemberOf: SpCheckBoxPresenter)
]

{ #category : 'tests - helpers - presenters' }
HeraSpecAcceptanceTestTestCase >> testUncheck [

	| finder |
	finder := StFinderPresenter newApplication: StPresenter currentApplication model: StFinderModel new.
	self assert: finder searchOptions substringBox state.
	subject openPresenterAs: #finder with: [ finder ].
	subject uncheck: { #finder . #searchOptions . #substringBox }.
	self deny: finder searchOptions substringBox state
]

{ #category : 'tests - helpers - presenters' }
HeraSpecAcceptanceTestTestCase >> testUncheckingUncheckedPresenterSignalsFailure [

	| finder |
	finder := StFinderPresenter newApplication: StPresenter currentApplication model: StFinderModel new.
	subject openPresenterAs: #finder with: [ finder ].
	self
		should: [ subject uncheck: { #finder . #searchOptions . #caseCheckBox }. ]
		raise: HeraFailure
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: 'The presenter at #(#finder #searchOptions #caseCheckBox) is already unchecked.']
]
