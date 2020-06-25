Class {
	#name : #MVLogFilterCheckViz,
	#superclass : #ComposablePresenter,
	#instVars : [
		'level',
		'checkboxModel',
		'iconModel'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVLogFilterCheckViz class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | 
			row 
				add: #checkboxModel width: 70;
				add: #iconModel width: 20;
				addSplitter
		]
		yourself
]

{ #category : #api }
MVLogFilterCheckViz >> addLevel: aCollection [
	aCollection add: self level.
]

{ #category : #accessing }
MVLogFilterCheckViz >> checkboxModel [
	^ checkboxModel
]

{ #category : #accessing }
MVLogFilterCheckViz >> checkboxModel: anObject [
	checkboxModel := anObject
]

{ #category : #accessing }
MVLogFilterCheckViz >> iconModel [
	^ iconModel
]

{ #category : #accessing }
MVLogFilterCheckViz >> iconModel: anObject [
	iconModel := anObject
]

{ #category : #initialization }
MVLogFilterCheckViz >> initializeWidgets [

	checkboxModel := self newCheckBox.
	checkboxModel state: true.
	
	iconModel := self newImage.
		
	
]

{ #category : #accessing }
MVLogFilterCheckViz >> level [
	^ level
]

{ #category : #accessing }
MVLogFilterCheckViz >> level: aSymbol [
	level := aSymbol.
	
	checkboxModel label: aSymbol capitalized.
	iconModel image: (MVLog iconFromLevel: aSymbol)
]

{ #category : #api }
MVLogFilterCheckViz >> removeLevel: aCollection [

	aCollection remove: self level.
]

{ #category : #api }
MVLogFilterCheckViz >> whenActivatedDo: aBlock [
	checkboxModel whenActivatedDo: aBlock
]

{ #category : #api }
MVLogFilterCheckViz >> whenDeactivatedDo: aBlock [
	checkboxModel whenDeactivatedDo: aBlock
]
