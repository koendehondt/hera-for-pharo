Class {
	#name : 'HeraSpacer',
	#superclass : 'SpPresenter',
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'layout' }
HeraSpacer >> defaultLayout [

	^ SpBoxLayout newLeftToRight
]

{ #category : 'initialization' }
HeraSpacer >> initializePresenters [

	"Do nothing. I do not have any subpresenters."
]
