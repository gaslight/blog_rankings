/* Exports an object that defines
 *  all of the paths & globs that the project
 *  is concerned with.
 *
 * The "configure" task will require this file and
 *  then re-initialize the grunt config such that
 *  directives like <config:files.js.app> will work
 *  regardless of the point you're at in the build
 *  lifecycle.
 *
 * You can find the parent object in: node_modules/lineman/config/files.coffee
 */

module.exports = require('lineman').config.extend('files', {
  js: {
    jquery: "vendor/js/jquery.min.js",
  },
  css: {
    vendor: ["vendor/css/**/*.css","vendor/stylesheets/screen.css"],
  },
  webfonts: {
    root: "fonts",
  },
});
