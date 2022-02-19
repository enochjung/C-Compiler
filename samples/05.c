void func(int x)
{
	if (x == 1)
		printf("x is 1!!\n");
	else
		printf("x is not 1.\n");
}

int main()
{
	void (*p)(int);
	p = func;

	printf("1: ");
	func(0);

	printf("2: ");
	p(0);

	printf("3: ");
	(p+(0+(0+(1)-1)))(0);
}
