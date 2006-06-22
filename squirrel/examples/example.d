import std.stdio;

import squirreld, squirrel, sqstdlib;
import std.c.stdarg, std.c.stdio;

int main(char[][] argv) {
	Squirrel s = new Squirrel;
		s.setdefaultprintfunc();

		s.vmcall(&sqstd_register_bloblib);
		s.vmcall(&sqstd_register_iolib);
		s.vmcall(&sqstd_register_mathlib);
		s.vmcall(&sqstd_register_stringlib);
		s.vmcall(&sqstd_register_systemlib);

		s.executeFile("test.nut");

		s.call("foo", 1, 2.5, "teststring");
	delete s;

	return 0;
}
