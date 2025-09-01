Trait {
	#name : 'HeraWidgetHelperTraitForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> givenButtonLabelArgument [

	^ self stateAt: #givenButtonLabelArgument
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> givenFieldLabelArgument [

	^ self stateAt: #givenFieldLabelArgument
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> seenTheHomePage [

	^ self stateAt: #seenTheHomePage
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	self stateAt: #givenFieldLabelArgument put: fieldLabel
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled "([^"]+)"')>

	self stateAt: #givenButtonLabelArgument put: buttonLabel
]

{ #category : 'accessing' }
HeraWidgetHelperTraitForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	self stateAt: #seenTheHomePage put: true
]
