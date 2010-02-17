module magick.magick;

align(1):

extern (C)
{
void DestroyMagick();
void InitializeMagick(char* path);
}

	public void InitializeMagick(char[][] args)
	{
		char** argv = (new char*[args.length]).ptr;
		int argc = 0;
		foreach (char[] p; args)
		{
			argv[argc++] = cast(char*)p;
		}
		
		//InitializeMagick(&argc,&argv);
		InitializeMagick(*argv);//GM only needs argv.
	}