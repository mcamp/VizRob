Class {
	#name : #MVVarsVisualization,
	#superclass : #ComposablePresenter,
	#instVars : [
		'listModel'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVVarsVisualization class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #listModel];
		yourself
]

{ #category : #initialization }
MVVarsVisualization >> initializeWidgets [
	listModel := self newList.
	listModel displayBlock: [ :var| var key asString, ' >> ', var value asString ]
]

{ #category : #accessing }
MVVarsVisualization >> listModel [
	^listModel
]

{ #category : #api }
MVVarsVisualization >> title [
	^'Variables'
]

{ #category : #update }
MVVarsVisualization >> vars: aDictionary [
	self listModel items: aDictionary associations.
]
