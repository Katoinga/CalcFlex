/* Seccion de Definciones*/
DIGITO [0-9]
NUMERO {DIGITO}+(\.{DIGITO}+)?
OPS [*/%+^-]
%{  
    #include <math.h>
    int flag_operador1=0,flag_operador2=-1;
    char operacion;
    float operador1=0,operador2=0,respuesta=0,aux=0;
    void evaluate();
%}

/*Seccion de Reglas*/
%%
{NUMERO} {
    if(flag_operador1==0){
        operador1=atof(yytext);
        flag_operador1=1;
    }

    else if(flag_operador2==0){
        operador2=atof(yytext); flag_operador2=1;
    }

    if((flag_operador1==1) && (flag_operador2==1)) {
        evaluate(); flag_operador1=0; flag_operador2=-1;
    }
}
{OPS} {
    operacion= (char)*yytext;
    flag_operador2=0;
}
[ ] {printf("Detectado espacio");}
. {printf("error");}

%%
/*Seccion de Codigo de Usuario*/
int yywrap(){}
int main(){
    yylex();
    return 0;
}
void evaluate(){
    switch(operacion) {
        case '+':
        respuesta=operador1+operador2;
        break;
        case '-':
        respuesta=operador1-operador2;
        break;
        case '*':
        respuesta=operador1*operador2;
        break;
        case '/':
        if(operador2 == 0) {
            printf("ERROR: El divisor no puede ser 0, se devolvera 0 como respuesta \n");
            respuesta = 0;
            }
        else{
            respuesta = operador1 / operador2;
        }
        break;

        default:
        printf("No se reconoce la operacion");
        break;

        case '^':
			respuesta=1;
			for(int i=0;i<operador2;i++){
				respuesta= respuesta*operador1;
			}
			break;
        case '%':
			if(operador2!=0){
				respuesta=fmod(operador1,operador2);
			}
			else{
				printf("No se puede sacar modulo 0\n");
				aux=0;
			}
			break;
    }
    printf("La respuesta es = %0.2f \n",respuesta);
}
