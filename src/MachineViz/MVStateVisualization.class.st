Class {
	#name : #MVStateVisualization,
	#superclass : #ComposablePresenter,
	#instVars : [
		'stateLabel',
		'logViz',
		'titleLabel',
		'state'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVStateVisualization class >> defaultSpec [

	^SpecRowLayout composed
      newColumn: [ :col| 
			col 
				add: #titleLabel height: self toolbarHeight;
				add: #stateLabel height: self toolbarHeight;
				add: #logViz
		];
      yourself
]

{ #category : #initialization }
MVStateVisualization >> initializeWidgets [

	titleLabel := self newLabel.
	stateLabel := self newLabel. 
	logViz := self instantiate: MVLogVisualization.
	
	titleLabel label: 'Selected state:'.
	stateLabel label: 'No state selected'.
]

{ #category : #accessing }
MVStateVisualization >> logViz [
	^ logViz
]

{ #category : #accessing }
MVStateVisualization >> logViz: anObject [
	logViz := anObject
]

{ #category : #accessing }
MVStateVisualization >> state [
	^state
]

{ #category : #api }
MVStateVisualization >> state: aMVState [
	state := aMVState.
	
	self updateViz.
]

{ #category : #accessing }
MVStateVisualization >> stateLabel [
	^ stateLabel
]

{ #category : #accessing }
MVStateVisualization >> stateLabel: anObject [
	stateLabel := anObject
]

{ #category : #api }
MVStateVisualization >> title [
	^'State Visualization'
]

{ #category : #accessing }
MVStateVisualization >> titleLabel [
	^ titleLabel
]

{ #category : #accessing }
MVStateVisualization >> titleLabel: anObject [
	titleLabel := anObject
]

{ #category : #private }
MVStateVisualization >> updateViz [

	stateLabel label: state stateName.
	
	"state announcer when: MVAddedStatusOnState do: [ :ann| 
		logViz logs: state logs
	].

	state statuses ifNotEmpty: [ 
		logViz logs: state logs
	]"
]
