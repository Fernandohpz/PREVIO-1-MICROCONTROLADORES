PROCESSOR 12F615        ;Modelo del microcontrolador

;*** Palabra de configuración ****;
config FOSC=INTOSCIO      ;oscilador interno.
config WDTE=OFF           ;WDT deshabilitado.
config PWRTE=ON          ;PWRT habilitado.
config MCLRE=ON           ;MasterClear activado.
config CP=OFF             ;Memoria de programa sin protección.
config IOSCFS=4MHZ        ;Frecuencia del oscilador interno.
config BOREN=ON           ;Brown-out Reset habilitado.

#include <xc.inc>
    
psect    resetvector,abs,class=CODE,delta=2 ;  PIC10/12/16

;*** Sección de vectores ***;
    ORG  0        ;VECTOR DE RESET.
    goto START    
    ORG  5        ;INICIO DE LA MEMORIA DEL PROGRAMA.

 START:       bsf   STATUS,5         ;Cambio al Banco 1 de memoria.
              movlw 0x04             ;Configurar los pines del puerto.
	      movwf TRISIO           ;0000 0100.
	      clrf  ANSEL            ;Deshabilitara las funciones.
	                             ;analógicas.
	      bsf   STATUS,5         ;Configura al microcontrolador.
	      movlw 0xA0             ;Para trabajar como contador.
	      movwf OPTION_REG       ;Usando el registro OPTION_REG.
	      bcf   STATUS,5         ;Cambio al banco 0 de memoria.
	      clrf  GPIO             ;Limpia el puerto.
	      
;*** Programa principal ***;
LOOP:         movf  TMR0,w           ;Se encarga de realizar el conteo y
              andlw 0x03             ;enviarlo al puerto de salida.
	      movwf GPIO             
	      goto  LOOP
    END                              ;Fin del programa
