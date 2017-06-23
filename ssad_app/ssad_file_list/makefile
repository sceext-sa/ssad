

dist_dev: bundle css
	cp static/ssad_file_list.dev.html dist/
.PHONY: dist_dev

dist: bundle css
	cp static/ssad_file_list.html dist/
.PHONY: dist

bundle: js
	browserify js/index.js -o dist/bundle.js
.PHONY: bundle

js:
	./node_modules/.bin/coffee -o js/ src/
.PHONY: js

css:
	./node_modules/.bin/lessc style/main.less dist/main.css
.PHONY: css
