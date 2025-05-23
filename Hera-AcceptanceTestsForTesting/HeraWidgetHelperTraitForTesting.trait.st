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

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> givenButtonLabelArgument [

	^ givenButtonLabelArgument
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> givenFieldLabelArgument [

	^ givenFieldLabelArgument
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> seenTheHomePage [

	^ seenTheHomePage
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	givenFieldLabelArgument := fieldLabel
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled "([^"]+)"')>

	givenButtonLabelArgument := buttonLabel
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	seenTheHomePage := true
]
