# Resolucion Ejercicio A - Viaje

#Conjuntos:

#Capitales
set CAPITAL;
set COORDENADAS;
#===================================================

#Parametros:

#Cantidad de capitales
param N >= 0;

#Precio nafta por km
param P >= 0;

#Distancia en km de ir de i a j, i tiene que ser distinto de j
param DISTANCIA{i in CAPITAL, j in CAPITAL : i<>j};

#Locacion en coordenadas X,Y
param LOCACION{i in COORDENADAS, j in COORDENADAS : i<>j};
#====================================================

#Variables:

#Binaria, vale 1 si se va desde la capital i hasta la capital j
var Y{i in CAPITAL, j in CAPITAL: i<>j} >= 0, binary;

#Entera, indica el orden de secuencia en que la capital i es visitada (excluyendo el punto de partida)
var U{i in CAPITAL} >= 1, integer;

#Variable para guardar el total de estiramientos
var E >= 0;

#Variable para guardar distancia recorrida en viaje de orden i [km/período]
var D{i in CAPITAL} >= 0;

#Variable para guardar el total kilómetros recorridos [km/período]
var Tkm >= 0;

#Variable para guardar el total de botellas de agua compradas [unidad/período]
var A >= 0;

#Variable para guardar el total de botellas de agua de 2 USD compradas [unidad/período]
var A2 >= 0;

#Variable para guardar el total de botellas de agua de 3 USD compradas [unidad/período]
var A3 >= 0;

#Binaria, indica si deben comprar la heladera
var Yh >= 0;

#Variable para guardar el costo de comida
var CostoComida >= 0;

#Variable para guardar el costo de la bebida
var CostoAgua >= 0;

#Variable para guardar el costo de noches de hotel pagadas
var CostoHotel >= 0;

#Variable para guardar el costo de nafta
var CostoNafta >= 0;

#====================================================

#Funcional: Minimizar el costo de visitar todas las capitales
#Calculado como: Costo total de comida (dos personas), más costo total de botellas de agua, más costo total de hotel, más costo total de nafta.

minimize z: CostoComida + CostoAgua + CostoHotel + CostoNafta;


#====================================================

#Restricciones:

solve;

printf "\n#################################\n\n";
printf 'RECORRIDO: \n';
printf '--------\n';
printf 'DISTANCIA TOTAL: \n';
printf 'PRECIO POR KM: \n';
printf 'COSTO DEL VIAJE:\n';  
printf 'Costos : $ %8.2f\n', z;
printf "\n#################################\n\n";

end;
