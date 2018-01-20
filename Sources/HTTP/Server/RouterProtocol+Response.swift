// Convenience routes

extension RouterProtocol {
    // GET
    @_inlineable
    public func route(
        get path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route(
        get path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        get path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        get path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        get path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        get path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.get],
            middleware: middleware,
            handler: handler)
    }

    // HEAD
    @_inlineable
    public func route(
        head path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route(
        head path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        head path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        head path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        head path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        head path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.head],
            middleware: middleware,
            handler: handler)
    }

    // POST
    @_inlineable
    public func route(
        post path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route(
        post path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        post path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        post path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        post path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        post path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.post],
            middleware: middleware,
            handler: handler)
    }

    // PUT
    @_inlineable
    public func route(
        put path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route(
        put path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        put path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        put path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        put path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        put path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.put],
            middleware: middleware,
            handler: handler)
    }

    // DELETE
    @_inlineable
    public func route(
        delete path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route(
        delete path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        delete path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        delete path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        delete path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        delete path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.delete],
            middleware: middleware,
            handler: handler)
    }

    // OPTIONS
    @_inlineable
    public func route(
        options path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route(
        options path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        options path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        options path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        options path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        options path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.options],
            middleware: middleware,
            handler: handler)
    }

    // ALL
    @_inlineable
    public func route(
        all path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping () throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route(
        all path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        all path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<Model: Decodable>(
        all path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        all path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }

    @_inlineable
    public func route<URLMatch: Decodable, Model: Decodable>(
        all path: String,
        through middleware: [Middleware.Type] = [],
        to handler: @escaping (Request, URLMatch, Model) throws -> Response
    ) {
        route(
            path: path,
            methods: [.all],
            middleware: middleware,
            handler: handler)
    }
}
