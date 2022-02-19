int* find(int array[], int array_size, int target)
{
	int i;

	for (i=0; i<array_size; ++i)
		if (*(array+i) == target)
			return &array[i];
	return array+i;
}

int main()
{
	int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	int *p, *q;
	int dist;

	p = find(a, 10, 3);
	q = find(a, 10, 8);
	dist = (int)(q - p);

	printf("p : %d\n", p);
	printf("q : %d\n", q);
	printf("distance between 3, 8 is %d\n", dist);

	return 0;
}
