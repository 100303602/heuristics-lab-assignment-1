#include <stdio.h>
#include <limits.h>
#include <math.h>

#define size 10 //maximum 10 cities
#define min(a,b) a>b ? b:a
#define sizePOW 1024 // 2^10

//Space complexity: O(n * 2^n)
//Time complexity: O(n^2 * 2^n)

int n;
int npow;
int g[size][sizePOW];
int p[size][sizePOW];
int adj[size][size];




int compute(int start, int set)
{
  int masked;
  int mask;
  //result stores the minimum
  int result = INT_MAX;
  int temp;
  int i;  

  //memoization DP top-down, check for repeated subproblem
  if(g[start][set] !=- 1) {
    return g[start][set];
  }

  for(i=0; i<n; i++) {
    // npow-1 because we always exclude "home" vertex from our set
    //remove ith vertex from this set
    mask = (npow-1) - (1<<i);
    masked = set&mask;

    // In case same set is generated(because ith vertex was not present
    // in the set hence we get the same set on removal) eg 12&13=12
    if(masked != set) {
      //compute the removed set
      temp = adj[start][i] + compute(i, masked);
      if(temp < result) {
	//removing ith vertex gave us minimum
	result = temp, p[start][set] = i;
      }
    }
  }

  //return minimum
  return g[start][set] = result;
}




void getpath(int start, int set)
{
  if(p[start][set] == -1) {
    //reached null set
    return;
  }

  int x = p[start][set];
  int mask = (npow-1) - (1<<x);
  int masked = set&mask;

  //remove p from set
  printf("%d ", x);

  getpath(x, masked);
}




void TSP()
{
  int i;
  int j;

  // g(i,S) is length of shortest path starting at i,
  // visiting all vertices in S and ending at 1
  for(i=0; i<n; i++) {
    for(j=0; j<npow; j++) {
      g[i][j] = p[i][j] = -1;
    }
  }
  for(i=0; i<n; i++) {
    // g(i,nullset) = direct edge between (i,1)
    g[i][0] = adj[i][0];
  }

  // npow-2 to exclude our "home" vertex
  int result = compute(0, npow-2);

  printf("Tour cost:%d\n", result);
  printf("Tour path:\n0 ");
  getpath(0, npow-2);
  printf("0\n");
}




int main(void) {
  int i;
  int j;

  printf("Enter number of cities\n");
  scanf("%d", &n);

  // bit number required to represent all possible sets
  npow = (int) pow(2, n);

  printf("Enter the adjacency matrix\n");
  for (i=0; i<n; i++) {
    for (j=0; j<n; j++) {
      scanf("%d", &adj[i][j]);
    }
  }

  TSP();

  return 0;
}



/*
Recursion tree for given input
					     	g(0,{1,2,3})
									14
             /                      |                \
		12							10               6
    g(1,{2,3})                g(2,{1,3})            g(3,{1,2})

    /         \             /          \             |       \
  8            4          8             2           4           2
g(2,{3})   g(3,{2})     g(1,{3})     g(3,{1})    g(1,{2})    g(2,{1})  

  /            |            |           |           |             |    
 0             0            0           0           0             0
g(3,null)   g(2,null)    g(3,null)   g(1,null)   g{2,null)    g(1,null)
*/
