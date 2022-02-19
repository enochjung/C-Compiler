int one()
{
	printf("-one-");
	return 1;
}

int two()
{
	printf("-two-");
	return 2;
}

int main()
{
	if (one() || two())
		printf("\n1. result is true\n");

	if (!one() && two())
		printf("\n2. result is true\n");
}
