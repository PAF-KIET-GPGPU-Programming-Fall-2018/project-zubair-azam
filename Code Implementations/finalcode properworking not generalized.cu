#include <stdio.h>
#include <string>
#include <cstring>
#include <cstdlib>
#include <iostream>
#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <ctime>

using namespace std;
#define size 1024

__global__
void mykernel(int *transbit, int *pattern, int * result, int pl,int tn, int tp, int *bits)
{
	int tid = blockIdx.x * blockDim.x + threadIdx.x;
	int i= tid*pl;
	int support=0;
	if (i < tp)
	{
		const int bitslength = tn;
		
		for (int i9 = 0; i9 < tn; i9++)
		{
			for (int i2 = 0; i2 < pl; i2++)
			{      int pi = pattern[i+i2];
				bits[i9] *= transbit[pi*tn+i9];
			}
		}
		for(int i2=0;i2 <tn;i2++)
		{ support=support+bits[i2];
 		}
	}
		result[tid]=support;
}
int main()
{

	const int Ntbits=1000;
	int transbit[Ntbits] = {1,1,1,0,1,0,1,1,1,0,1,1,1,0,1,1,0,0,1,0,1,1,1,0,0,0,1,0,1,1,1,1,0,1,0,1,1,0,0,0,0,1,0,1,0,0,1,1,1,0,0,1,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,1,1,0,1,1,1,1,0,1,0,0,0,1,1,0,1,0,1,0,0,1,1,0,1,1,1,1,0,0,0,1,1,0,1,0,1,1,1,1,1,1,1,0,1,1,0,1,0,0,0,1,1,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,0,0,1,0,1,0,1,1,0,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,1,0,1,1,0,1,1,0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,0,1,0,0,0,1,1,0,1,1,1,1,1,0,0,1,1,0,1,0,1,1,1,0,1,0,0,0,1,1,0,0,1,1,0,0,0,1,0,1,0,0,0,1,0,1,1,0,0,1,0,1,0,0,0,1,1,0,1,0,0,1,1,1,1,0,1,1,1,0,0,0,0,1,1,0,0,0,1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,0,0,0,0,0,0,1,0,1,1,1,1,0,0,1,1,0,0,1,0,1,1,1,0,1,1,0,1,0,1,0,1,1,1,0,1,0,0,1,0,1,1,1,1,1,0,1,0,0,1,0,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,0,1,0,1,1,0,0,1,1,1,1,0,0,1,0,0,0,1,0,1,1,0,1,0,0,0,1,0,0,0,1,1,1,1,1,0,1,0,0,1,1,0,1,0,0,0,1,1,0,1,1,0,1,1,0,0,0,1,1,1,1,0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,1,0,0,1,0,1,0,1,1,0,0,0,1,1,1,1,0,1,0,1,1,0,1,0,0,0,1,0,0,1,0,0,1,0,1,1,1,0,0,1,1,1,1,1,1,0,1,1,0,0,1,1,0,1,0,0,0,0,0,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,1,0,1,1,0,0,1,0,0,1,0,1,0,1,0,1,1,1,0,0,0,0,1,0,0,0,0,1,1,1,1,1,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,1,0,1,0,1,0,1,1,1,0,1,0,0,1,0,0,1,1,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,0,0,1,0,1,1,1,0,1,1,1,0,1,1,1,1,0,0,0,0,0,1,0,1,1,1,1,0,0,0,1,0,0,1,0,0,1,1,0,0,1,1,1,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,1,0,0,0,0,1,0,1,0,0,1,1,0,1,0,0,1,1,0,0,0,0,0,0,1,0,1,1,1,1,0,1,0,1,1,0,0,1,0,1,0,0,0,0,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1,0,0,0,1,0,0,0,1,1,1,1,0,1,0,0,1,0,1,0,1,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,1,1,1,0,1,1,1,0,1,0,0,1,1,1,1,0,0,1,0,1,1,0,1,1,0,1,1,1,0,1,0,1,1,1,1,0,1,0,1,0,1,0,0,0,0,0,0,1,1,1,1,1,1,0,1,1,0,0,1,0,0,0,1,1,0,0,1,1,1,0,0,0,0,1,1,0,1,0,1,1,0,0,1,0,0,1,1,1,0,0,0,1,0,0,0,1,1,1,0,1,0,1,1,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,1,0,0,0,1,0,0,0,1,1,0,1,0,0,1,0,0,0,0,1,1,0,0,0,1,1,0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,1,1,1,1,0,1,0,1,1,1,0,0,0,0,0,0,1,0,0,1,1,1,1,0,1,0,1,1,0,0,0,0,1,0,1,0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1,1};
const int transNo =100;
const int patternLength = 3;
int totalpatrn = 2;
int bits[transNo] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};

	const int Nofpatrn = totalpatrn*patternLength;
	int pattern[Nofpatrn] = { 0,1,3,	1,2,3 };
	int results[Nofpatrn] = {};
	
	int *d_transbit;
	int *d_pattern;
	int *d_result;
	int *d_bits;

	cudaMalloc(&d_transbit, sizeof(int)*Ntbits);
	cudaMalloc(&d_pattern, sizeof(int) * Nofpatrn);
	cudaMalloc(&d_result, sizeof(int) * Nofpatrn);
	cudaMalloc(&d_bits, sizeof(int) * transNo);
	cudaMemcpy(d_transbit, transbit, sizeof(int) * Ntbits, cudaMemcpyHostToDevice);
	cudaMemcpy(d_pattern, pattern, sizeof(int) * Nofpatrn, cudaMemcpyHostToDevice);
	cudaMemcpy(d_bits, bits, sizeof(int) * transNo, cudaMemcpyHostToDevice);

	mykernel<<<1, totalpatrn>>>(d_transbit, d_pattern, d_result, patternLength,transNo,Nofpatrn,d_bits);
	cudaDeviceSynchronize();
	cudaMemcpy(results, d_result, sizeof(int) * Nofpatrn, cudaMemcpyDeviceToHost);

	printf("GPU result\n");	
	for (int i2 = 0; i2 < transNo; i2++)
	{
		printf("%d", results[i2]);

	}
	printf("\n");
 clock_t begin = clock();
 
	for (int i = 0; i < 2; i++)// till pattern length
	{
		
		for (int i2 = 0; i2 < patternLength; i2++)
		{	int point = 0;
			
			for (int i9 = 0; i9 < transNo; i9++)
			{
							
				bits[i9] = bits[i9] * transbit[point + (pattern[(i+1)*i2] * transNo)];
				point++;
				
			}
			printf("\n");
	}

	}
 	clock_t end = clock();
   double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
 printf("%lf", elapsed_secs);
 
	cudaFree(d_transbit);
	cudaFree(d_pattern);
	cudaFree(d_result);
	return 0;
	
}
