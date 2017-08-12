import tornado.ioloop
import tornado.web

devicePortMap = {
    'S1': 9090,
    'S2': 9091,
    'S3': 9092,
    'S4': 9093,
    'S5': 9094
}


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        pass
    def post(self, *args, **kwargs):
        policy = {}
        tmp = self.request.body.split('|') 
        pattern = tmp[0].split('+')
        
        policy['L3Dst'] = pattern[0]
        policy['L3Src'] = pattern[1]
        policy['L4Dst'] = pattern[3]
        policy['L4Src'] = pattern[4]
        policy['Proto'] = pattern[2]
        policy['Device'] = pattern[5]

        chain = tmp[1].split('+')
        policy['chain'] = chain
        if check_policy(policy) is True:
            execute_policy(policy)

def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
    ])


def check_policy(policy):
    return True

def execute_policy(policy):
    print policy



if __name__ == "__main__":
    app = make_app()
    app.listen(10888)
    tornado.ioloop.IOLoop.current().start()