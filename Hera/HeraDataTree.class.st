Class {
	#name : 'HeraDataTree',
	#superclass : 'Object',
	#instVars : [
		'data'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HeraDataTree class >> from: anArrayOfAssociations [

	^ self new initializeDataFrom: anArrayOfAssociations
]

{ #category : 'comparing' }
HeraDataTree >> = other [

	^ self class = other class and: [ self data = other data ]
]

{ #category : 'private' }
HeraDataTree >> collectDataTreeItemsFrom: anArrayOfAssociations [

	| accu |
	accu := OrderedCollection new.
	self collectDataTreeItemsFrom: anArrayOfAssociations level: 1 in: accu.
	^ accu
]

{ #category : 'private' }
HeraDataTree >> collectDataTreeItemsFrom: anArrayOfAssociations level: level in: aCollection [

	anArrayOfAssociations do: [ :each |
		aCollection add: (HeraDataTreeItem new level: level; text: each key).
		self collectDataTreeItemsFrom: each value level: level + 1 in: aCollection ]
]

{ #category : 'accessing' }
HeraDataTree >> data [

	^ data
]

{ #category : 'initialization' }
HeraDataTree >> data: anArrayOfDataTreeItems [

	data := anArrayOfDataTreeItems
]

{ #category : 'private' }
HeraDataTree >> dataTreeNodesFrom: anArrayOfAssociations level: level [

	^ anArrayOfAssociations collect: [ :each |
		HeraDataTreeNode new
			level: level;
			text: each key;
			children: (self dataTreeNodesFrom: each value level: level + 1) ]
]

{ #category : 'private' }
HeraDataTree >> deepestLevel [

	^ data inject: 0 into: [ :accu :each | accu max: each level ]
]

{ #category : 'private' }
HeraDataTree >> deepestLevelIn: arrayOfDataTreeNodes [

	^ arrayOfDataTreeNodes inject: 0 into: [ :accu : each |
		(self deepestLevelIn: each children) max: (each level max: accu) ]
]

{ #category : 'initialization' }
HeraDataTree >> initializeDataFrom: anArrayOfAssociations [

	self data: (self collectDataTreeItemsFrom: anArrayOfAssociations)
]

{ #category : 'printing' }
HeraDataTree >> printDataTreeNodes: arrayOfDataTreeItems formattedOn: aStream indentation: aNumberOfTabs deepestLevel: deepestLevel [

	| arrows |
	arrows := String new: 4 withAll: $>.
	arrayOfDataTreeItems withIndexDo: [ :each :index |
		(each level = 1 and: [ index = 1]) ifFalse: [ aStream cr ].
		aStream
			tab: aNumberOfTabs;
			nextPutAll: ((String new: each level withAll: $>) padRightTo: deepestLevel with: Character space);
			space;
			nextPutAll: (String new: (each level - 1) * 2 withAll: Character space);
			nextPutAll: each text.
		self printDataTreeNodes: each children formattedOn: aStream indentation: aNumberOfTabs deepestLevel: deepestLevel ]
]

{ #category : 'printing' }
HeraDataTree >> printFormattedOn: aStream indentation: aNumberOfTabs [
	
	| deepestLevel |
	deepestLevel := self deepestLevel.
	data withIndexDo: [ :each :index |
		(each level = 1 and: [ index = 1]) ifFalse: [ aStream cr ].
		aStream
			tab: aNumberOfTabs;
			nextPutAll: ((String new: each level withAll: $>) padRightTo: deepestLevel with: Character space);
			space;
			nextPutAll: (String new: (each level - 1) * 2 withAll: Character space);
			nextPutAll: each text ]
]

{ #category : 'printing' }
HeraDataTree >> printOn: aStream [

	self printFormattedOn: aStream indentation: 0
]
