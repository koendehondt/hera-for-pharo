Class {
	#name : 'HeraExampleNoPersonDetailsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'message'
	],
	#category : 'Hera-Documentation-Example Spec Application',
	#package : 'Hera-Documentation',
	#tag : 'Example Spec Application'
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
