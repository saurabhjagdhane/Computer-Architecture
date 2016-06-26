#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#define BILLION  1000000000L;

int a[1000], b[1000], c[1000];
FILE *fp;
FILE *fp1;
double duration;
struct timespec start_add, end_add, start_mult, end_mult;

void main(){
	int x;
    int vec_mult(int n);
	int vec_add(int n);
	fp = fopen("project5_mult_vector","w");
	fp1 = fopen("project5_add_vector","w");
	for (x=0; x<=512; x+=8){

        clock_gettime(CLOCK_MONOTONIC, &start_mult);
		vec_mult(x);  //MULT
        clock_gettime(CLOCK_MONOTONIC, &end_mult);
        duration = ( end_mult.tv_sec - start_mult.tv_sec ) + (double)( end_mult.tv_nsec - start_mult.tv_nsec ) / (double)BILLION;
        fprintf(fp,"Total time for MULT loop = %E\n",duration);

    
        clock_gettime(CLOCK_MONOTONIC, &start_add);
		vec_add(x);   //ADD
        clock_gettime(CLOCK_MONOTONIC, &end_add);
        duration = ( end_add.tv_sec - start_add.tv_sec ) + (double)( end_add.tv_nsec - start_add.tv_nsec ) / (double)BILLION;
        fprintf(fp1,"Total time for ADD loop = %E\n",duration);

	    }
    fclose(fp1);
	fclose(fp);
}

int vec_add(int n){
	for (int i=0; i<n; i++){
		c[i] = a[i]*100+b[i];
	}
	return 0;
}	

int vec_mult(int n){
	for (int i=0; i<n; i++){
		c[i] = a[i]*b[i];
    }
	return 0;
}	
