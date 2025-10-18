Class {
	#name : 'HeraRunnerResultCount',
	#superclass : 'SpPresenter',
	#instVars : [
		'countLabel'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'accessing' }
HeraRunnerResultCount >> count: anInteger [

	countLabel label: anInteger asString
]

{ #category : 'layout' }
HeraRunnerResultCount >> defaultLayout [

	^ SpBoxLayout newHorizontal
		hAlignCenter;
		vAlignCenter;
		add: countLabel;
		yourself
]

{ #category : 'initialization' }
HeraRunnerResultCount >> initializePresenters [

	countLabel := self newLabel
		addStyle: 'resultCount';
		yourself
]
