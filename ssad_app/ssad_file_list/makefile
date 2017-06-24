
JS_LIB_R= -r react -r react-dom -r create-react-class -r react-redux -r immutable -r redux -r redux-thunk -r redux-devtools-extension -r path -r url -r querystring
JS_LIB_X= -x react -x react-dom -x create-react-class -x react-redux -x immutable -x redux -x redux-thunk -x redux-devtools-extension -x path -x url -x querystring


dist_dev: bundle css
	cp ./node_modules/jquery/dist/jquery.js dist/
	cp static/ssad_file_list.dev.html dist/
.PHONY: dist_dev

dist: bundle css js_lib
	cp ./node_modules/jquery/dist/jquery.min.js dist/
	cp static/ssad_file_list.html dist/
.PHONY: dist

js_lib:
	./node_modules/.bin/browserify -d $(JS_LIB_R) -o dist/lib.js
.PHONY: js_lib

bundle: js
	./node_modules/.bin/browserify -d $(JS_LIB_X) js/index.js -o dist/bundle.js
.PHONY: bundle

js:
	./node_modules/.bin/coffee -o js/ src/
.PHONY: js

css:
	./node_modules/.bin/lessc style/main.less dist/main.css
.PHONY: css


clean:
	- rm -rf dist/
	- rm -rf js/
.PHONY: clean
