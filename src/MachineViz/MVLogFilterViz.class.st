Class {
	#name : #MVLogFilterViz,
	#superclass : #ComposablePresenter,
	#instVars : [
		'levelFilter',
		'nameFilter',
		'logViz',
		'separation'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVLogFilterViz class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col | 
			col 
				add: #nameFilter height: 300;
				add: #separation height: self toolbarHeight;
			 	add: #levelFilter height: 120;
				addSplitter.
		]
		yourself
]

{ #category : #api }
MVLogFilterViz >> filterLogs: aMVLogCollection [
	
	self nameFilterWithLogs: aMVLogCollection.
	self updateLogs.
]

{ #category : #initialization }
MVLogFilterViz >> initializeWidgets [

	levelFilter := self instantiate: MVLogLevelFilterViz.
	nameFilter := self instantiate: MVLogNameFilterViz.	
	separation := self newLabel.
		
	levelFilter filterViz: self.
	nameFilter filterViz: self.
]

{ #category : #accessing }
MVLogFilterViz >> levelFilter [
	^ levelFilter
]

{ #category : #accessing }
MVLogFilterViz >> levelFilter: anObject [
	levelFilter := anObject
]

{ #category : #accessing }
MVLogFilterViz >> logViz [

	^logViz 
]

{ #category : #accessing }
MVLogFilterViz >> logViz: aMVLogViz [

	logViz := aMVLogViz 
]

{ #category : #accessing }
MVLogFilterViz >> nameFilter [
	^ nameFilter
]

{ #category : #accessing }
MVLogFilterViz >> nameFilter: anObject [
	nameFilter := anObject
]

{ #category : #api }
MVLogFilterViz >> nameFilterWithLogs: aMVLogCollection [

	nameFilter items: (aMVLogCollection collect: [:log| log name ]) asSet asOrderedCollection sort

]

{ #category : #accessing }
MVLogFilterViz >> separation [
	^separation
]

{ #category : #api }
MVLogFilterViz >> updateLogs [
	
	"filter by levels"
	| filterLogs |
	filterLogs := logViz logs select: [:log| levelFilter levels includes: log level  ].
	
	"filter by names"
	filterLogs := filterLogs select: [ :log| nameFilter selectedItems includes: log name ].
	
	logViz showLogs: filterLogs.
]
