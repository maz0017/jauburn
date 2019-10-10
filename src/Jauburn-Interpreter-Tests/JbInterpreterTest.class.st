Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #running }
JbInterpreterTest >> testAbsBinding [
	self interpret: 'var a = mod(10, 3);'.
	self assert: (interpreter environment at: 'a') equals: 1.
	
	self interpret: 'var a = mod(10, 5);'.
	self assert: (interpreter environment at: 'a') equals: 0.
]

{ #category : #running }
JbInterpreterTest >> testBooleanExpression [

	self interpret: 'var x = true;var z = false;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self assert: (interpreter environment at: 'z') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testConcatBinding [

	self interpret: 'var a = concat("hello", " world");'.
	self assert: (interpreter environment at: 'a') equals: 'hello world'.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testDivision [

	self interpret: 'var x = 10 / 2;'.
	self assert: (interpreter environment at: 'x') equals: 5.
	
	self interpret: 'var x = 100 / 10;'.
	self assert: (interpreter environment at: 'x') equals: 10.
]

{ #category : #running }
JbInterpreterTest >> testEquality [

	self interpret: 'var x = 5;var y = 5; var z = x == y;'.
	self assert: (interpreter environment at: 'z') equals: true.
	
	self interpret: 'var x = 5;var y = 5; var z = x == 1;'.
	self assert: (interpreter environment at: 'z') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testFunctionCall [

	self interpret: 'var x=function(a, b){ return b;};var y = x(1, 2);'.
	self assert: (interpreter environment at: 'y') equals: 2.


	self interpret: 'var x=function(a, b, c){ return a * b * c;};var y = x(1, 2, 3);'.
	self assert: (interpreter environment at: 'y') equals: 6.
	
	self interpret: 'var x=function(a, b, c){ var d = a + b + c; return d;};var y = x(10, 9, 8);'.
	self assert: (interpreter environment at: 'y') equals: 27.
]

{ #category : #running }
JbInterpreterTest >> testFunctionCallWithClosure [

	self interpret: 'var z = 0; var x=function(a, b){ z = 99; return b;};var y = x(1, 2);'.
	self assert: (interpreter environment at: 'y') equals: 2.
	self assert: (interpreter environment at: 'z') equals: 99.
]

{ #category : #running }
JbInterpreterTest >> testFunctionDefinition [
	self interpret: 'var x = function(a, b, c) {};'.
	self assert: (interpreter environment at: 'x') parameters size equals: 3.
	self assert: (interpreter environment at: 'x') body size equals: 0.
	self assert: (interpreter environment at: 'x') environment equals: interpreter environment.
]

{ #category : #running }
JbInterpreterTest >> testGreaterThan [

	self interpret: 'var x = 10 > 5;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 10 > 50;'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testGreaterThanOrEqual [

	self interpret: 'var x = 10 >= 5;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 11 >= 11;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	
	self interpret: 'var x = 11 >= 1100;'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testLengthBinding [

	self interpret: 'var myString = "hello world"; var l = length(myString);'.
	self assert: (interpreter environment at: 'l') equals: 11.
	
	self interpret: 'var myString = ""; var l = length(myString);'.
	self assert: (interpreter environment at: 'l') equals: 0.
]

{ #category : #running }
JbInterpreterTest >> testLessThan [

	self interpret: 'var x = 5 < 10;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 11 < 11;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	
	self interpret: 'var x = 1000 < 11;'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testLessThanOrEqual [

	self interpret: 'var x = 5 <= 10;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 11 <= 11;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	
	self interpret: 'var x = 1221 <= 11;'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testMinusOperationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 - 1;'.
	self assert: (interpreter environment at: 'x') equals: 4.
	
	self interpret: 'var x = 10 - 5;'.
	self assert: (interpreter environment at: 'x') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testNewtonsSquareRootOf100 [
	| progStr |
progStr := 'var guess = 9;
var sqRootOf = abs(100);
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
'.
	
self interpret: progStr.

" 
------------------------
- Submission Comments: -
------------------------
My program variable 'guess' equals 10, but the 'Transcript show:'
below outputs that its set to (144220706783810583841/14422070678381058384).
The between:and: evaluates that as expected, but equals does not, that's why
I used beween:and: in my assertion.
"
"Transcript show: (interpreter environment at: 'guess')."
"self assert: (interpreter environment at: 'guess') equals: 10."
self assert: ((interpreter environment at: 'guess') between: 10 and: 10.0000001) equals: true.

]

{ #category : #tests }
JbInterpreterTest >> testNewtonsSquareRootOf2 [
"Next step, implement as JbSamplePrograms class >> newtonsSquareRoot."
	| progStr |
progStr := 'var guess = 1;
var sqRootOf = abs(2);
var numTries = 0;
var maxTries = 10;
var quotient = 0;
var average = 0;

while(numTries < maxTries)
{ 
	quotient = sqRootOf / guess;
	average = (quotient + guess) / 2;	
	guess = average;
	
	numTries = numTries + 1;
}
'.
	
	self interpret: progStr.
	self assert: ((interpreter environment at: 'guess') between: 1.4141 and: 1.41432) equals: true.
]

{ #category : #tests }
JbInterpreterTest >> testNewtonsSquareRootProgramStr [

| progStr |
progStr := JbSamplePrograms newtonsSquareRoot.
self interpret: progStr.
self assert: ((interpreter environment at: 'guess') between: 1.4141 and: 1.41432) equals: true.
]

{ #category : #running }
JbInterpreterTest >> testNotBinding [

	self interpret: 'var x = true;var y = not(x);'.
	self assert: (interpreter environment at: 'y') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testNotEqual [

	self interpret: 'var x = 5;var y = 5; var z = x != y;'.
	self assert: (interpreter environment at: 'z') equals: false.
	
	self interpret: 'var x = 5;var y = 6; var z = x != y;'.
	self assert: (interpreter environment at: 'z') equals: true.
]

{ #category : #running }
JbInterpreterTest >> testUnaryNegation [

	self interpret: 'var x = 43;var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: -43.
]

{ #category : #running }
JbInterpreterTest >> testWhileLoop [

self interpret: 'var sum = 0;var i = 1;while(i <= 10){sum = sum + i; i = i + 1;}'.
self assert: (interpreter environment at: 'sum') equals: 55.

self interpret: 'var sumTenDigits = function() {
var sum = 0;
var i = 1;
while(i < 11){
  sum = sum + i; 
  i = i + 1; 
}

return sum;
};

var answer = sumTenDigits();
'.
self assert: (interpreter environment at: 'answer') equals: 55.

]

{ #category : #running }
JbInterpreterTest >> testif [

	self interpret: 'var x=1; if(true){ x = 2;}'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var y=5; if(false){ y = 1;}'.
	self assert: (interpreter environment at: 'y') equals: 5.
]

{ #category : #running }
JbInterpreterTest >> testifElse [

	self interpret: 'var x=1;if(false){x = 2;}else{x = 100;}'.
	self assert: (interpreter environment at: 'x') equals: 100.
]
