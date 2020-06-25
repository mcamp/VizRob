Class {
	#name : #MVVizRobMachine,
	#superclass : #ComposablePresenter,
	#instVars : [
		'machineview',
		'updater',
		'slider',
		'forwardStep',
		'backwardStep',
		'typeButton',
		'errorButton',
		'freqButton',
		'vizLabel',
		'vizType',
		'emptyLabel',
		'borderCheckbox',
		'coverageCheckbox',
		'currentMachineViz',
		'menu',
		'currentViz',
		'oldRTElement',
		'followCheckbox',
		'fromUpdate'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVVizRobMachine class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed 
		
		newColumn: [:tcol|
			tcol newRow: [:trow|
				trow add: #vizLabel width: (self buttonWidth).
				trow add: #typeButton width: (self buttonWidth).
				trow add: #errorButton width: (self buttonWidth).
				trow add: #freqButton width: (self buttonWidth).

				trow add: #menu left: 80 right: 0.
			]height: (self toolbarHeight).
			tcol newRow: [:trow|
				trow add: #followCheckbox width: 65.
				trow add: #borderCheckbox width: 200.
				trow add: #coverageCheckbox width: 125.
				trow addSplitter.
			]height: (self toolbarHeight).
			tcol newRow: [:trow| trow add: #machineview ].
			tcol newRow: [ :trow| 
				trow add: #backwardStep width: (self buttonWidth).
				trow add: #slider.
				trow add: #forwardStep width: (self buttonWidth).
			] height: (self toolbarHeight)
		].
]

{ #category : #'private - visualization - toggle' }
MVVizRobMachine >> applyOptionsOnView: aView [
	self toggleNSMBorderOnView: aView.
	self toggleCoverageOnView: aView
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> arrowedLineOn: aRTMondrian [

	| arrowedLine |
	arrowedLine := RTArrowedLine new.
	arrowedLine 	head size: 8.
	arrowedLine 	
		headOffset: 0.9;
		withShorterDistanceAttachPoint.
	aRTMondrian shape: arrowedLine.
	aRTMondrian shape color: Color blue trans.
	aRTMondrian edges source: self currentMachineViz transitions connectFrom: #from to: #to.
]

{ #category : #accessing }
MVVizRobMachine >> backwardStep [
	^ backwardStep
]

{ #category : #accessing }
MVVizRobMachine >> backwardStep: anObject [
	backwardStep := anObject
]

{ #category : #'api - actions' }
MVVizRobMachine >> backwardStepAction [
	slider value > 0	ifTrue: [ slider value: slider value - 1 ].
]

{ #category : #accessing }
MVVizRobMachine >> borderCheckbox [
	^ borderCheckbox
]

{ #category : #accessing }
MVVizRobMachine >> borderCheckbox: anObject [
	borderCheckbox := anObject
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> buildMachine: aRTMondrian [

	aRTMondrian build.
	
	self currentMachineViz isDrawn
		ifTrue: [ self restoreCacheNodes: aRTMondrian ]
		ifFalse: [ 
			self currentMachineViz isDrawn: true.
			self cacheNodes: aRTMondrian.
		].
	self drawCurrentStates: aRTMondrian.
]

{ #category : #initialization }
MVVizRobMachine >> buildMachineOnView: aView andCanvas: aCanvas [
	self currentMachineViz ifNone: [^ self ].
	vizType == #type ifTrue: [ self renderMachineWithTypeLogsOn: aView ].
	vizType == #error ifTrue: [ self renderMachineWithErrorLogsOn: aView ].
	vizType == #freq ifTrue: [ self renderMachineWithFrecuencyOn: aView ].
	
	self applyOptionsOnView: aView.
	self centerView: aView.
]

{ #category : #'private - visualization - cache' }
MVVizRobMachine >> cacheNewPosition: element [

	element model position: element position	
]

{ #category : #'private - visualization - cache' }
MVVizRobMachine >> cacheNodes: aRTMondrian [

	aRTMondrian currentElements do: [ :elem| 
		self cacheNewPosition: elem	
	]
]

{ #category : #'visualization - update' }
MVVizRobMachine >> centerView [

	self centerView: machineview widget view.
]

{ #category : #'visualization - update' }
MVVizRobMachine >> centerView: aView [

	MVUpdateAnimation action:[:v| v canvas focusOnCenterScaled] on: aView.
]

{ #category : #'private - update' }
MVVizRobMachine >> checkFollowIfMax [

	(slider max == slider value) 
		ifTrue: [ self startFollow ]
		ifFalse: [ self stopFollow ]
]

{ #category : #'visualization - update' }
MVVizRobMachine >> clickedOnElement: aRTElement [

	self owner ifNotNil: [ self owner selectedContainer: aRTElement model ].
	self selectedBorder: aRTElement.
	self switchVizFromState: aRTElement model.
	
	
]

{ #category : #accessing }
MVVizRobMachine >> coverageCheckbox [
	^ coverageCheckbox
]

{ #category : #accessing }
MVVizRobMachine >> coverageCheckbox: anObject [
	coverageCheckbox := anObject
]

{ #category : #accessing }
MVVizRobMachine >> currentMachineViz [
	^ currentMachineViz
]

{ #category : #accessing }
MVVizRobMachine >> currentMachineViz: anObject [
	currentMachineViz := anObject
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> drawCurrentStates: aRTMondrian [

	| view |
	view := aRTMondrian view.

	aRTMondrian currentElements do: [ :elem| 
		elem model isRunningOnUpdater ifTrue: [
			view add: (self ellipseOverElement: elem).
		]
	]
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> ellipseOverElement: aRTElement [

	| width2 height2 diameter ellipse element |
	width2 := aRTElement width * aRTElement width / 4.
	height2 := aRTElement height * aRTElement height / 4.
	diameter  := (width2 + height2) sqrt * 2.
	ellipse := RTEllipse new.
	ellipse width: diameter.
	ellipse height:  diameter.
	ellipse color: (Color gray alpha: 0).
	ellipse borderColor: Color black.
	ellipse borderWidth: 2.
	element := ellipse element.
	element translateTo: aRTElement model position.
	^ element.
]

{ #category : #accessing }
MVVizRobMachine >> emptyLabel [
	^ emptyLabel
]

{ #category : #accessing }
MVVizRobMachine >> emptyLabel: anObject [
	emptyLabel := anObject
]

{ #category : #accessing }
MVVizRobMachine >> errorButton [
	^ errorButton
]

{ #category : #accessing }
MVVizRobMachine >> errorButton: anObject [
	errorButton := anObject
]

{ #category : #api }
MVVizRobMachine >> extent [
	 ^1000@700
]

{ #category : #accessing }
MVVizRobMachine >> followCheckbox [
	^ followCheckbox
]

{ #category : #accessing }
MVVizRobMachine >> followCheckbox: anObject [
	followCheckbox := anObject
]

{ #category : #testing }
MVVizRobMachine >> followedExecution [

	^ followCheckbox state
]

{ #category : #accessing }
MVVizRobMachine >> forwardStep [
	^ forwardStep
]

{ #category : #accessing }
MVVizRobMachine >> forwardStep: anObject [
	forwardStep := anObject
]

{ #category : #'api - actions' }
MVVizRobMachine >> forwardStepAction [
	slider value < slider max ifTrue: [ slider value: slider value + 1 ].
]

{ #category : #accessing }
MVVizRobMachine >> freqButton [
	^ freqButton
]

{ #category : #accessing }
MVVizRobMachine >> freqButton: anObject [
	freqButton := anObject
]

{ #category : #'accessing - colors' }
MVVizRobMachine >> frequencyBorderColor [
	^ Color gray
]

{ #category : #'visualization - testing' }
MVVizRobMachine >> frequencyVisualizationPresented [
 ^ vizType == #freq
]

{ #category : #initialization }
MVVizRobMachine >> initialize [ 
	super initialize.

	vizType := #type.
	fromUpdate := false.
]

{ #category : #initialization }
MVVizRobMachine >> initializePresenter [
	backwardStep action: [ self backwardStepAction ].
	forwardStep action: [ self forwardStepAction ].
	
	typeButton action: [ vizType := #type. machineview refresh ].
	errorButton action: [ vizType := #error. machineview refresh ].
	freqButton action: [ vizType := #freq. machineview refresh ].
	
	borderCheckbox
		whenChangedDo: [ MVUpdateAnimation
				action: [ :v | self applyOptionsOnView: v ]
				on: machineview widget view ].
	coverageCheckbox
		whenChangedDo: [ MVUpdateAnimation
				action: [ :v | self applyOptionsOnView: v ]
				on: machineview widget view ].
			
	slider whenValueChangedDo: [ self updateUpdater ]
]

{ #category : #initialization }
MVVizRobMachine >> initializeWidgets [
	
	machineview := self instantiate: RoassalModel.
	forwardStep := self newButton.
	backwardStep := self newButton.
	slider := self newSlider.
	vizLabel := self newLabel.
	typeButton := self newButton.
	errorButton := self newButton.
	freqButton := self newButton.
	emptyLabel := self newLabel.
	
	followCheckbox := self newCheckBox.
	borderCheckbox := self newCheckBox.
	coverageCheckbox := self newCheckBox.
	
	forwardStep label: 'Forward'.
	backwardStep label: 'Backward'.
	
	vizLabel label: 'Visualization'.
	typeButton label: 'Type of Logs'.
	errorButton label: 'Error Logs'.
	freqButton label: 'Frequency'.
	
	followCheckbox label: 'Follow'.
	followCheckbox state: true.
	borderCheckbox label: 'Toogle Nested Machine Border'.
	borderCheckbox state: true.
	coverageCheckbox label: 'Toogle Coverage'.
	
	slider quantum: 1.
	
	self prepareMenu.
	
	machineview script: [:view :canvas| self buildMachineOnView: view andCanvas: canvas.].
]

{ #category : #'private - update' }
MVVizRobMachine >> keepSlider [
	
	slider value: updater stepPosition.
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> layoutOn: aRTMondrian [

	self currentMachineViz isDrawn ifFalse:[
		aRTMondrian layout force charge: -2000.
	]
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> machinePathMenu: aRTMondrian [

	| b machines machine |
	b := RTMenuBuilder new view: aRTMondrian view.
	machines := OrderedCollection new.
	machine := self currentMachineViz.
	machines add: machine.
	[machine isRoot] whileFalse: [
		machine := machine parent parent. 
		machines add: machine.
	].

	machines reverse do: [ :mach| 
		b menu: mach shortName callback: [self switchVizTo: mach ]
	].

	b render
]

{ #category : #accessing }
MVVizRobMachine >> machineview [
	^ machineview
]

{ #category : #accessing }
MVVizRobMachine >> machineview: anObject [
	machineview := anObject
]

{ #category : #'private - update' }
MVVizRobMachine >> maxSlider [

	updater maxStep.
	slider value: updater stepPosition.
]

{ #category : #accessing }
MVVizRobMachine >> menu [
	^ menu
]

{ #category : #accessing }
MVVizRobMachine >> menu: anObject [
	menu := anObject
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> normalizeHeight: aBlock on: aRTMondrian [

	aRTMondrian normalizer normalizeHeight: aBlock min: 10 max: 40.
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> normalizeLogs: aRTMondrian [

	self normalizeWidth: [ :n| n stepLogs size] on: aRTMondrian.
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> normalizeTime: aRTMondrian [

	self normalizeHeight: [ :n | n stepTotalTime ]  on: aRTMondrian.
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> normalizeWidth: aBlock on: aRTMondrian [

	aRTMondrian normalizer normalizeWidth: aBlock min: 10 max: 40.
]

{ #category : #'accessing - colors' }
MVVizRobMachine >> nsmBorderColor [
	^ Color green
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> paintNSMBordersOnView: aView [

	(aView elements 
		select: [:e| e model class = MVState and: [e model hasMachine]])
			select: [ :e| 
				coverageCheckbox state
					ifTrue:[(self updater rootMachine allNonExecutedStates includes: e model) not]
					ifFalse: [ true ]]
			thenDo:[:e| e trachelShape strokePaint: self nsmBorderColor].
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> prepareCommonViz: aRTMondrian [
	|nodesViz|
	
	aRTMondrian interaction highlightNeighbors: #outgoingStates.
	
	nodesViz := aRTMondrian nodes: self currentMachineViz allStatesButNone.
	nodesViz do: [ :element |
		element when: TRMouseClick do: [ :click | self clickedOnElement: element].
		element when: TRMouseDragEnd do: [:event| self cacheNewPosition: element]
	].

	self arrowedLineOn: aRTMondrian.
	self normalizeTime: aRTMondrian.
	self normalizeLogs: aRTMondrian.
	self layoutOn: aRTMondrian.
	self toggleNSMBorderOnView: aRTMondrian view.
	self toggleCoverageOnView: aRTMondrian view.
	self machinePathMenu: aRTMondrian.
	aRTMondrian view @ RTDraggableView.
	
	^nodesViz
]

{ #category : #initialization }
MVVizRobMachine >> prepareMenu [

	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Zoom In';
						icon: (self iconNamed: #glamorousZoomIn);
						action: [ RTZoomInMove on: machineview widget view]].
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Zoom Out';
						icon: (self iconNamed: #glamorousZoomOut);
						action: [ RTZoomOutMove on: machineview widget view ]].
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Center';
						icon: (self iconNamed: #glamorousZoomToFit);
						action: [self centerView]]]
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> removeNSMBordersOnView: aView [

	aView elements 
		select: [:e| e model class = MVState] 
		thenDo: [:e| 
			self frequencyVisualizationPresented 
				ifTrue: [ e trachelShape strokePaint: self frequencyBorderColor]
				ifFalse: [ e trachelShape noBorder]
			].
	aView signalUpdate
]

{ #category : #'visualization - machines' }
MVVizRobMachine >> renderMachineWithErrorLogsOn: aView [
	| b lb |
	b := RTMondrian new.
	b view: aView.
	b shape box size: 20.

	self prepareCommonViz: b.
	b normalizer 
		normalizeColor: [ :n | n stepLogs errors size ]
			using: (Array with: Color gray with: Color red) min: 0.
			
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: self currentMachineViz machineName.
	lb
		addRectanglePolymetricWidth: '# Logs'
		height: 'Execution Time'
		box: 'a state'.
	lb addColorFadingFrom: Color gray to: Color red text: '# Error Logs'.
	lb left.
	lb build.
	
	self buildMachine: b
]

{ #category : #'visualization - machines' }
MVVizRobMachine >> renderMachineWithFrecuencyOn: aView [	
	| b lb |
	b := RTMondrian new.
	b view: aView.
	
	b shape box 
		size: 20;
		borderColor: Color gray.

	self prepareCommonViz: b.
	b normalizer 
		normalizeColor: [ :n | n stepExecutedTimes ] 
			using: (Array with: Color white with: Color black) min: 0.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: self currentMachineViz machineName.
	lb addRectanglePolymetricWidth: '# Logs' height: 'Execution Time' box: 'a state'.
	lb addColorFadingFrom: Color white to: Color black text: '# executions'.
	lb left.
	lb build.

	self buildMachine: b
]

{ #category : #'visualization - machines' }
MVVizRobMachine >> renderMachineWithTypeLogsOn: aView [	
	| b lb |
	b := RTMondrian new.
	b view: aView.
	
	b shape box 
		if: [ :st | st stepLogs hasWarnings] color: Color yellow;
		if: [ :st | st stepLogs hasErrors ] color: Color red;
		size: 20.

	self prepareCommonViz: b.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: self currentMachineViz machineName.
	lb addRectanglePolymetricWidth: '# Logs' height: 'Execution Time' box: 'a state'.
	lb addColor: Color red text: 'Has Error Logs'.
	lb addColor: Color yellow text: 'Has Warning Logs'.
	lb left.
	lb build.

	self buildMachine: b
	
]

{ #category : #'private - visualization - cache' }
MVVizRobMachine >> restoreCacheNodes: aRTMondrian [

	aRTMondrian currentElements do: [ :elem|
		elem translateTo: elem model position
	]
	
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> selectedBorder: aRTElement [
	oldRTElement ifNotNil: [
		oldRTElement trachelShape strokePaint: aRTElement trachelShape strokePaint.
	].
	aRTElement trachelShape strokePaint: Color blue.
	oldRTElement := aRTElement.
	MVUpdateAnimation on: machineview widget view.
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> showAllStatesOnView: aView [

	| nonExecutedStates  |
	nonExecutedStates := self updater rootMachine allNonExecutedStates.
	aView elements 
		select: [ :e| 
			e model class = MVState and:[
				nonExecutedStates includes: e model
			]
		]
		thenDo:[:e| 
			e color: (e color alpha: 1).
			e trachelShape strokePaint ifNotNil:[
				e trachelShape strokePaint: (e trachelShape strokePaint alpha: 1)
			]
		].

	aView edges 
		select:[:e| |out in|
			out := e model key class = MVState and:[nonExecutedStates includes: e model key].
			in := e model value class = MVState and:[nonExecutedStates includes: e model value].
			out or: [in]] 
		thenDo:[:e| 
			e trachelShape allColor: (e trachelShape color alpha: 0.4)].
]

{ #category : #'private - visualization - helpers' }
MVVizRobMachine >> showExecutedStatesOnView: aView [

	| nonExecutedStates |
	nonExecutedStates := self updater rootMachine allNonExecutedStates.
	aView elements 
		select: [ :e| 
			e model class = MVState and:[nonExecutedStates includes: e model]]
	 	thenDo:[:e| 
			e color: (e color alpha: 0.05).
			e trachelShape strokePaint ifNotNil:[
				e trachelShape strokePaint: (e trachelShape strokePaint alpha: 0.05)
			]
		].

	aView edges 
		select:[:e| |out in|
			out := e model key class = MVState and:[nonExecutedStates includes: e model key].
			in := e model value class = MVState and:[nonExecutedStates includes: e model value].
			out or: [in]] 
		thenDo:[:e| 
			e trachelShape allColor: (e trachelShape color alpha: 0.05)].
]

{ #category : #accessing }
MVVizRobMachine >> slider [
	^ slider
]

{ #category : #accessing }
MVVizRobMachine >> slider: anObject [
	slider := anObject
]

{ #category : #api }
MVVizRobMachine >> startFollow [
	followCheckbox state: true.
]

{ #category : #api }
MVVizRobMachine >> stopFollow [
	followCheckbox state: false.
]

{ #category : #'visualization - update' }
MVVizRobMachine >> switchVizFromState: aMVState [

	aMVState hasMachine ifFalse: [ ^ self ].
	self switchVizTo: aMVState machine
]

{ #category : #'visualization - update' }
MVVizRobMachine >> switchVizTo: aMVMachine [

	currentMachineViz := aMVMachine.
	self updateOwner: aMVMachine.
	self updateUpdater
]

{ #category : #api }
MVVizRobMachine >> title [
	 ^'VizRob'
]

{ #category : #'private - visualization - toggle' }
MVVizRobMachine >> toggleCoverageOnView: aView [ 

	coverageCheckbox state 
		ifFalse: [ 	self showAllStatesOnView: aView]
		ifTrue: [ self showExecutedStatesOnView: aView ].
]

{ #category : #'private - visualization - toggle' }
MVVizRobMachine >> toggleNSMBorderOnView: aView [

	borderCheckbox state 
		ifTrue:[ 
			self paintNSMBordersOnView: aView.			
		]
		ifFalse: [ 
			self removeNSMBordersOnView: aView. 
		]
]

{ #category : #accessing }
MVVizRobMachine >> typeButton [
	^ typeButton
]

{ #category : #accessing }
MVVizRobMachine >> typeButton: anObject [
	typeButton := anObject
]

{ #category : #api }
MVVizRobMachine >> update [

	self update: true.
]

{ #category : #api }
MVVizRobMachine >> update: updateMachineBoolean [

	fromUpdate := true.
	currentMachineViz ifNone: [  
		currentMachineViz := self updater rootMachine.	
	].
	self updateSlider.
	updateMachineBoolean ifTrue:[self updateMachineViz].
	fromUpdate := false.
]

{ #category : #'private - update' }
MVVizRobMachine >> updateMachineViz [

	machineview refresh.
]

{ #category : #'visualization - update' }
MVVizRobMachine >> updateOwner: aMVContainer [
	self owner ifNotNil: [ self owner selectedContainer: aMVContainer ]
]

{ #category : #'private - update' }
MVVizRobMachine >> updateSlider [

	slider max: updater totalSteps.
	self followedExecution 
		ifTrue: [ self maxSlider]
		ifFalse: [ self keepSlider ].
]

{ #category : #'visualization - update' }
MVVizRobMachine >> updateUpdater [

	fromUpdate ifTrue: [ ^ self ].
	self updater currentStep: slider value.
	self owner ifNotNil: [ self owner updaterSignal ].
	self checkFollowIfMax.		
	machineview refresh.
	
]

{ #category : #accessing }
MVVizRobMachine >> updater [
	^ updater
]

{ #category : #accessing }
MVVizRobMachine >> updater: anObject [
	updater := anObject.
	
	currentMachineViz := updater rootMachine.
	self updateSlider
]

{ #category : #accessing }
MVVizRobMachine >> vizLabel [
	^ vizLabel
]

{ #category : #accessing }
MVVizRobMachine >> vizLabel: anObject [
	vizLabel := anObject
]
