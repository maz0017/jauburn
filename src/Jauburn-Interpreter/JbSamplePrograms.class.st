"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'as yet unclassified' }
JbSamplePrograms class >> newtonsSquareRoot [

	Transcript show: 4.

"	self interpret: 'newtonsSquareRoot(4);'."
"	self assert: (interpreter environment at: 'z') equals: false."
]

{ #category : #'as yet unclassified' }
JbSamplePrograms class >> newtonsSquareRoot: aNumber [

	Transcript show: aNumber.
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]
