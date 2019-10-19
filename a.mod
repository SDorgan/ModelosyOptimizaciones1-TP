# Resolucion Ejercicio A - Viaje

#Conjuntos:

#Capitales
set CP;

#===================================================

#Parametros:

#Cantidad de capitales
param N >= 0;

#Precio nafta por km
param P >= 0;

#====================================================

#Variables:

#Binaria, vale 1 si se va desde la capital i hasta la capital j
var Y{i in CP, j in CP: i<>j} >= 0, binary;

#Entera, indica el orden de secuencia en que la capital i es visitada (excluyendo el punto de partida)
var U{i in CP} >= 1, integer;

#Variable para guardar el total de estiramientos
var E >= 0;

#Variable para guardar distancia recorrida en viaje de orden i [km/período]
var D{i in CP} >= 0;

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
#(30USD*Di<=10km + 25USD*Di>10km,<=20km + 20USD*Di>20km,<=30km + 15USD*Di>30km)*2 
var CostoComida >= 0;

#Variable para guardar el costo de la bebida
# 60USD*Yh + 2USD*A2 + 3USD*A3
var CostoAgua >= 0;

#Variable para guardar el costo de noches de hotel pagadas
#50USD* sum DE Yij + Ydij
var CostoHotel >= 0;

#Variable para guardar el costo de nafta
#2USD*Tkm
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
