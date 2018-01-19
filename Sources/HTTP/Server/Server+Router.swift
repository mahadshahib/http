extension Server: RouterProtocol {
    public func registerRoute(
        path: String,
        methods: Router.MethodSet,
        middleware: [Middleware.Type],
        handler: @escaping RequestHandler
    ) {
        router.registerRoute(
            path: path,
            methods: methods,
            middleware: middleware,
            handler: handler)
    }

    public func findHandler(
        path: String,
        methods: Router.MethodSet
    ) -> RequestHandler? {
        return router.findHandler(path: path, methods: methods)
    }
}
