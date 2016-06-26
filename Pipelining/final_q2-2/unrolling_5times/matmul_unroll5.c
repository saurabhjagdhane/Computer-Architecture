#include <stdio.h>

int A[10][10], B[10][10], C[10][10];

int main()

{
int i, j, k;
for (i=0; i<10; i++) {
    for (j=0; j<10; j++) {
		A[i][j]=i+j;
		
	}
}
for (i=0; i<10; i++) {
    for (j=0; j<10; j++) {
		B[i][j]=(i+j)*2;
		
	}
}

for (i=0; i<10; i++)
    for (j=0; j<10; j++)
        for (k=0; k<10; k+=5){
                        C[i][j]+=A[i][k]*B[k][j];
						C[i][j]+=A[i][k+1]*B[k+1][j];
						C[i][j]+=A[i][k+2]*B[k+2][j];
						C[i][j]+=A[i][k+3]*B[k+3][j];
						C[i][j]+=A[i][k+4]*B[k+4][j];
			}

for (i=0; i<10; i++)
    for (j=0; j<10; j++)
  printf ("%d\n", C[i][j]);

return 0;
}

