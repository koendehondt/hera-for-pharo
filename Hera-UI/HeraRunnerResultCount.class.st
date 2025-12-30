Class {
	#name : 'HeraRunnerResultCount',
	#superclass : 'SpPresenter',
	#instVars : [
		'countLabel',
		'textColor',
		'value'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

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
		"addStyle: 'resultCount';
		does not work, so let's do it this way:"
		displayColor: [ self textColor ];
		yourself
]

{ #category : 'accessing' }
HeraRunnerResultCount >> textColor [

	^ textColor ifNil: [ Color white ]
]

{ #category : 'accessing' }
HeraRunnerResultCount >> textColor: aColor [

	textColor := aColor
]

{ #category : 'test api' }
HeraRunnerResultCount >> value [

	^ value
]

{ #category : 'accessing' }
HeraRunnerResultCount >> value: anInteger [

	value := anInteger.
	countLabel label: value asString
]
