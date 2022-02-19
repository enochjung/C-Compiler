void swap(int* a, int* b)
{
	int tmp = *a;
	*a = *b;
	*b = tmp;
}

void sort(int array[], int array_size)
{
	int i, j;

	for (i=0; i<array_size; ++i)
		for (j=i+1; j<array_size; ++j)
			if (array[i] > array[j])
				swap(array+i, array+j);

	return;
}

int main()
{
	int n, a[100];
	int i;

	scanf("%d", &n);
	for (i=0; i<n; ++i)
		scanf("%d", a+i);

	sort(a, n);

	for (i=0; i<n; ++i)
		printf("%d ", a[i]);

	return 0;
}
