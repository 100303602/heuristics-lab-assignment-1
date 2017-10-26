set FLIGHTS := v1 v2 v3 v4 v5 v6;
set MADRID_VALENCIA_FLIGHTS within FLIGHTS := v1 v3 v5;
set VALENCIA_MADRID_FLIGHTS within FLIGHTS := v2 v4 v6;

set CREW;
set PILOTS within CREW := p1 p2 p3;
set ATTENDANTS within CREW := a1 a2 a3;

s.t. Minimum_Pilots {i in FLIGHTS}: sum{j in PILOTS}: x[j][i] >= 1;
s.t. Minimum_Attendants {i in FLIGHTS}: sum{j in ATTENDANTS}: x[j][i] >= 1;

s.t. Hours_Assigned: sum{i in FLIGHTS} (Flights_Durations[i]*sum{j in PILOTS} x[j][i]) <= sum{i in FLIGHTS} (Flights_Durations[i]*sum{j in ATTENDANTS} x[j][i]);


s.t. Breaks {i in PILOTS, j in FLIGHTS, k in FLIGHTS : j <> k}: x[i][k]*Departure_times[k] - x[i][j]*Arrival_times[j] >= Break_times[i];

s.t. Breaks {}: 
