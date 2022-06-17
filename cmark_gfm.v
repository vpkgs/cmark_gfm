module cmark_gfm

#pkgconfig --libs --cflags libcmark-gfm
#flag -I @VMODROOT/.
#include "cmark-gfm-extension_api.h"
#include "cmark-gfm-core-extensions.h"
#include "cmark-gfm.h"

fn C.cmark_markdown_to_html(text &char, len usize, options int) &char
fn C.cmark_parse_document(text &char, len usize, options int) &C.cmark_node
fn C.cmark_render_html(root &C.cmark_node, options int, extensions &C.cmark_llist) &char
fn C.cmark_get_arena_mem_allocator() &C.cmark_mem
fn C.cmark_parser_new(options int) &C.cmark_parser
fn C.cmark_parser_new_with_mem(options int, mem &C.cmark_mem) &C.cmark_parser
fn C.cmark_parser_free(parser &C.cmark_parser)
fn C.cmark_parser_attach_syntax_extension(parser &C.cmark_parser, ext &C.cmark_syntax_extension)
fn C.create_table_extension() &C.cmark_syntax_extension
fn C.cmark_find_syntax_extension(name &char) &C.cmark_syntax_extension
fn C.cmark_parser_get_syntax_extensions(parser &C.cmark_parser) &C.cmark_llist
fn C.cmark_gfm_core_extensions_ensure_registered()

//  Feeds a string of length len to parser.
fn C.cmark_parser_feed(parser &C.cmark_parser, buffer &char, len usize)
fn C.cmark_parser_finish(parser &C.cmark_parser) &C.cmark_node

[typedef]
struct C.cmark_parser {}
[typedef]
struct C.cmark_node {}

pub type Parser = C.cmark_parser
pub type Node = C.cmark_node

pub fn register_extensions() {
	C.cmark_gfm_core_extensions_ensure_registered()
}

pub fn find_syntax_extension(name &char) &C.cmark_syntax_extension {
	return C.cmark_find_syntax_extension(name)
}

pub fn new_parser_with_option(options int) &Parser {
	return unsafe {&Parser(C.cmark_parser_new(options))}
}

pub fn (parser &Parser) attach_syntax_extension(ext &C.cmark_syntax_extension) {
	C.cmark_parser_attach_syntax_extension(parser, ext)
}

pub fn (parser &Parser) feed(content string) {
	C.cmark_parser_feed(parser, content.str, content.len)
}

pub fn (parser &Parser) finish() &Node {
	return unsafe {&Node(C.cmark_parser_finish(parser))}
}

pub fn (parser &Parser) get_syntax_extensions() &C.cmark_llist {
	return C.cmark_parser_get_syntax_extensions(parser)
}

pub fn (node &Node) render_html(options int, extensions &C.cmark_llist) string {
	return render_html(unsafe {&C.cmark_node(node)}, options, extensions)
}

[inline]
pub fn render_html(root_node &C.cmark_node, options int, extensions &C.cmark_llist) string {
	res := C.cmark_render_html(root_node, options, extensions)
	html := unsafe { res.vstring() }
	return html
}
