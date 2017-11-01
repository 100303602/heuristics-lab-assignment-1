/*
 * Title:
 *     airline_problem.mod
 *
 * Description:
 *	Source code for computing the solution of
 *	airline problem in GLPK.
 * Authors:
 *     Alvaro Caceres Mu~noz (100303602)
 *     Guillermo Escobero Hernandez (100346060)
 */

/* Sets */
set CATEGORIES;
set COMPARTMENTS;
set NOSE_COMPARTMENTS within COMPARTMENTS;
set TAIL_COMPARTMENTS within COMPARTMENTS;

set FLIGHTS;
set MAD_VAL_FLIGHTS within FLIGHTS;
set VAL_MAD_FLIGHTS within FLIGHTS;
set CREW;
set PILOTS within CREW;
set ATTENDANTS within CREW;

/* Parameters */
param Costs              {i in CATEGORIES};
param Number_of_Bags     {i in CATEGORIES};
param Volumes            {i in CATEGORIES};
param Maximum_Volumes    {i in COMPARTMENTS};
param Weights            {i in CATEGORIES};
param Maximum_Weights    {i in COMPARTMENTS};

param Flights_Durations    {i in FLIGHTS};
param Time_Between_Flights {i in FLIGHTS, j in FLIGHTS};
param Break_Times          {i in PILOTS};
param Earnings   	   {i in CREW, j in FLIGHTS};


/* Variables */
var baggages 		{i in COMPARTMENTS, j in CATEGORIES} integer, >= 0;
var x 			{i in CREW, j in FLIGHTS} binary;

/* Objective function */

minimize Expenses: sum{j in CATEGORIES} (Costs[j] * (Number_of_Bags[j] - sum{i in COMPARTMENTS} baggages[i,j])) 
		 + sum{i in CREW} (sum{j in FLIGHTS}x[i,j] * (Earnings[i,j]/60) * Flights_Durations[j]);

/* Constraints */
s.t. Volume           {i in COMPARTMENTS}: sum{j in CATEGORIES} Volumes[j] * baggages[i,j] <= Maximum_Volumes[i];
s.t. Weight 	      {i in COMPARTMENTS}: sum{j in CATEGORIES} Weights[j] * baggages[i,j] <= Maximum_Weights[i];
s.t. Gravity_Center:                       sum{i in NOSE_COMPARTMENTS} (sum{j in CATEGORIES} Weights[j]*baggages[i,j]) >= 1.1 * sum{k in TAIL_COMPARTMENTS} (sum{l in CATEGORIES} Weights[l]*baggages[k,l]);
s.t. Baggage_Quantity {j in CATEGORIES}:   sum{i in COMPARTMENTS} baggages[i,j] <= Number_of_Bags[j];

s.t. Minimum_Pilots     {i in FLIGHTS}:    sum{j in PILOTS} x[j,i] >= 1;
s.t. Minimum_Attendants {i in FLIGHTS}:    sum{j in ATTENDANTS} x[j,i] >= 1;
s.t. Hours_Assigned:                       sum{i in FLIGHTS} (Flights_Durations[i]*sum{j in PILOTS} x[j,i]) <= sum{i in FLIGHTS} (Flights_Durations[i]*sum{j in ATTENDANTS} x[j,i]);
s.t. Breaks {i in FLIGHTS, j in FLIGHTS, k in PILOTS: i <> j and i < j}: Break_Times[k]*(x[k,i]+x[k,j]-1)<= Time_Between_Flights[i,j];

s.t. Location {i in CREW, j in FLIGHTS}: sum{k in MAD_VAL_FLIGHTS: k<j} x[i,k] - sum{l in VAL_MAD_FLIGHTS: l<j} x[i,l] <= 1;
s.t. Location2{i in CREW, j in FLIGHTS}: sum{k in VAL_MAD_FLIGHTS: k<j} x[i,k] - sum{l in MAD_VAL_FLIGHTS: l<j} x[i,l] <= 0;

end;
