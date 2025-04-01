Class {
	#name : 'HeraHelperForTesting',
	#superclass : 'HeraHelper',
	#instVars : [
		'seenTheHomePage',
		'givenFieldLabelArgument',
		'givenButtonLabelArgument'
	],
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'test api' }
HeraHelperForTesting >> givenButtonLabelArgument [

	^ givenButtonLabelArgument
]

{ #category : 'test api' }
HeraHelperForTesting >> givenFieldLabelArgument [

	^ givenFieldLabelArgument
]

{ #category : 'test api' }
HeraHelperForTesting >> seenTheHomePage [

	^ seenTheHomePage
]

{ #category : 'steps' }
HeraHelperForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	givenFieldLabelArgument := fieldLabel
]

{ #category : 'steps' }
HeraHelperForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled "([^"]+)"')>

	givenButtonLabelArgument := buttonLabel
]

{ #category : 'steps' }
HeraHelperForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	seenTheHomePage := true
]
