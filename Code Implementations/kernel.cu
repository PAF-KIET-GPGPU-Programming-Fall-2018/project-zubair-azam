#include <stdio.h>
#include <string>
#include <cstring>
#include <cstdlib>
#include <iostream>

using namespace std;

#define size 1024

void add(int *a, int *b, int *c, int n)
{
	for (int i = 0; i < n; i++)
	{
		c[i] = a[i] = b[i];
	}

}


string array2[] = { "apple", "banana", "lemon", "mango" };
string result[3];//combi size
const int pairleng = 1;
string totalresult[pairleng];// total pair
int tri = 0;
int rlen = 3;

int factorial(int num, int limit)
{
	int fact = 1;
	int limitn = 1;
	for (int i = num; i > limit; i--)
	{
		fact = fact*i;
	}
	for (int i = (num - limit); i > 0; i--)
	{
		limitn = limitn*i;
	}
	fact = fact / limitn;

	return fact;
}

void combine(string input[], int len, int start, int ilen)
{
	if (len == 0)
	{
		string res = "";
		for (int i = 0; i < rlen; i++)
		{
			// cout << result[i];
			res = res + " " + result[i];
		}
		totalresult[tri] = res;
		res = "";
		tri++;

		// cout << "\n";

		 //process here the result

		return;
	}

	for (int i = start; i <= ilen - len; i++)
	{

		result[rlen - len] = input[i];
		combine(input, len - 1, i + 1, ilen);
	}
}

void main()
{

	//cout<< factorial(totalarraysize, combinationN);
	//cout << sizeof(totalresult) / sizeof(totalresult[0]);
	combine(array2, 3, 0, 4);


	for (size_t i = 0; i < 4; i++)
	{
		//cout << totalresult[i] + "\n";

	}


	int trans[4][10] =
	{	{1,0,0,1,1,0,1,1,1,1},
		{1,1,0,0,0,1,0,0,1,1},
		{1,0,0,1,0,1,0,0,1,1},
		{1,0,0,1,0,0,1,0,1,0} };

	for (size_t i = 0; i < 4; i++)
	{
		//cout << array2[i] + "\n";

	}


	for (size_t i = 0; i < 3; i++)
	{
		int sum = 0;
		for (size_t i2 = 0; i2 < 10; i2++)
		{
			sum += (trans[i][i2] * trans[i + 1][i2]);
		}

	//	cout << array2[i] + array2[i + 1];
		//cout << "\n";
		cout << sum;
		cout << "\n";
	}


}
