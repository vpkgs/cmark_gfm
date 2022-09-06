## Usage

```v
import encoding.base64
import cmark_gfm as cmg

fn main() {
	content := '# Hello, World!

- 1
- 2
- 3
'
	title := 'hello world'

	options := C.CMARK_OPT_VALIDATE_UTF8 | C.CMARK_OPT_GITHUB_PRE_LANG | C.CMARK_OPT_TABLE_PREFER_STYLE_ATTRIBUTES | C.CMARK_OPT_FULL_INFO_STRING | C.CMARK_OPT_SMART | C.CMARK_OPT_GITHUB_PRE_LANG | C.CMARK_OPT_LIBERAL_HTML_TAG | C.CMARK_OPT_FOOTNOTES | C.CMARK_OPT_STRIKETHROUGH_DOUBLE_TILDE | C.CMARK_OPT_UNSAFE | C.CMARK_OPT_HARDBREAKS

	cmg.register_extensions()

	parser := cmg.new_parser_with_option(options)
	syntax_extension := cmg.find_syntax_extension(c'table')
	parser.attach_syntax_extension(syntax_extension)
	parser.feed(content)
	root_node := parser.finish()

	html := root_node.render_html(options, parser.get_syntax_extensions())
	href := get_css_href()?

	println('<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$title</title>
  <link rel="stylesheet" href="$href">
</head>
<body>
<div class="markdown-body">
$html
</div>
</body>
</html>')
}

fn get_css_href() ?string {
	ss := '.markdown-body {
  max-width: 880px;
  margin: 0 auto;
}'

	href := 'data:text/css;base64,${base64.encode_str(ss)}'

	return href
}
```


## Develop

https://github.com/github/cmark-gfm

```sh
man 3 cmark-gfm
```


## License 
MIT or MIT-0 at your choice.
