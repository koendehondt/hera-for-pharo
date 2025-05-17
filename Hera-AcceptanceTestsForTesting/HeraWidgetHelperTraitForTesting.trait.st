Trait {
	#name : 'HeraWidgetHelperTraitForTesting',
	#instVars : [
		'givenFieldLabelArgument',
		'givenButtonLabelArgument',
		'seenTheHomePage'
	],
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'as yet unclassified' }
HeraWidgetHelperTraitForTesting >> givenButtonLabelArgument [

	^ givenButtonLabelArgument
]

{ #category : 'as yet unclassified' }
HeraWidgetHelperTraitForTesting >> givenFieldLabelArgument [

	^ givenFieldLabelArgument
]

{ #category : 'as yet unclassified' }
HeraWidgetHelperTraitForTesting >> seenTheHomePage [

	^ seenTheHomePage
]

{ #category : 'as yet unclassified' }
HeraWidgetHelperTraitForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	givenFieldLabelArgument := fieldLabel
]

{ #category : 'as yet unclassified' }
HeraWidgetHelperTraitForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled "([^"]+)"')>

	givenButtonLabelArgument := buttonLabel
]

{ #category : 'as yet unclassified' }
HeraWidgetHelperTraitForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	seenTheHomePage := true
]
