Class {
	#name : 'HeraFeatureBrowserAcceptanceTest',
	#superclass : 'HeraSelfAcceptanceTest',
	#category : 'Hera-AcceptanceTests',
	#package : 'Hera-AcceptanceTests'
}

{ #category : 'accessing' }
HeraFeatureBrowserAcceptanceTest class >> nameInBrowser [

	^ 'Hera Feature Browser'
]

{ #category : 'features' }
HeraFeatureBrowserAcceptanceTest >> featureBasicBrowsing [

	<heraFeature: 'Basic browsing'>

	^ (self feature: 'Basic browsing')
		description: {
			'In order to read features' .
			'As a test author' .
			'I want to browse the available features' };
		scenarios: {
			(self scenario: 'Opening the Feature Browser from the Pharo menu bar')
				when: 'I select the "Browse >> Hera Feature Browser" menu item from the Pharo menu bar';
				then: 'the "Hera Feature Browser" window opens';
				then: 'I see an empty list of features' .
			(self scenario: 'Browsing features')
				when: 'I select the "Browse >> Hera Documentation & Examples" menu item from the Pharo menu bar';
				then: 'the "Documentation & Examples" window opens';
				then: 'I see the following "Features" tree:' with: (self dataTree: {
					'Spec documentation and examples' -> {
						'Checkboxes' -> { } .
						'Fields' -> { } .
						'Lists' -> { } .
						'Menus' -> { } .
						'Radio buttons' -> { } .
						'Trees' -> { } .
						'Windows' -> { } } });
				when: 'I select "Spec documentation and examples >> Checkboxes" in the "Features" tree';
				then: 'I see this script:' with: (self docString: {
					'Feature: Checkboxes' .
					'' .
					'	Background:' .
					'		Given a family tree:' .
					'			> John' .
					'' .
					'	Scenario: Checked state, unchecked state, checking and unchecking' .
					'		When I start the Family Tree application on "John"' .
					'		Then the "Family tree of John" window opens' .
					'		And I select "John" in the "Family" tree' .
					'		Then the "Disabled" checkbox is unchecked' .
					'		When I check the "Disabled" checkbox' .
					'		Then the "Disabled" checkbox is checked' .
					'		When I uncheck the "Disabled" checkbox' .
					'		Then the "Disabled" checkbox is unchecked' .
					'' .
					'' });
				when: 'I select "Spec documentation and examples >> Fields" in the "Features" tree';
				then: 'I see this script:' with: (self docString: {
					'Feature: Fields' .
					'' .
					'	Background:' .
					'		Given a family tree:' .
					'			>   John' .
					'			>>    Jane' .
					'			>>>     William' .
					'			>>    Mary' .
					'			>>    Charles' .
					'' .
					'	Scenario: Reading' .
					'		When I start the Family Tree application on "John"' .
					'		Then the "Family tree of John" window opens' .
					'		And I select "John" in the "Family" tree' .
					'		Then I see "John" in the "Name" field' .
					'' .
					'	Scenario: Filling in' .
					'		When I start the Family Tree application on "John"' .
					'		Then the "Family tree of John" window opens' .
					'		And I select "John" in the "Family" tree' .
					'		And I fill in "John" in the "Name" field' .
					'		Then I see "John" in the "Name" field' .
					'' .
					'' }) }
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepISeeAnEmptyListOfFeatures [

	<heraStepDefinition: #(Then 'I see an empty list of features')>

	self assertEmptyTree: 'Features'
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepISeeThisScript: aDocString [

	<heraStepDefinition: #(Then 'I see this script:')>

	self assertStringContentsOf: 'Script' equals: aDocString asString
]
