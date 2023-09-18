#lang simply-scheme


; 1 generic operations with explicit dispatch
; new types : every operation should add a new cond clause to handle new type
; new operations: add a new function handle every type



; 2 data-directed style
; new types : develop a new setup, sign the selectors & constructor to the table
; new operations: add a new entry for the operation using apply-generic, realize
; the new operations in each setup



; 3 message-passing-style
; new types : add a new function related to the new type, dispatch every operation
; in the new function
; new operations : add the new operation in every type procedure.