
module snippets.common;

private import cairooo.all;

// Type for our callbacks
alias void function(Context cr, int width, int height) snippet_fn;

// Registry of snippets
snippet_fn[char[]] snippets_hash;

