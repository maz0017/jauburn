Class {
	#name : #JbWhileLoopNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileLoopNode >> condition [
	^ condition
]

{ #category : #accessing }
JbWhileLoopNode >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
JbWhileLoopNode >> executeIn: environment [

[condition evaluateIn: environment] whileTrue:[ 

	trueStatements do: [ :each | each executeIn: environment ].

].
]

{ #category : #accessing }
JbWhileLoopNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbWhileLoopNode >> trueStatements: anObject [
	trueStatements := anObject
]
