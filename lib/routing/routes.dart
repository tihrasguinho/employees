typedef RouteEntry = ({String path, String name});

class Routes {
  const Routes._();

  static const RouteEntry splash = (path: '/', name: 'splash');
  static const RouteEntry employees = (path: '/employees', name: 'employees');
}
