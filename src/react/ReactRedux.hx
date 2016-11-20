package react;

import react.ReactComponent;

@:jsRequire('react-redux')
extern class ReactRedux {
	public static function connect(mapStateToProps:Dynamic, mapDispatchToProps:Dynamic):Class<ReactComponent>->Class<ReactComponent>;
}

@:jsRequire('react-redux', 'Provider')
extern class Provider extends ReactComponent {}