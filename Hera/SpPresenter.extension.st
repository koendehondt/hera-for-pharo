Extension { #name : 'SpPresenter' }

{ #category : '*Hera' }
SpPresenter >> heraPresenterAt: aPresenterName ifAbsent: absentBlock [
	"Override this method to answer the presenter known as the given name.
	 Evaluate the given block if the given name is unknown."

	^ absentBlock value
]

{ #category : '*Hera' }
SpPresenter >> heraPresenterAt: aPresenterName ifPresent: presentBlock [

	| presenter |
	presenter := self heraPresenterAt: aPresenterName ifAbsent: [ ^ nil ].
	^ presentBlock value: presenter
]
