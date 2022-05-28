section	.text
global _start 

convert_number_to_string:  ;do not use
  mov byte [buffer+9],0  
  lea esi,[buffer+9]
  mov ebx,10 
convert_number_to_string_loop:  ;do not use
  xor edx,edx           
  div ebx               
  add dl,'0'            
  dec esi               
  mov [esi],dl
  test eax,eax
  jnz convert_number_to_string_loop    
  mov eax,esi
  ret
  
print_number:     ;mov eax,[NUMBER] (NUMBER must be declared othervise use 'mov eax,VALUE')
    call convert_number_to_string
    mov	edx, 10   
    mov	ecx, buffer    
    mov	ebx, 1	    
    mov	eax, 4	    
    int	0x80    
    mov byte[buffer+0],""
    mov byte[buffer+1],""
    mov byte[buffer+2],""
    mov byte[buffer+3],""
    mov byte[buffer+4],""
    mov byte[buffer+5],""
    mov byte[buffer+6],""
    mov byte[buffer+7],""
    mov byte[buffer+8],""
    mov byte[buffer+9],""
    ret
 
print_string:    ;mov ecx,STRING  ;mov edx,LENGTH  (STRING must be declared in .data by STRING dd "TEXT" , LENGTH must be declared in .data by LENGTH equ $-STRING)
    mov	ebx, 1	    
    mov	eax, 4	    
    int	0x80        
    ret
    
print_new_line:
    mov	ecx,new_line 
    mov edx,1
    mov	ebx, 1	    
    mov	eax, 4	    
    int	0x80        
    ret
 
_start:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START
    ;result = x * y   
    mov eax,[x]
    mov ebx,[y]
    mul ebx
    mov [result],eax
    ;print equation
    mov eax,[x]
    call print_number
    mov ecx,string1
    mov edx,length1
    call print_string 
    mov eax,[y]
    call print_number
    mov ecx,string2
    mov edx,length2
    call print_string 
    mov eax,[result]
    call print_number
    ;exit
    mov	eax, 1	   
    int	0x80   
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END

section	.data
buffer resb 10 ;do not use
new_line dd "",10 ;do not use
string1 dd " * "
length1 equ $-string1
string2 dd " = "
length2 equ $-string2
x dd 1 ;set value here
y dd 1  ;set value here
result dd 0