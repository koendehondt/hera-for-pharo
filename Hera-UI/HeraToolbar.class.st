Class {
	#name : 'HeraToolbar',
	#superclass : 'SpPresenter',
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'accessing' }
HeraToolbar >> addButton: aButton [

	self layout add: aButton width: 24
]

{ #category : 'accessing' }
HeraToolbar >> addSpacer [

	self layout add: (self instantiate: HeraSpacer) width: 30
]

{ #category : 'accessing' }
HeraToolbar >> beAlignedAtEnd [

	self layout hAlignEnd
]

{ #category : 'layout' }
HeraToolbar >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		spacing: 10;
		yourself
]

{ #category : 'initialization' }
HeraToolbar >> initializePresenters [

	"Do nothing. My subpresenters are added later."
]
