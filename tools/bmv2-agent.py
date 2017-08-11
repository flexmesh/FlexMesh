import tornado.ioloop
import tornado.web

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        pass
    def post(self, *args, **kwargs):
        print self.request.body

def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
    ])

if __name__ == "__main__":
    app = make_app()
    app.listen(10888)
    tornado.ioloop.IOLoop.current().start()