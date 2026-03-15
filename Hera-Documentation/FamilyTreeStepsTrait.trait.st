Trait {
	#name : 'FamilyTreeStepsTrait',
	#category : 'Hera-Documentation-Family Tree - Features',
	#package : 'Hera-Documentation',
	#tag : 'Family Tree - Features'
}

{ #category : 'helpers' }
FamilyTreeStepsTrait >> familyMemberNamed: aFamilyMemberName [

	^ (self stateAt: #familyMembers)
		detect: [ :each | each name = aFamilyMemberName ]
		ifNone: [ self error: ('Family member "{1}" is unknown.' format: { aFamilyMemberName }) ]
]

{ #category : 'steps' }
FamilyTreeStepsTrait >> stepAFamilyTree: aDataTree [
	"Assumption: single root."

	<heraStepDefinition: #(Given 'a family tree:')>

	| currentLevel family root familyMembers |
	currentLevel := 0.
	familyMembers := self stateAt: #familyMembers put: Dictionary new.
	family := Stack new.
	aDataTree data do: [ :dataTreeItem | | person |
		person := HeraExamplePerson new name: dataTreeItem text.
		familyMembers at: person name put: person.
		currentLevel = 0
			ifTrue: [ root := family push: person ]
			ifFalse: [
				currentLevel to: dataTreeItem level by: -1 do: [ :level | family pop ].
				family top addChild: person.
				family push: person ].
		currentLevel := dataTreeItem level ]
]

{ #category : 'steps' }
FamilyTreeStepsTrait >> stepIStartANewFamilyTree [

	<heraStepDefinition: #(When 'I start a new family tree')>

	HeraExampleFamilyTreePresenter new open
]

{ #category : 'steps' }
FamilyTreeStepsTrait >> stepIStartTheFamilyTreeApplicationOn: aFamilyMemberName [

	<heraStepDefinition: #(When match 'I start the Family Tree application on {string}')>

	HeraExampleFamilyTreePresenter new
		focusPerson: (self familyMemberNamed: aFamilyMemberName);
		open
]
