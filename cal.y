%{
    #include <stdio.h>
    #include<alloca.h>
    #include<stdlib.h>
    #include<stddef.h>
    #include<ctype.h>
    #include<string.h>
    #include<math.h>
     
  
     //oct to dec
 long int octal_decimal(long int num)
 {
 long int rem,dec=0,i=0;
  while(num>0)
 {
 rem=num%10;
 num=num/10;
 dec=dec+rem * pow(8,i);
 i++;
 }
 return dec;
 }
 
 
 // hexadecimal to decimal
 long int hexadecimal_decimal(long int num)
 {
 long int rem,dec=0,i=0;
 while(num>0)
 {
 rem=num%10;
 num=num/10;
 dec=dec+rem * pow(16,i);
 i++;
 }
 return dec;
 }
 
 
 // binary to decimal
 long int binary_decimal(long int num)
 {
 long int rem,dec=0,i=0;
 while(num>0)
 {
 rem=num%10;
 num=num/10;
 dec=dec+rem * pow(2,i);
 i++;
 }
 return dec;
 }
 
 
    void yyerror(char *);
    int yylex(void);
    int sym[26];
    int flag=0;
    // precedence & accociation is high for up to  bottom
%}

%token INTEGER VARIABLE Sin Cos Tan BIN OCT HEX LOG
%right '='
%left  '+' '-'
%left  '*' '/' 
%left '('')'
%right '^'
%right UMINUS


%%
program:
        program stmnt '\n' 
        |program '\n'
	|
        ;
     

stmnt:
        exp                     { if(flag==0) printf("%d\n",$$);
                                    else{ flag=1;}
                                  }
        | VARIABLE '=' exp       { sym[$1] = $3;//$1=a=0,$1=b=1,$1=c(VARIABLE)=2(index number) 
                          //sym[$1] means input value or c=a+b; then value
                         // is assign to x means sym[$1] 
                         //sym[0]=a=2,sym[1]=b=3, sym[2]=5; actually 2 is return for c from lex.
                                    }   
       //  | BINARY'('expr')'                                  
        ;

exp:
        // FUNC
      
        | INTEGER
        | VARIABLE                { $$ = sym[$1]; 
                                         if($$ == 0){flag=1; printf("Compilation Error\n");}
                                         // here value is assigned to below expr like $1=2,$3=3;
                                  } 
        | exp '+' exp           {//printf("$1 = %d\n",$1);
                                   //printf("$2 = %d\n",$2);
                                   //printf("$3 = %d\n",$3);
                                   $$ = $1 + $3; 
        }


        | exp '-' exp           { $$ = $1 - $3; }
        | exp '*' exp           { $$ = $1 * $3; }
        | exp '/' exp           {
                                    if($3==0) yyerror("divide 0");
				    else $$ = $1 / $3; 
                                   }
         |exp '^' exp           {$$=pow($1,$3);}                          
        | '(' exp ')'            { $$ = $2; //Default: $$ = $1; 
                                  } 
        | '-' exp %prec UMINUS {$$ = -$2;}  
        | LOG '('exp ')' {$$=log($3)/log(10);} 
        | Sin'(' exp ')'  {$$= sin($3);}  
        | Cos'(' exp ')'  {$$= cos($3);}  
        | Tan'(' exp ')'  {$$= tan($3);}   
        | BIN'('exp')' {$$=binary_decimal($3);}
        | OCT'('exp')' {$$=octal_decimal($3);}
        | HEX'('exp')' {$$=hexadecimal_decimal($3);}
        ;

%%
void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {    
   //yytext means a string containing the lexeme 

    yyparse();        //*yytext means pointer to matched string
                     //The function yyparse() is created for you by YACC, 
                    //and ends up in y.tab.c. yyparse() reads  
                   // stream of token value pairs from yylex(), which needs to be supplied.
                  //yylex() means call to invoke lexer, returns token
  //printf("Output: %d\n",result);
    return 0;
}
