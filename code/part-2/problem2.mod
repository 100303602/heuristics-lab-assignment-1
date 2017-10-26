/*
 * Title:
 *     m.mod
 *
 * Description:
 *
 * Authors:
 *     Alvaro Caceres Mu~noz (100303602)
 *     Guillermo Escobero Hernandez (100346060)
 */


set FLIGHTS;
set MADRID_VALENCIA_FLIGHTS within FLIGHTS;
set VALENCIA_MADRID_FLIGHTS within FLIGHTS;
set CREW;
set PILOTS within CREW;
set ATTENDANTS within CREW;


/* Sets */

/* Parameters */
param Departure_Times {i in FLIGHTS};
param Arrival_Times {i in FLIGHTS};
param Flights_Durations {i in FLIGHTS};
param Time_Between_Flights {i in FLIGHTS, j in FLIGHTS};
param Break_Times {i in PILOTS};
param Earnings {i in CREW, j in FLIGHTS};

/* Decision variables*/
var x {i in CREW, j in FLIGHTS} binary;

/* Objective function */
minimize Expenses: sum{i in CREW} (sum{j in FLIGHTS} x[i,j] * Earnings[i,j] * Flights_Durations[j]);

/* Constraints */
s.t. Minimum_Pilots {i in FLIGHTS}:                            sum{j in PILOTS} x[j,i] >= 1;
s.t. Minimum_Attendants {i in FLIGHTS}:                        sum{j in ATTENDANTS} x[j,i] >= 1;
s.t. Hours_Assigned:                                           sum{i in FLIGHTS} (Flights_Durations[i]*sum{j in PILOTS} x[j,i]) <= sum{i in FLIGHTS} (Flights_Durations[i]*sum{j in ATTENDANTS} x[j,i]);
# s.t. Breaks {i in FLIGHTS, j in FLIGHTS, k in PILOTS: i <> j}: x[k,j]*Time_Between_Flights[i,j] >= Break_Times[k];
# s.t. Breaks {i in PILOTS, j in FLIGHTS, k in FLIGHTS : j <> k}: x[i,k]*Departure_Times[k] - x[i,j]*Arrival_Times[j] >= Break_Times[i];
s.t. Breaks {i in PILOTS, j in FLIGHTS, k in FLIGHTS : j <> k}: Time_Between_Flights[j,k]*x[i,k]*Departure_Times[k] - Time_Between_Flights[j,k]*x[i,j]*Arrival_Times[j] >= Break_Times[i];

end;
