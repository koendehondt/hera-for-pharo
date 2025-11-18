Class {
	#name : 'HeraExamplePersonDetailsPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'childrenList',
		'nameField',
		'childrenLabel',
		'nameLabel',
		'disabledCheckbox',
		'femaleRadio',
		'maleRadio',
		'otherRadio'
	],
	#category : 'Hera-Documentation-Example Spec Application',
	#package : 'Hera-Documentation',
	#tag : 'Example Spec Application'
}

{ #category : 'initialization' }
HeraExamplePersonDetailsPresenter >> connectPresenters [

	disabledCheckbox whenChangedDo: [ :isDisabled | self person isDisabled: isDisabled ].
	femaleRadio whenChangedDo: [ :isFemale | isFemale ifTrue: [ self person beFemale ] ].
	maleRadio whenChangedDo: [ :isMale | isMale ifTrue: [ self person beMale ] ].
	otherRadio whenChangedDo: [ :isOther | isOther ifTrue: [ self person beOther ] ]
]

{ #category : 'layout' }
HeraExamplePersonDetailsPresenter >> defaultLayout [

	| sexLayout |
	sexLayout := SpBoxLayout newLeftToRight
		add: femaleRadio;
		add: maleRadio;
		add: otherRadio;
		yourself.
	^ SpBoxLayout newTopToBottom
		spacing: 10;
		add: nameLabel expand: false;
		add: nameField expand: false;
		add: sexLayout expand: false;
		add: disabledCheckbox expand: false;
		add: childrenLabel expand: false;
		add: childrenList;
		yourself
]

{ #category : 'hera' }
HeraExamplePersonDetailsPresenter >> heraPresenterAt: aWidgetName ifAbsent: absentBlock [

	| mapping |
	mapping := Dictionary new
		add: 'Name' -> nameField;
		add: 'Children' -> childrenList;
		add: 'Disabled' -> disabledCheckbox;
		add: 'Male' -> maleRadio;
		add: 'Female' -> femaleRadio;
		add: 'Other' -> otherRadio;
		yourself.
	^ mapping at: aWidgetName ifAbsent: absentBlock
]

{ #category : 'initialization' }
HeraExamplePersonDetailsPresenter >> initializePresenters [

	nameLabel := self newLabel label: 'Name:'; yourself.
	nameField := self newTextInput.
	disabledCheckbox := self newCheckBox label: 'Disabled'; yourself.
	femaleRadio := self newRadioButton label: 'Female'; yourself.
	maleRadio := self newRadioButton label: 'Male'; yourself.
	otherRadio := self newRadioButton
		label: 'Other';
		associatedRadioButtons: { femaleRadio . maleRadio };
		initialStateNotSet;
		yourself.
	childrenLabel := self newLabel label: 'Children:'; yourself.
	childrenList := self newList
		beMultipleSelection;
		display: [ :person | person name ];
		yourself
]

{ #category : 'initialization' }
HeraExamplePersonDetailsPresenter >> modelChanged [
	
	self person
		ifNil: [
			nameField text: ''.
			disabledCheckbox state: false.
			femaleRadio initialStateNotSet.
			childrenList items: #() ]
		ifNotNil: [ :person |
			nameField text: person name.
			disabledCheckbox state: person isDisabled.
			femaleRadio state: person isFemale.
			maleRadio state: person isMale.
			otherRadio state: person isOther.
			childrenList items: person children ]
]

{ #category : 'accessing' }
HeraExamplePersonDetailsPresenter >> person [

	^ self model
]
