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
var x {i in COMPARTMENTS, j in CATEGORIES} binary;

/* Objective function */
minimize Expense: sum{i in CATEGORIES} (Costs[i] * (Number_of_Bags[i] - sum{j in COMPARTMENTS} x[i,j]));

/* Constraints */
s.t. Volume {i in COMPARTMENTS}:          sum{j in CATEGORIES} Volumes[j] * x[i,j] <= Maximum_Volumes[i];
s.t. Weight {i in COMPARTMENTS}:          sum{j in CATEGORIES} Weights[j] * x[i,j] <= Maximum_Weights[i];
s.t. Gravity_Center:                      sum{i in NOSE_COMPARTMENTS} (sum{j in CATEGORIES} Weights[j]*x[i,j]) >= 1.1 * sum{k in TAIL_COMPARTMENTS} (sum{l in CATEGORIES} Weights[l]*x[k,l]);
s.t. Baggage_Quantity {i in CATEGORIES}:  sum{j in COMPARTMENTS} x[i,j] <= Number_of_Bags[i];

end;
