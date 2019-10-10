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

	"self run: #noFunctions"

^'var guess = 1;
var sqRootOf = abs(2);
var numTries = 0;
var maxTries = 4;
var quotient = 0;
var average = 0;

while(numTries < maxTries)
{ 
	quotient = sqRootOf / guess;
	average = (quotient + guess) / 2;	
	guess = average;
	
	numTries = numTries + 1;
}
'
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
