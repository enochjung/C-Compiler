int fibonacci(int x)
{
	if (x <= 1)
		return 1;
	return fibonacci(x-1) + fibonacci(x-2);
}

int main()
{
	int i;

	while (i <= 10)
	{
		printf("fibonacci(%d) = %d\n", i, fibonacci(i));
		i++;
	}
}
