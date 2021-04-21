#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <string.h>
#include "RNGen.h"

int NUM_THREADS= 8;
int ArraySize=1024;

int Log2n(int n);

void prefix_sum(int *A, int ArrSize)
{

    int T=A[ArraySize-1];
    int h=Log2n(ArraySize);
    for(int i=0;i<=h-1;i++)
    {
        int d=1<<i;
        #pragma omp parallel for shared(A,i,h)
        for(int j=0;j<ArraySize-1;j=j+2*d)
        {
                A[j+2*d-1]=A[j+d-1]+A[j+2*d-1];
        }
        
    }
    A[ArraySize-1]=0;
    for(int i=h-1;i>=0;i--)
    {
        int d=1<<i;
        #pragma omp parallel for shared(A,i,h)
        for(int j=0;j<ArraySize-1;j=j+2*d)
        {
                int t=A[j+d-1];
                A[j+d-1]=A[j+2*d-1];
                A[j+2*d-1]=A[j+2*d-1]+t;

        }

    }
    A[ArraySize-1]+=T;

    return ;
}

void DataCompaction(int *A,int *A1,int *B,int ArraySize)
{

    #pragma omp parallel for shared(A,A1)  // Initialisation  of Auxillary array
    for(int i=0;i<ArraySize;i++)
    {
        A1[i]=(A[i]!=0)?1:0;
    }

    prefix_sum(A1,ArraySize);    

    #pragma omp parallel for shared(A,A1)
    for(int i=0;i<ArraySize;i++)  // Data Compation in Output Array
    {
        if(A[i]!=0)
        {
            B[A1[i]-1]=(A1[i]!=0)?A[i]:0;
        }
    }  

}



//export OMP_NUM_THREADS=4 (for bash)
int main()
{   

    double start,end;
    int *A=LCG_Random(ArraySize);  // Input Array
    int *B1=(int *)calloc(ArraySize,sizeof(int)); // Output Array    
    int *A1=(int *)calloc(ArraySize,sizeof(int)); // Auxillary Array

    int H[4]={2,4,8,16}; // Data Compaction on 2,4,6,8 Threads
    for(int i=0;i<4;i++)
    {
        NUM_THREADS=H[i];
        omp_set_num_threads(NUM_THREADS);

        start=omp_get_wtime();
        DataCompaction(A,A1,B1,ArraySize);
        end=omp_get_wtime();

        printf("Time Taken By Data compaction Using %d Threads: %fs\n",NUM_THREADS,end-start);

        if(A1!=NULL){free(A1);A1=NULL;}
        int *B2=(int *)calloc(ArraySize,sizeof(int));
        A1=(int *)calloc(ArraySize,sizeof(int));

    }

    return 0;

}

int Log2n(int n)
{
    return (n > 1) ? 1 + Log2n(n / 2) : 0;
}
