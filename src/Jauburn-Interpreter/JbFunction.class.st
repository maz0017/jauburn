"
I am the value that results from evaluating a function.  My i-vars

	parameters -- collection holding names of my parameters 
	environment -- a JbEnvironment instance holding the environment in effect when I was created (closures!)
	body -- an AST node for the body of this function
"
Class {
	#name : #JbFunction,
	#superclass : #Object,
	#instVars : [
		'body',
		'parameters',
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbFunction >> body [
	^ body
]

{ #category : #accessing }
JbFunction >> body: anObject [
	body := anObject
]

{ #category : #api }
JbFunction >> call: arguments in: callEnvironment [
	"You need to implement this method!  arguments will contain the arguments to pass to this function and callEnvironment will contain the environment in place when this function was called."
	
| applicationEnv paramIndex paramValue |
applicationEnv := JbEnvironment newFromKeys: self parameters andValues: arguments.
applicationEnv outerEnvironment: callEnvironment.

"applicationEnv returnBlock: [ :arg | ^arg ]."

"
Set the parameters in the environment, to avoid 'Key [identifier]
not found in JbEnvironment.'
"
paramIndex := 1.
parameters do: [ :param | 
		
	paramValue := (arguments at: paramIndex).

	applicationEnv at: (param identifier) put: paramValue.
	
	paramIndex := paramIndex + 1.
].

"
Now execute each body statement.  If we hit a return statement, 
set its value as the returnVal.
"
body do: [ :statement | 
	(statement isKindOf: JbReturnStatementNode)
		ifTrue: [  	^statement executeIn: applicationEnv ]
		ifFalse: [ 	statement executeIn: applicationEnv ]
].

]

{ #category : #accessing }
JbFunction >> environment [
	^ environment
]

{ #category : #accessing }
JbFunction >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
JbFunction >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunction >> parameters: anObject [
	parameters := anObject
]
