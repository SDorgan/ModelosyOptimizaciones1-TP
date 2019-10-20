# Resolucion Ejercicio A - Viaje

#Conjuntos:

#Capitales
set CAPITAL;
set COORDENADAS;
#===================================================

#Parametros:

#Cantidad de capitales
param C >= 0;

#Precio nafta por km
param P >= 0;

param M := 100000000000000000000;

param CostoNafta := 2;

param CostoAlojamiento := 50;

param CostoHeladera := 60;

param CostoAguaBarata := 2;

param CostoAguaCara := 3;

param ViajeLargo := 250;

param kmDeEstiramiento := 100;

param CostoComidaMenor10mil := 60;

param CostoComidaMayor10milMenor20mil := 50;

param CostoComidaMayor20milMenor30mil := 40;

param CostoComidaMayor30mil := 30;

param Distancia10mil := 10000;

param Distancia20mil := 20000;

param Distancia30mil := 30000;

#Distancia en km de ir de i a j, i tiene que ser distinto de j
param DISTANCIA{i in CAPITAL, j in CAPITAL : i<>j};

#Locacion en coordenadas X,Y
param LOCACION{i in COORDENADAS, j in COORDENADAS : i<>j};
#====================================================

#Variables:

#Binaria, vale 1 si se va desde la capital i hasta la capital j
var Y{i in CAPITAL, j in CAPITAL: i<>j} >= 0, binary;

#Binaria, vale 1 si se visito capital i antes que capital j
var Yantes{i in CAPITAL, j in CAPITAL: i<>j} >= 0, binary;

#Entera, indica el orden de secuencia en que la capital i es visitada (excluyendo el punto de partida)
var U{i in CAPITAL} >= 1, integer;

#Varable vibalente que indica si al ir de capital i a capital j se requiere, ademas de una noche, una noche de descanso extra
var Yd{i in CAPITAL, j in CAPITAL: i<>j} >= 0, binary;

#Variable que indica la cantidad de noches que se descansaron al ir de capital i a j
var N{i in CAPITAL, j in CAPITAL: i<>j} >= 0, integer;

#Variable para guardar el total de estiramientos
var Estiramientos >= 0, integer;

#Variable para guardar distancia recorrida en viaje de orden i [km/período]
var D{i in CAPITAL} >= 0;

#Variable para guardar la distancia recorrida en el viaje de orden i habiendose recorrido en total menos de 10mil km
var Dmenor10mil{i in CAPITAL} >= 0;

#Variable para guardar la distancia recorrida en el viaje de orden i habiendose recorrido en total mas de 10mil km y menos de 20mil km
var Dmayor10milMenor20mil{i in CAPITAL} >= 0;

#Variable para guardar la distancia recorrida en el viaje de orden i habiendose recorrido en total mas de 20mil km y menos de 30mil km
var Dmayor20milMenor30mil{i in CAPITAL} >= 0;

#Variable para guardar la distancia recorrida en el viaje de orden i habiendose recorrido en total mas de 30mil km
var Dmayor30mil{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido menos de 10mil km
var Ymenor10mil{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 10mil km y menos de 20mil km
var Ymayor10milmenor20mil{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 20mil km y menos de 30mil km
var Ymayor20milmenor30mil{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 30mil km
var Ymayor30mil{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido menos de 10mil km y durmiendo 1 noche alli
var Ymenor10mil1Noche{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 10mil km, menos de 20mil km y durmiendo 1 noche alli
var Ymayor10milmenor20mil1Noche{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 20mil km, menos de 30mil km y durmiendo 1 noche alli
var Ymayor20milmenor30mil1Noche{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 30mil km y durmiendo 1 noche alli
var Ymayor30mil1Noche{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido menos de 10mil km y durmiendo 2 noches alli
var Ymenor10mil2Noches{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 10mil km, menos de 20mil km y durmiendo 2 noches alli
var Ymayor10milmenor20mil2Noches{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 20mil km, menos de 30mil km y durmiendo 2 noches alli
var Ymayor20milmenor30mil2Noches{i in CAPITAL} >= 0;

#Binaria, vale 1 si la capital visitada en orden i se visita habiendo recorrido mas de 30mil km y durmiendo 2 noches alli
var Ymayor30mil2Noches{i in CAPITAL} >= 0;


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

#====================================================

#Funcional: Minimizar el costo de visitar todas las capitales
#Calculado como: Costo total de comida (dos personas), más costo total de botellas de agua, más costo total de hotel, más costo total de nafta.

minimize z: CostoNafta * TotalesKmRecorridos + CostoAlojamiento * sum{i in CAPITAL, j in CAPITAL : i<>j} N[i,j] + CostoHeladera * Yheladera + AguasDe2Compradas * CostoAguaBarata + AguasDe3Compradas * CostoAguaCara + CostoComidaMenor10mil * sum{i in CAPITAL} Ymenor10mil1Noche[i] + 2 * CostoComidaMenor10mil * sum{i in CAPITAL} Ymenor10mil2Noches[i] + CostoComidaMayor10milMenor20mil * sum{i in CAPITAL} Ymayor10milmenor20mil1Noche[i] + 2 * CostoComidaMayor10milMenor20mil * sum{i in CAPITAL} Ymayor10milmenor20mil2Noches[i] + CostoComidaMayor20milMenor30mil * sum{i in CAPITAL} Ymayor20milmenor30mil1Noche[i] + 2 * CostoComidaMayor20milMenor30mil * sum{i in CAPITAL} Ymayor20milmenor30mil2Noches[i] + CostoComidaMayor30mil * sum{i in CAPITAL} Ymayor30mil1Noche[i] + 2 * CostoComidaMayor30mil * sum{i in CAPITAL} Ymayor30mil2Noches[i];


#minimize z: CostoComida + CostoAgua + CostoHotel + CostoNafta;

#====================================================

#Restricciones:

s.t. salidaCapital{i in CAPITAL}: sum{j in CAPITAL: i<>j} Y[i,j] = 1;

s.t. entradaCapital{j in CAPITAL}: sum{i in CAPITAL: i<>j} Y[i,j] = 1;

#Secuencia para evitar subtours
s.t. orden{i in CAPITAL, j in CAPITAL: i<>j}: U[i] - U[j] + card(CAPITAL) * Y[i,j] <= card(CAPITAL) - 1;

s.t. kilometrosTotales: TotalesKmRecorridos = sum{i in CAPITAL, j in CAPITAL: i<>j} DISTANCIA[i,j] * Y[i,j];

#Restricciones de las noches de descanso

s.t. acotacionNoches{i in CAPITAL, j in CAPITAL: i<>j}: ViajeLargo + Yd[i,j] * M >= DISTANCIA[i,j] * Y[i,j]; 
s.t. acotacionNoches2{i in CAPITAL, j in CAPITAL: i<>j}: DISTANCIA[i,j] * Y[i,j] >= Yd[i,j] * ViajeLargo;
s.t. nochesTotales{i in CAPITAL, j in CAPITAL: i<>j}: N[i,j] = Y[i,j] + Yd[i,j];


#Restricciones del agua

s.t. cantidadTotalEstiramientos: Estiramientos = TotalesKmRecorridos / kmDeEstiramiento;
s.t. cantidadTotalAguas: 2 * Estiramientos / 2 = AguasCompradasTotal;
s.t. conformacionAguas: AguasCompradasTotal = AguasDe2Compradas + AguasDe3Compradas;
s.t. acotacionAguasDe2: AguasDe2Compradas <= Yheladera * M;

#Acumulacion de kilometros

s.t. acumulacionKilometros{i in CAPITAL}: D[i] = sum{j in CAPITAL: i<>j} Yantes[i,j] * DISTANCIA[i,j];
s.t. acotacionCapitalesAntesVisitadas1{i in CAPITAL, j in CAPITAL: i<>j}: -M * (1 - Yantes[i, j]) <= U[j] - U[i];
s.t. acotacionCapitalesAntesVisitadas2{i in CAPITAL, j in CAPITAL: i<>j}: M * Yantes[i, j] >= U[j] - U[i];

#Distancias recorridas segun total recorrido

s.t. seleccionDeDistancia{i in CAPITAL}: D[i] = Dmenor10mil[i] + Dmayor10milMenor20mil[i] + Dmayor20milMenor30mil[i] + Dmayor30mil[i];
s.t. seleccionDeCategDeDistancia{i in CAPITAL}: Ymenor10mil[i] + Ymayor10milmenor20mil[i] + Ymayor20milmenor30mil[i] + Ymayor30mil[i] = 1;

#Definiciones de rangos

s.t. rangoMenor10mil{i in CAPITAL}: Distancia10mil * Ymenor10mil[i] >= Dmenor10mil[i];
s.t. rangoMenor10mil2{i in CAPITAL}: Ymenor10mil[i] <= Dmenor10mil[i];
s.t. rangoMayor10milMenor20mil{i in CAPITAL}: Distancia20mil * Ymayor10milmenor20mil[i] >= Dmayor10milMenor20mil[i];
s.t. rangoMayor10milMenor20mil2{i in CAPITAL}: Ymayor10milmenor20mil[i] * Distancia10mil <= Dmayor10milMenor20mil[i];
s.t. rangoMayor20milMenor30mil{i in CAPITAL}: Distancia30mil * Ymayor20milmenor30mil[i] >= Dmayor20milMenor30mil[i];
s.t. rangoMayor20milMenor30mil2{i in CAPITAL}: Ymayor20milmenor30mil[i] * Distancia20mil <= Dmayor20milMenor30mil[i];
s.t. rangoMayor30mil{i in CAPITAL}: M * Ymayor30mil[i] >= Dmayor30mil[i];
s.t. rangoMayor30mil2{i in CAPITAL}: Distancia30mil* Ymayor30mil[i] <= Dmayor30mil[i];

#Separaciones de rangos por noches en ciudad

s.t. seleccionDeNochesMenor10mil{i in CAPITAL}: Ymenor10mil[i] = Ymenor10mil1Noche[i] + Ymenor10mil2Noches[i];
s.t. seleccionDeNochesMayor10milMenor20mil{i in CAPITAL}: Ymayor10milmenor20mil[i] = Ymayor10milmenor20mil1Noche[i] + Ymayor10milmenor20mil2Noches[i];
s.t. seleccionDeNochesMayor20milMenor30mil{i in CAPITAL}: Ymayor20milmenor30mil[i] = Ymayor20milmenor30mil1Noche[i] + Ymayor20milmenor30mil2Noches[i];
s.t. seleccionDeNochesMayor30mil{i in CAPITAL}: Ymayor30mil[i] = Ymayor30mil1Noche[i] + Ymayor30mil2Noches[i];

#Seleccion final de comidas por ciudad

#Si Yrango = 0, Y2Noches va a ser 0 por la seleccionDeNoches.
#Si Sum(Yd) = 0 y Ymenor10mil = 1, Y2Noches puede ser 1 o 0, pero el modelo va a minimizar, por lo que la va a querer tirar a 0 (2 noches cuesta más que 1 noche)
#Si Sum(Yd) = 1 y Ymenor10mil = 1 Y2Noches tiene que ser 1 si o si.
s.t. seleccion2NochesDistanciaMenor10mil{i in CAPITAL}: 1 + Ymenor10mil2Noches[i] >= sum{j in CAPITAL: i<>j} Yd[i,j] + Ymenor10mil[i];
s.t. seleccion2NochesDistanciaMayor10milMenor20mil{i in CAPITAL}: 1 + Ymayor10milmenor20mil2Noches[i] >= sum{j in CAPITAL: i<>j} Yd[i,j] + Ymayor10milmenor20mil[i];
s.t. seleccion2NochesDistanciaMayor20milMenor30mil{i in CAPITAL}: 1 + Ymayor20milmenor30mil2Noches[i] >= sum{j in CAPITAL: i<>j} Yd[i,j] + Ymayor20milmenor30mil[i];
s.t. seleccion2NochesDistanciaMayor30mil{i in CAPITAL}: 1 + Ymayor30mil2Noches[i] >= sum{j in CAPITAL: i<>j} Yd[i,j] + Ymayor30mil[i];

solve;

end;
