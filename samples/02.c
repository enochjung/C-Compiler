int main()
{
	int a[] = {1, 2, 3};
	float f = 5.0;
	int* c = a + 2;

	a[0] = a[1]*a[2] - a[0];
	f = 10 - (-f) * 2;
	*c = 99;

	printf("f:%f\n", f);
	printf("a[0]:%d, a[1]:%d, a[2]:%d\n", a[0], a[1], a[2]);
}

