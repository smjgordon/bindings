
module snippets.common;

private import cairo.cairo;

// Type for our callbacks
alias void function(cairo_t* cr, int width, int height) snippet_fn;

// Registry of snippets
snippet_fn[char[]] snippets_hash;

