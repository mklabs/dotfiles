#!/usr/bin/env node

// 
// Helper to convert node doc/api page to something more compliant
// with ronn fortmat.
//
// Usage:
//
//    node build.js
//
// Will generate the ronn verson of the markdown file in node/doc/api, and
// output the result in node/man.
//
// Replace the markdown title, usually the first ##, by the front man
// page template.
//
//    node-$0(3) -- http://nodejs.org/docs/$2/api/$0.html
//    ======================================================
//
//    ## $1
//
var Ronn = require('ronn').Ronn,
  child = require('child_process'),
  fs = require('fs'),
  path = require('path'),
  args = process.argv.slice(2),
  src = args[0], dest = args[1] || 'mannn',
  outdir = path.join(__dirname, 'man', 'man3'),
  apidir = path.join(__dirname, 'doc', 'api'),
  error = function error(err) {
    if(!err) return process.exit(1);

    if (err instanceof Error) console.trace(err);
    else console.error(err);

    return process.exit(1);
  };

// this is the man front header template, generated from the first h2 (##)
// the node docs seems to have on on all .markdown files
var front = [
  "node-$0(3) -- http://nodejs.org/docs/$2/api/$0.html",
  "==========================================================================================================",
  "",
  "## $1"
].join('\n');


if(src) {
  src = path.resolve(src);
  if(path.existsSync(src)) {
    console.log(ronnify(src));
  }

  return;
}


fs.readdirSync(apidir).forEach(function(src) {
  var file = path.join(apidir, src);
  if(!fs.statSync(file).isFile()) return;

  src = 'node-' + src;
  var output = path.join(outdir, src.replace(/\.markdown$/, '.3'));
  fs.writeFileSync(output, ronnify(file));
  console.log(output, ' generated');
});

function handleFront(src) {
  var content = fs.readFileSync(src, 'utf8');
  var page = src.replace(/\..+$/, '').split('/').reverse()[0];
  return content.replace(/##\s?(.+)/, function(w, title) {
    return front
      .replace(/\$0/g, page)
      .replace(/\$1/g, title)
      .replace(/\$2/g, process.version);
  });
}

function ronnify(input) {
  var ronn = new Ronn(handleFront(input));
  return ronn.roff();
}

