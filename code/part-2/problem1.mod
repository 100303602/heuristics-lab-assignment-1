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

/* Sets */
set CATEGORIES;
set COMPARTMENTS;
set NOSE_COMPARTMENTS within COMPARTMENTS;
set TAIL_COMPARTMENTS within COMPARTMENTS;

/* Parameters */
param Costs              {i in CATEGORIES};
param Number_of_Bags     {i in CATEGORIES};
param Volumes            {i in CATEGORIES};
param Maximum_Volumes    {i in COMPARTMENTS};
param Weights            {i in CATEGORIES};
param Maximum_Weights    {i in COMPARTMENTS};

/* Variables */
var baggages {i in COMPARTMENTS, j in CATEGORIES} integer, >= 0;

/* Objective function */
minimize Expense: sum{j in CATEGORIES} (Costs[j] * (Number_of_Bags[j] - sum{i in COMPARTMENTS} baggages[i,j]));

/* Constraints */
s.t. Volume {i in COMPARTMENTS}:          sum{j in CATEGORIES} Volumes[j] * baggages[i,j] <= Maximum_Volumes[i];
s.t. Weight {i in COMPARTMENTS}:          sum{j in CATEGORIES} Weights[j] * baggages[i,j] <= Maximum_Weights[i];
s.t. Gravity_Center:                      sum{i in NOSE_COMPARTMENTS} (sum{j in CATEGORIES} Weights[j]*baggages[i,j]) >= 1.1 * sum{k in TAIL_COMPARTMENTS} (sum{l in CATEGORIES} Weights[l]*baggages[k,l]);
s.t. Baggage_Quantity {j in CATEGORIES}:  sum{i in COMPARTMENTS} baggages[i,j] <= Number_of_Bags[j];

end;
