/* Sets */
set CELL;

/* Parameters */
param Cost      {i in CELL};
param Power     {i in CELL};
param Area      {i in CELL};
param Chemicals {i in CELL};

/* Variables */
var units {i in CELL} integer, >= 0;

/* Objective function */
minimize Expense: sum{i in CELL} Cost[i]*units[i];

/* Constraints */
s.t. Power_Constraint:     sum{i in CELL} Power[i]     * units[i] >= 2400;
s.t. Chemicals_Constraint: sum{i in CELL} Chemicals[i] * units[i] <= 700;
s.t. Area_Constraint:      sum{i in CELL} Area[i]      * units[i] <= 2;