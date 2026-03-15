Class {
	#name : 'HeraExamplePersonDetailsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'childrenList',
		'nameField',
		'childrenLabel',
		'nameLabel',
		'disabledCheckbox',
		'femaleRadio',
		'maleRadio',
		'otherRadio',
		'nameChangedBlock',
		'suppressUpdates',
		'person'
	],
	#category : 'Hera-Documentation-Family Tree - Application',
	#package : 'Hera-Documentation',
	#tag : 'Family Tree - Application'
}

{ #category : 'initialization' }
HeraExamplePersonDetailsPresenter >> connectPresenters [

	suppressUpdates := false.
	nameChangedBlock := [ :name | "Do nothing." ].
	nameField whenTextChangedDo: [ :name |
		person ifNotNil: [ person name: name ].
		nameChangedBlock value: name ].
	disabledCheckbox whenChangedDo: [ :isDisabled | person isDisabled: isDisabled ].
	femaleRadio whenChangedDo: [ :isFemale | isFemale ifTrue: [ person beFemale ] ].
	maleRadio whenChangedDo: [ :isMale | isMale ifTrue: [ person beMale ] ].
	otherRadio whenChangedDo: [ :isOther | isOther ifTrue: [ person beOther ] ]
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

{ #category : 'api - events' }
HeraExamplePersonDetailsPresenter >> focusNameField [

	nameField takeKeyboardFocus; selectAll
]

{ #category : 'hera - api' }
HeraExamplePersonDetailsPresenter >> heraPresenterAt: aWidgetName ifAbsent: absentBlock [

	| mapping |
	mapping := Dictionary new
		add: 'Name' -> nameField;
		add: 'Children' -> childrenList;
		add: disabledCheckbox label -> disabledCheckbox;
		add: maleRadio label -> maleRadio;
		add: femaleRadio label -> femaleRadio;
		add: otherRadio label -> otherRadio;
		yourself.
	^ mapping at: aWidgetName ifAbsent: absentBlock
]

{ #category : 'initialization' }
HeraExamplePersonDetailsPresenter >> initializePresenters [

	nameLabel := self newLabel label: 'Name:'; yourself.
	nameField := self newTextInput.
	femaleRadio := self newRadioButton label: 'Female'; yourself.
	maleRadio := self newRadioButton label: 'Male'; yourself.
	otherRadio := self newRadioButton
		label: 'Other';
		associatedRadioButtons: { femaleRadio . maleRadio };
		initialStateNotSet;
		yourself.
	disabledCheckbox := self newCheckBox label: 'Disabled'; yourself.
	childrenLabel := self newLabel label: 'Children:'; yourself.
	childrenList := self newList
		beMultipleSelection;
		display: [ :child | child name ];
		yourself
]

{ #category : 'accessing' }
HeraExamplePersonDetailsPresenter >> person: aPerson [

	person := aPerson.
	self personChanged
]

{ #category : 'initialization' }
HeraExamplePersonDetailsPresenter >> personChanged [

	self suppressUpdatesWhile: [
		nameField text: person name.
		person isFemale ifTrue: [femaleRadio state: true].
		person isMale ifTrue: [maleRadio state: true].
		person isOther ifTrue: [otherRadio state: true].
		disabledCheckbox state: person isDisabled.
		childrenList items: person children ]
]

{ #category : 'private' }
HeraExamplePersonDetailsPresenter >> suppressUpdatesWhile: aBlock [

	suppressUpdates := true.
	aBlock value.
	suppressUpdates := false
]

{ #category : 'api - events' }
HeraExamplePersonDetailsPresenter >> whenNameChangedDo: aBlock [

	nameChangedBlock := [ :name | suppressUpdates ifFalse: [ aBlock cull: name ] ]
]
