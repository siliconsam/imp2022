
// Store a simple count
static int count = 13;

extern void xzero()
{
    count = 0;
}

extern void xinc()
{
    count++;
}

extern void xdec()
{
    count--;
}

extern int xvalue()
{
    return count;
}
