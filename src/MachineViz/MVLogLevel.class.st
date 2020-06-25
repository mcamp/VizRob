Class {
	#name : #MVLogLevel,
	#superclass : #Object,
	#category : #'MachineViz-Log'
}

{ #category : #levels }
MVLogLevel class >> debug [
	^#debug
]

{ #category : #levels }
MVLogLevel class >> error [
	^#error
]

{ #category : #levels }
MVLogLevel class >> info [
	^#info
]

{ #category : #levels }
MVLogLevel class >> warning [
	^#warning
]
