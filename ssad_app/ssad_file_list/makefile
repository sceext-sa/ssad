

dist_dev: bundle css
	cp static/ssad_file_list.dev.html dist/
.PHONY: dist_dev

dist: bundle css js_lib
	cp static/ssad_file_list.html dist/
.PHONY: dist

js_lib:
	./node_modules/.bin/browserify -d -r immutable -r redux -r redux-thunk -r create-react-class -o dist/lib.js
.PHONY: js_lib

bundle: js
	./node_modules/.bin/browserify -d -x immutable -x redux -x redux-thunk -x create-react-class js/index.js -o dist/bundle.js
.PHONY: bundle

js:
	./node_modules/.bin/coffee -o js/ src/
.PHONY: js

css:
	./node_modules/.bin/lessc style/main.less dist/main.css
.PHONY: css
