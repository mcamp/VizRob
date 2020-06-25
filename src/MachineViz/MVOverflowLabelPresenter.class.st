Class {
	#name : #MVOverflowLabelPresenter,
	#superclass : #LabelPresenter,
	#instVars : [
		'overflowText',
		'overflowDirection',
		'originalText',
		'maxSize'
	],
	#category : #'MachineViz-Visualization-Helpers'
}

{ #category : #initialization }
MVOverflowLabelPresenter >> initialize [

	super initialize.
	
	maxSize := 20.
	overflowDirection := #right.
	overflowText := '...'.
]

{ #category : #api }
MVOverflowLabelPresenter >> isOverflowedLeft [
	^ overflowDirection = #left
]

{ #category : #api }
MVOverflowLabelPresenter >> isOverflowedRight [
	^ overflowDirection = #right
]

{ #category : #api }
MVOverflowLabelPresenter >> label: aText [

	self originalText: aText.
	super label: self overflowedText.
]

{ #category : #accessing }
MVOverflowLabelPresenter >> maxSize [
	^ maxSize
]

{ #category : #accessing }
MVOverflowLabelPresenter >> maxSize: anObject [
	maxSize := anObject
]

{ #category : #accessing }
MVOverflowLabelPresenter >> originalText [
	^ originalText
]

{ #category : #accessing }
MVOverflowLabelPresenter >> originalText: anObject [
	originalText := anObject
]

{ #category : #accessing }
MVOverflowLabelPresenter >> overflowDirection [
	^ overflowDirection
]

{ #category : #accessing }
MVOverflowLabelPresenter >> overflowDirection: anObject [
	overflowDirection := anObject
]

{ #category : #api }
MVOverflowLabelPresenter >> overflowLeft [
	overflowDirection := #left
]

{ #category : #api }
MVOverflowLabelPresenter >> overflowRight [
	overflowDirection := #right
]

{ #category : #accessing }
MVOverflowLabelPresenter >> overflowText [
	^ overflowText
]

{ #category : #accessing }
MVOverflowLabelPresenter >> overflowText: anObject [
	overflowText := anObject
]

{ #category : #api }
MVOverflowLabelPresenter >> overflowedText [

	(self originalText size <= self maxSize) ifTrue: [ ^ self originalText ].
	
	self isOverflowedLeft ifTrue: [ ^ self overflowedTextLeft ].
	^ self overflowedTextRight.
]

{ #category : #private }
MVOverflowLabelPresenter >> overflowedTextLeft [

	^ self overflowText , (self originalText last: (self maxSize - self overflowText size))
]

{ #category : #private }
MVOverflowLabelPresenter >> overflowedTextRight [

	^ (self originalText first: (self maxSize - self overflowText size)) , self overflowText 
]
