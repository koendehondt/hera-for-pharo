Class {
	#name : 'HeraPresenter',
	#superclass : 'SpPresenter',
	#category : 'Hera-UI-Core',
	#package : 'Hera-UI',
	#tag : 'Core'
}

{ #category : 'accessing' }
HeraPresenter >> aboutTitle [

	^ 'Hera'
]

{ #category : 'initialization' }
HeraPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter aboutText: Hera about
]
