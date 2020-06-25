Class {
	#name : #MVLogNameFilterViz,
	#superclass : #ComposablePresenter,
	#instVars : [
		'nameList',
		'selectAllButton',
		'deselectAllButton',
		'filterViz',
		'historySelection',
		'selectedAll'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVLogNameFilterViz class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col | 
			col add: #nameList.
			col newRow: [ :row| 
				row add: #selectAllButton.
				row add: #deselectAllButton
			] height: self buttonHeight
		]
		yourself
]

{ #category : #api }
MVLogNameFilterViz >> deselectAll [ 

	selectedAll := false.
	nameList resetSelection.
	self deselectAllHistory.
]

{ #category : #accessing }
MVLogNameFilterViz >> deselectAllButton [
	^ deselectAllButton
]

{ #category : #accessing }
MVLogNameFilterViz >> deselectAllButton: anObject [
	deselectAllButton := anObject
]

{ #category : #private }
MVLogNameFilterViz >> deselectAllHistory [
	historySelection associationsDo: [ :assoc| assoc value: false ].
]

{ #category : #accessing }
MVLogNameFilterViz >> filterViz [
	^filterViz
]

{ #category : #accessing }
MVLogNameFilterViz >> filterViz: aMVFilterViz [
	filterViz := aMVFilterViz
]

{ #category : #initialization }
MVLogNameFilterViz >> initialize [ 
	super initialize.
	historySelection := Dictionary new.
	selectedAll := true.
]

{ #category : #initialization }
MVLogNameFilterViz >> initializePresenter [


	selectAllButton whenActionPerformedDo: [ self selectAll ].
	deselectAllButton whenActionPerformedDo: [ self deselectAll ].
	
	nameList whenSelectionChanged: [self updateNameFilter ].
]

{ #category : #initialization }
MVLogNameFilterViz >> initializeWidgets [

	nameList := self instantiate: ListPresenter .
	selectAllButton := self newButton.
	deselectAllButton := self newButton.
	
	nameList beMultipleSelection.
	nameList autoDeselect: false.
	selectAllButton label: 'Select All'.
	deselectAllButton label: 'Deselect All'.
]

{ #category : #api }
MVLogNameFilterViz >> items: aCollection [
	|copiedHistory|

	nameList items: aCollection.
	aCollection do: [ :item| historySelection at: item ifAbsentPut: selectedAll ].
	copiedHistory := historySelection copy.

	"using private methods to no call for callbacks each time"
	nameList listItems withIndexDo: [ :each :i | nameList setSelectionStateFor: i at: false ].
	
	copiedHistory associationsDo: [ :assoc| 
		|index|
		index := nameList listItems indexOf: assoc key.
		(index == 0) ifFalse: [ 
			nameList setSelectionStateFor: index at: assoc value.
		].
	].
	nameList changed: #listElementAt:.
	historySelection := copiedHistory.
]

{ #category : #accessing }
MVLogNameFilterViz >> nameList [
	^ nameList
]

{ #category : #accessing }
MVLogNameFilterViz >> nameList: anObject [
	nameList := anObject
]

{ #category : #api }
MVLogNameFilterViz >> selectAll [

	selectedAll := true.
	nameList selectAll.
	self selectAllHistory.
]

{ #category : #accessing }
MVLogNameFilterViz >> selectAllButton [
	^ selectAllButton
]

{ #category : #accessing }
MVLogNameFilterViz >> selectAllButton: anObject [
	selectAllButton := anObject
]

{ #category : #private }
MVLogNameFilterViz >> selectAllHistory [
	historySelection associationsDo: [ :assoc| assoc value: true ].
]

{ #category : #api }
MVLogNameFilterViz >> selectedItems [

	^nameList selectedItems
]

{ #category : #initialization }
MVLogNameFilterViz >> updateAllHistory [

	nameList getList do:[:item|
		historySelection at: item put: false.
	].
	nameList selectedItems do: [ :item|
		historySelection at: item put: true	 
	]
]

{ #category : #api }
MVLogNameFilterViz >> updateLogs [
	filterViz updateLogs
]

{ #category : #api }
MVLogNameFilterViz >> updateNameFilter [
	
	self updateAllHistory.
	self updateLogs.
]
