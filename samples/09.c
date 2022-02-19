int main()
{
	int i, j;

	i = 0;
	j = 10;

	do
	{
		printf("*");

		if (++i < j)
			continue;

		printf("\n");

		i = 0;
		if (--j == 0)
			break;

	} while (1);
}
