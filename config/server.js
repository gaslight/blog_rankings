/* Define custom server-side HTTP routes for lineman's development server
 *   These might be as simple as stubbing a little JSON to
 *   facilitate development of code that interacts with an HTTP service
 *   (presumably, mirroring one that will be reachable in a live environment).
 *
 * It's important to remember that any custom endpoints defined here
 *   will only be available in development, as lineman only builds
 *   static assets, it can't run server-side code.
 *
 * This file can be very useful for rapid prototyping or even organically
 *   defining a spec based on the needs of the client code that emerge.
 *
 */

module.exports = {
  drawRoutes: function(app) {
    app.get('/posts', function(req, res){
      res.json(
        [{'url':'/post/51721063999/chris-glass-of-wire-twine-joined-us-to-talk','author':{'name':'mitchlloyd'}},
         {'url':'/post/44267174375/gaslight-podcast-12-benefit-corporations','author':{'name':'mitchlloyd'}},
         {'url':'/post/36883746175/using-local-libraries-with-cocoapods','author':{'name':'cdmwebs'}},
         {'url':'/post/24538291598/backbone-js-views-done-the-right-way','author':{'name':'mysterycoder'}},
         {'url':'/post/33428085451/easier-backbone-form-views-with-backtastic','author':{'name':'mysterycoder'}},
         ]
      );
    });
  }
};
