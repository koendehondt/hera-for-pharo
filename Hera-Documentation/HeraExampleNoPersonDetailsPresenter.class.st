Class {
	#name : 'HeraExampleNoPersonDetailsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'message'
	],
	#category : 'Hera-Documentation-Family Tree - Application',
	#package : 'Hera-Documentation',
	#tag : 'Family Tree - Application'
}

{ #category : 'layout' }
HeraExampleNoPersonDetailsPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		vAlignCenter;
		hAlignCenter;
		add: message;
		yourself
]

{ #category : 'initialization' }
HeraExampleNoPersonDetailsPresenter >> initializePresenters [ 

	message := self newLabel
		label: 'Select a person on the left to see the details.';
		yourself
]
