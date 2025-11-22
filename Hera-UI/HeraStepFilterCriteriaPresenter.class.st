Class {
	#name : 'HeraStepFilterCriteriaPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'includeGivenStepsCheckBox',
		'includeWhenStepsCheckBox',
		'includeThenStepsCheckBox',
		'onlyDeprecatedStepsCheckBox',
		'queryField',
		'onlyEmptyStepsCheckBox'
	],
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'initialization' }
HeraStepFilterCriteriaPresenter >> connectPresenters [

	includeGivenStepsCheckBox whenChangedDo: [ :state | self stepFilterCriteria includeGivenSteps: state ].
	includeWhenStepsCheckBox whenChangedDo: [ :state | self stepFilterCriteria includeWhenSteps: state ].
	includeThenStepsCheckBox whenChangedDo: [ :state | self stepFilterCriteria includeThenSteps: state ].
	queryField whenTextChangedDo: [ :text | self stepFilterCriteria query: text ].
	onlyDeprecatedStepsCheckBox whenChangedDo: [ :state | self stepFilterCriteria onlyDeprecatedSteps: state ].
	onlyEmptyStepsCheckBox whenChangedDo: [ :state | self stepFilterCriteria onlyEmptySteps: state ].
]

{ #category : 'layout' }
HeraStepFilterCriteriaPresenter >> defaultLayout [
	"Using exact widths due to https://github.com/pharo-spec/Spec/issues/1845."

	| leftBox middleBox rightBox |
	leftBox := SpBoxLayout newLeftToRight
		hAlignStart;
		vAlignCenter;
		add: includeGivenStepsCheckBox width: 60;
		add: includeWhenStepsCheckBox width: 60;
		add: includeThenStepsCheckBox width: 60;
		yourself.	
	middleBox := SpBoxLayout newLeftToRight
		vAlignCenter;
		add: queryField;
		yourself.	
	rightBox := SpBoxLayout newLeftToRight
		hAlignEnd;
		vAlignCenter;
		add: onlyDeprecatedStepsCheckBox width: 90;
		add: onlyEmptyStepsCheckBox width: 90;
		yourself.	
	^ SpBoxLayout newLeftToRight
		vAlignCenter;
		spacing: 10;
		add: leftBox expand: false;
		add: middleBox expand: true;
		add: rightBox expand: false;
		yourself
]

{ #category : 'initialization' }
HeraStepFilterCriteriaPresenter >> initializePresenters [

	includeGivenStepsCheckBox := self newCheckBox
		label: 'Given';
		yourself.
	includeWhenStepsCheckBox := self newCheckBox
		label: 'When';
		yourself.
	includeThenStepsCheckBox := self newCheckBox
		label: 'Then';
		yourself.
	queryField := self newTextInput.
	onlyDeprecatedStepsCheckBox := self newCheckBox
		label: 'Deprecated';
		yourself.
	onlyEmptyStepsCheckBox := self newCheckBox
		label: 'Empty';
		yourself
]

{ #category : 'initialization' }
HeraStepFilterCriteriaPresenter >> modelChanged [

	| criteria |
	criteria := self model.
	includeGivenStepsCheckBox state: criteria includeGivenSteps.
	includeWhenStepsCheckBox state: criteria includeWhenSteps.
	includeThenStepsCheckBox state: criteria includeThenSteps.
	queryField text: criteria query.
	onlyDeprecatedStepsCheckBox state: criteria onlyDeprecatedSteps
]

{ #category : 'accessing' }
HeraStepFilterCriteriaPresenter >> stepFilterCriteria [

	^ self model
]
