{
  var _ = require('lodash');
}

start  // thx @ http://stackoverflow.com/a/10708913/1034080
  = first:line tail:(newline line)* newline? {
      return [first].concat(_.pluck(tail, 1));
    }
  / newline? {
      return [];  // TODO: never reached?
    }

newline
  = '\n'

line
  = indent:indent lineContent:lineContent {
      return [indent].concat(lineContent);
    }

lineContent
  = '//' comment:$[^\n]* {
      return [ '//', comment ];
    }
  / string:string {
      return [ string ];
    }
  / groupable
  / '' {
      return [ null ];
    }

groupable
  = head:name tail:(' '+ (wrappedName / string / group))* {
      return tail !== null ? [head, _.pluck(tail, 1)] : [head];
    }

group
  = '(' groupable:groupable ')' {
      return [groupable];
    }

name
  = $[a-z]+

wrappedName
  = name:name {
      return [name, []];
    }

indent
  = ('  ')*

// Based on: pegjs/examples/javascript.pegjs (v 0.8.0)

string
  = '"' chars:$(char*) '"' { return [chars]; }

char
  = !('"' / '\\' / '\n') char_:. { return char_; }
  / '\\' escSeq:escSeq { return escSeq; }

escSeq
  = char_:['"\\bfnrt] {
      return char_
        .replace('b', '\b')
        .replace('f', '\f')
        .replace('n', '\n')
        .replace('r', '\r')
        .replace('t', '\t');
    }
