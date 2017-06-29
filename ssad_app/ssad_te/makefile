

JS_LIB_R= -r react -r react-dom -r create-react-class -r prop-types -r react-redux -r immutable -r redux -r redux-thunk -r redux-devtools-extension -r react-bootstrap -r path -r url -r querystring
JS_LIB_X= -x react -x react-dom -x create-react-class -x prop-types -x react-redux -x immutable -x redux -x redux-thunk -x redux-devtools-extension -x react-bootstrap -x path -x url -x querystring


dev_dist: bundle css
	cp ./node_modules/jquery/dist/jquery.js dist/

	mkdir -p dist/bootstrap/css/
	cp ./node_modules/bootstrap/dist/css/bootstrap.css dist/bootstrap/css/
	cp ./node_modules/bootstrap/dist/css/bootstrap-theme.css dist/bootstrap/css/
	mkdir -p dist/bootstrap/fonts/
	cp ./node_modules/bootstrap/dist/fonts/glyphicons-halflings-regular.woff2 dist/bootstrap/fonts/

	cp static/ssad_te.dev.html dist/
.PHONY: dev_dist

js_lib:
	mkdir -p dist/
	./node_modules/.bin/browserify -d $(JS_LIB_R) -o dist/lib.js
.PHONY: js_lib

bundle: js
	mkdir -p dist/
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
