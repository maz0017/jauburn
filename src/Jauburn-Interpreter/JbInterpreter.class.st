"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'primitives'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
	^#abs -> [ :num | num abs ]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [
	^#concat -> [ :string1 :string2 | string1, string2 ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

super initialize.
environment := JbEnvironment new.
primitives := Set new.

(self class selectors select: [ :each | each endsWith: 'Binding' ]) do: [ :s |
	| binding |
	binding := self perform: s.
	environment at: binding key put: (JbPrimitive new block: binding value; yourself) 
]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
	^#length -> [ :string | string size ]
]

{ #category : #primitives }
JbInterpreter >> modBinding [
	^#mod -> [ :num1 :num2 |  num1 \\ num2 ]
]

{ #category : #primitives }
JbInterpreter >> notBinding [
	^#not -> [ :bool | bool not. ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^#print -> 
	[:value | (value isString)
        ifTrue: [ Transcript show: value. ]
        ifFalse: [ Transcript show: value printString. ]]
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [
	^#println -> [ :value | Transcript show: value.  Transcript cr. ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]
