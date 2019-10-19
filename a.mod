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
var Estiramientos >= 0, integer;

#Variable para guardar distancia recorrida en viaje de orden i [km/período]
var D{i in CAPITAL} >= 0;

#Variable para guardar el total kilómetros recorridos [km/período]
var TotalesKmRecorridos >= 0;

#Variable para guardar el total de botellas de agua compradas [unidad/período]
var AguasCompradasTotal >= 0, integer;

#Variable para guardar el total de botellas de agua de 2 USD compradas [unidad/período]
var AguasDe2Compradas >= 0, integer;

#Variable para guardar el total de botellas de agua de 3 USD compradas [unidad/período]
var AguasDe3Compradas >= 0, integer;

#Binaria, indica si deben comprar la heladera
var Yheladera >= 0, binary;

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

#minimize z: CostoComida + CostoAgua + CostoHotel + CostoNafta;
#minimize z: sum{i in CAPITAL, j in CAPITAL : i<>j} DISTANCIA[i,j]*Y[i,j];

#====================================================

#Restricciones:

s.t. salidaCapital{i in CAPITAL}: sum{j in CAPITAL: i<>j} Y[i,j] = 1;

s.t. entradaCapital{j in CAPITAL}: sum{i in CAPITAL: i<>j} Y[i,j] = 1;

#Secuencia para evitar subtours
s.t. orden{i in CAPITAL, j in CAPITAL: i<>j}: U[i] - U[j] + card(CAPITAL) * Y[i,j] <= card(CAPITAL) - 1;

#s.t. kilometrosTotales{i in CAPITAL, j in CAPITAL}: TotalesKm = sum{i in CAPITAL, j in CAPITAL: i<>j} DISTANCIA[i,j] * Y[i,j];

solve;

printf "\n#################################\n\n";
printf 'RECORRIDO: \n';
printf '--------\n';
printf 'CANTIDAD CAPITALES:\n';
printf 'DISTANCIA TOTAL: \n';
printf 'PRECIO POR KM: \n';
printf 'COSTO DEL VIAJE:\n';  
printf 'Costos : $ %8.2f\n';
printf "\n#################################\n\n";

end;
