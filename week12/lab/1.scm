#lang sicp

#|
1. at the entrance of the evaluator. in read-eval-print loop
2. at cond branch, eval the transformed cond expression
3. at application branch, eval the operator and operands 
4. at eval-if branch, eval all elements of if expression
5. at eval-sequence, eval every elemnts in sequence
6. at eval-assignment branch, eval the value to be assigned
7. at eval-definition branch, eval the value to be defined
8. 
|#