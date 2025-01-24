Trait {
	#name : 'HeraWidgetHelperTraitForTesting',
	#instVars : [
		'givenFieldLabelArgument',
		'givenButtonLabelArgument',
		'seenTheHomePage'
	],
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'test api' }
HeraWidgetHelperTraitForTesting >> givenButtonLabelArgument [

	^ givenButtonLabelArgument
]

{ #category : 'test api' }
HeraWidgetHelperTraitForTesting >> givenFieldLabelArgument [

	^ givenFieldLabelArgument
]

{ #category : 'test api' }
HeraWidgetHelperTraitForTesting >> seenTheHomePage [

	^ seenTheHomePage
]

{ #category : 'steps' }
HeraWidgetHelperTraitForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	givenFieldLabelArgument := fieldLabel
]

{ #category : 'steps' }
HeraWidgetHelperTraitForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled "([^"]+)"')>

	givenButtonLabelArgument := buttonLabel
]

{ #category : 'steps' }
HeraWidgetHelperTraitForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	seenTheHomePage := true
]
