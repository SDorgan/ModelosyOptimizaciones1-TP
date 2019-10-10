# Resolucion Ejercicio B - Organizacion Fiesta

/* Declaraci´on de variables */
var Cg >= 0, integer;
var Cs >= 0, integer;
var Cm >= 0, integer;
var Pg >= 0, integer;
var Ps >= 0, integer;
var Cgv >= 0, integer;
var Csv >= 0, integer;
var Cmg >= 0, integer;
var Cms >= 0, integer;

/* Definición del funcional */
maximize z: 1500 * Cgv + 700 * Csv - 800 * Cm - 500 * 700 ;

/* Restricciones */

s.t. entradasGold: 100 + Pg + Cgv = Cg;
s.t. entradasSilver: Ps + Csv = Cs;
s.t. merchandisingTotal: Cmg + Cms = Cm;
s.t. merchandisingGold: Cmg >= Cg * 8;
s.t. merchandisingSilver: Cms >= Cs * 20;
s.t. capacidadPredio: Cg + Cs * 0.5 <= 8000;
s.t. minimasSilver: Csv >= 500;
solve;
display Cg, Cs, Cm;
end;