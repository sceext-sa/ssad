// json_pretty_print
package org.sceext;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Iterator;

import mjson.Json;


public class JsonPretty {
    // exports public methods
    public static String print(Json data) {
        // default indent: 4 spaces
        return print(data, "    ");
    }

    public static String print(Json data, String indent) {
        return new W(data, indent).print();
    }

    // internal core worker class
    // FIXME TODO improve indent depth: use stack instead
    private static class W {
        // output result string
        private StringBuffer _o;
        // indent level
        private int _level = 0;

        private Json _data;
        private String _indent;

        public W(Json data, String indent) {
            _data = data;
            _indent = indent;

            _o = new StringBuffer();
        }

        private void _add_indent() {
            for (int i = 0; i < _level; i += 1) {
                _o.append(_indent);
            }
        }

        private void _print_array(Json d) {
            List<Json> l = d.asJsonList();
            // array start
            _o.append("[\n");
            _level += 1;

            boolean first = true;  // print first item
            // print each item in array
            for (Iterator<Json> i = l.iterator(); i.hasNext();) {
                // check first item
                if (first) {
                    first = false;
                } else {
                    _o.append(",\n");
                }
                _add_indent();
                _print(i.next());
            }
            _o.append("\n");
            _level -= 1;

            _add_indent();
            // array end
            _o.append("]");
        }

        private void _print_object(Json d) {
            Map<String, Json> m = d.asJsonMap();
            Set<String> key = m.keySet();  // object keys
            // object start
            _o.append("{\n");
            _level += 1;

            boolean first = true;
            // print each item in object
            for (Iterator<String> i = key.iterator(); i.hasNext();) {
                // check first item
                if (first) {
                    first = false;
                } else {
                    _o.append(",\n");
                }
                _add_indent();
                // print object name
                String k = i.next();
                _o.append(Json.make(k).toString() + ": ");

                _print(m.get(k));
            }
            _o.append("\n");
            _level -= 1;

            _add_indent();
            // object end
            _o.append("}");
        }

        private void _print(Json d) {
            // check json data type
            if (d.isObject()) {
                _print_object(d);
            } else if (d.isArray()) {
                _print_array(d);
            } else {
                // just print it as-is
                _o.append(d.toString());
            }
        }

        public String print() {
            _print(_data);
            // add line-end
            _o.append("\n");

            return _o.toString();
        }
    }
}
