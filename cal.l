%{
 #include <stdlib.h>
 #include<math.h>
 void yyerror(char *);
 #include "y.tab.h"
%}

%%
 /* variables */
[a-z] {
 yylval = *yytext - 'a'; 
 return VARIABLE;
 }
 /* integers */
[0-9]+ {
 yylval = atoi(yytext);
 return INTEGER;
 }
 /* operators */
[-+()=/*^\n;.] { return *yytext; }


sin return Sin;
cos return Cos;
tan return Tan;
log return LOG;

binary return BIN;
octal return OCT;
hexadecimal return HEX;

 /* skip whitespace */
[ \t]+ ;
 /* anything else is an error */
. yyerror("invalid character");
%%
int yywrap(void) {
 return 1;
}
