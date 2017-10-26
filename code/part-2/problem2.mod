set FLIGHTS := v1 v2 v3 v4 v5 v6;
set MADRID_VALENCIA_FLIGHTS within FLIGHTS := v1 v3 v5;
set VALENCIA_MADRID_FLIGHTS within FLIGHTS := v2 v4 v6;

set CREW;
set PILOTS within CREW := p1 p2 p3;
set ATTENDANTS within CREW := a1 a2 a3;

set ORDER := o1 o2 o3 o4 o5 o6;


s.t. Breaks {i in PILOTS, j in FLIGHTS, k in FLIGHTS, m in ORDER : j <> k}: x[i][k][m]*Departure_times[k] - x[i][j][m]*Arrival_times[j] >= Break_times[i];

s.t. Crew_availability {i in CREW, j in FLIGHTS, k in FLIGHTS, m in ORDER, n in ORDER, k not in CAN_DEPART_FROM[j] : j <> k, n = m+1}: x[i][k][n] <= 0;
