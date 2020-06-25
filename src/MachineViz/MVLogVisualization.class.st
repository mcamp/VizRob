Class {
	#name : #MVLogVisualization,
	#superclass : #ComposablePresenter,
	#instVars : [
		'listModel',
		'logs',
		'filterViz',
		'selectedLabel',
		'logInformation',
		'typeLabel'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVLogVisualization class >> defaultSpec [

	^ SpecLayout composed
		newRow: [ :row |
			row  
				newColumn:[:tcol|
					tcol add: #typeLabel height: self toolbarHeight - 15.
					tcol add: #selectedLabel height: self toolbarHeight - 10 .
					tcol add: #filterViz 
				] left: 0 right: 0.70;
				addSplitter;
				newColumn: [:tcol|
					tcol add: #listModel.
					tcol add: #logInformation.
				] left: 0.30 right: 0
		];
		yourself
]

{ #category : #accessing }
MVLogVisualization >> filterViz [
	^ filterViz
]

{ #category : #accessing }
MVLogVisualization >> filterViz: anObject [
	filterViz := anObject
]

{ #category : #initialization }
MVLogVisualization >> initializePresenter [

	listModel whenSelectedItemChanged: [ :log|
		logInformation showLog: log	
	]
	
]

{ #category : #initialization }
MVLogVisualization >> initializeWidgets [
	listModel := self newList.
	filterViz := self instantiate: MVLogFilterViz. 
	typeLabel := self newLabel.
	selectedLabel := self instantiate: MVOverflowLabelPresenter.
	logInformation := self instantiate: MVLogInformation.
	
	filterViz logViz: self.
	
	listModel icons: [ :e| e icon].
	
	
]

{ #category : #accessing }
MVLogVisualization >> listModel [
	^ listModel
]

{ #category : #accessing }
MVLogVisualization >> listModel: anObject [
	listModel := anObject
]

{ #category : #api }
MVLogVisualization >> logContainer: aMVContainer [

	self typeLabel label: aMVContainer typeLabel , ':'.
	self selectedLabel label: aMVContainer vizLabel.
]

{ #category : #accessing }
MVLogVisualization >> logInformation [
	^ logInformation 
]

{ #category : #accessing }
MVLogVisualization >> logs [
	^logs
]

{ #category : #update }
MVLogVisualization >> logs: aMVLogCollection [
	
	logs := aMVLogCollection.
	self filterViz filterLogs: aMVLogCollection.
]

{ #category : #accessing }
MVLogVisualization >> selectedLabel [
	^ selectedLabel
]

{ #category : #accessing }
MVLogVisualization >> selectedLabel: anObject [
	selectedLabel := anObject
]

{ #category : #update }
MVLogVisualization >> showLogs: aCollection [
	"on new logs, always select first"
	self listModel items: aCollection reverse.
	self listModel setIndex: 1.
]

{ #category : #api }
MVLogVisualization >> title [
	^'Logs'
]

{ #category : #accessing }
MVLogVisualization >> typeLabel [
	^ typeLabel
]

{ #category : #accessing }
MVLogVisualization >> typeLabel: anObject [
	typeLabel := anObject
]

{ #category : #api }
MVLogVisualization >> update [

	self flag: #todo
]
