# Resolucion Ejercicio B - Organizacion Fiesta

/* Declaracion de variables */
var CantidadGold >= 0, integer;
var CantidadSilver >= 0, integer;
var CantidadMerchandising >= 0, integer;
var PaquetesGold >= 0, integer;
var PaquetesSilver >= 0, integer;
var CantidadGoldVendidos >= 0, integer;
var CantidadSilverVendidos >= 0, integer;
var CantidadMerchndisingGold >= 0, integer;
var CantidadMerchndisingSilver >= 0, integer;

/* Definición del funcional */
maximize z: 1500 * CantidadGoldVendidos + 700 * CantidadSilverVendidos - 800 * CantidadMerchandising - 500 * 700 ;

/* Restricciones */

s.t. entradasGold: 100 + PaquetesGold + CantidadGoldVendidos = CantidadGold;
s.t. entradasSilver: PaquetesSilver + CantidadSilverVendidos = CantidadSilver;
s.t. merchandisingTotal: CantidadMerchndisingGold + CantidadMerchndisingSilver = CantidadMerchandising;
s.t. merchandisingGold: CantidadMerchndisingGold * 8 >= CantidadGold;
s.t. merchandisingSilver: CantidadMerchndisingSilver * 20 >= CantidadSilver;
s.t. capacidadPredio: CantidadGold + CantidadSilver * 0.5 <= 8000;
s.t. minimasSilver: CantidadSilverVendidos >= 500;

end;