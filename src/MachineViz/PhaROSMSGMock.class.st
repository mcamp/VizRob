Class {
	#name : #PhaROSMSGMock,
	#superclass : #PhaROSValueMock,
	#category : #'MachineViz-PhaROSMock'
}

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> children [
	^ self getAt: #children. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> children: aValue [
	^ self at: #children put: aValue. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> container_outcomes [
	^ self getAt: #container_outcomes. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> container_outcomes: aValue [
	^ self at: #container_outcomes put: aValue. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self path: ''. 
	 self children: OrderedCollection new . 
	 self internal_outcomes: OrderedCollection new . 
	 self outcomes_from: OrderedCollection new . 
	 self outcomes_to: OrderedCollection new . 
	 self container_outcomes: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> internal_outcomes [
	^ self getAt: #internal_outcomes. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> internal_outcomes: aValue [
	^ self at: #internal_outcomes put: aValue. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> outcomes_from [
	^ self getAt: #outcomes_from. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> outcomes_from: aValue [
	^ self at: #outcomes_from put: aValue. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> outcomes_to [
	^ self getAt: #outcomes_to. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> outcomes_to: aValue [
	^ self at: #outcomes_to put: aValue. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> path [
	^ self getAt: #path. 

]

{ #category : #'as yet unclassified' }
PhaROSMSGMock >> path: aValue [
	^ self at: #path put: aValue. 

]
