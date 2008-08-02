/*******************************************************************************

	copyright:      Copyright (c) 2008 Matthias Walter. All rights reserved

    authors:        Matthias Walter

*******************************************************************************/

module lua.meta;

private import meta.Identifier, meta.Type;

public template mixinLuaRegister (char[] state, alias target, char[] name)
{
	static if (isFunction !(target))
	{
		const char[] mixinLuaRegister = "mixin(mixinLuaRegisterFunction (\"" ~ state ~ "\", \"" ~ fullyQualifiedNameOf !(target) ~ "\", \"" ~ name ~ "\"));";
	}
	else static if (isMethod !(target))
	{
		const char[] mixinLuaRegister = "mixin(mixinLuaRegisterMethod (\"" ~ state ~ "\", \"" ~ fullyQualifiedNameOf !(target) ~ "\", \"" ~ name ~ "\"));";
	}
	else
	{
		const char[] mixinLuaRegister = "mixin(mixinLuaRegisterConstructor (\"" ~ state ~ "\", \"" ~ fullyQualifiedNameOf !(target) ~ "\", \"" ~ name ~ "\"));";
	}
}