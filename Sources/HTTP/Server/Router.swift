public typealias RequestHandler = (Request) throws -> Response

public class Router: RouterProtocol {
    public struct MethodSet: OptionSet {
        public let rawValue: UInt8

        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }

        public static let get = MethodSet(rawValue: 1 << 0)
        public static let head = MethodSet(rawValue: 1 << 1)
        public static let post = MethodSet(rawValue: 1 << 2)
        public static let put = MethodSet(rawValue: 1 << 3)
        public static let delete = MethodSet(rawValue: 1 << 4)
        public static let options = MethodSet(rawValue: 1 << 5)

        public static let all: MethodSet = [
            .get, .head, .post, .put, .delete, .options
        ]
    }

    struct Route {
        let methods: MethodSet
        let handler: RequestHandler
    }

    private var routeMatcher = RouteMatcher<Route>()

    public var middleware: [Middleware.Type]

    init(middleware: [Middleware.Type] = []) {
        self.middleware = middleware
    }

    public func registerRoute(
        path: String,
        methods: MethodSet,
        middleware: [Middleware.Type],
        handler: @escaping RequestHandler
    ) {
        let middleware = self.middleware + middleware
        let handler = chainMiddleware(middleware, with: handler)
        let route = Route(methods: methods, handler: handler)
        routeMatcher.add(route: path, payload: route)
    }

    public func findHandler(
        path: String,
        methods: MethodSet
    ) -> RequestHandler? {
        let routes = routeMatcher.matches(route: path)
        guard let route = routes.first(where: { route in
            route.methods.contains(methods)
        }) else {
            return nil
        }
        return route.handler
    }
}
