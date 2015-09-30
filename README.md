# Thesis source code

My PhD thesis is written in Markdown and converted in Latex + pdf with Pandoc. The original template is largely inspired from https://github.com/chiakaivalya/thesis-markdown-pandoc.

## Informations

My thesis is about _the dynamic and modeling of chromosome during mitosis in fission yeast_. It's all written in __french__ except [a summary in english](text/1_start/3_summary.md#summary).

You can access to the final pdf [here](thesis.pdf).

## How to build

### Requirements

- `pandoc`
- `pandoc-citeproc` : enable citation in Markdown
- `pandoc-crossref` : enable cross reference in Markdown
- all the necessary requirements to compile latex projects

### Build

```sh
make pdf
```

## Author

Hadrien Mary

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
