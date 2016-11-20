package react.redux;

import haxe.macro.Context;
import haxe.macro.Expr;

class Macro {
	public static function connect(e:Expr) {
		var pos = Context.currentPos();
		var cls = Context.getLocalClass().get();
		var fields = Context.getBuildFields();
		fields.push({
			access: [AStatic],
			name: '__init__',
			kind: FFun({
				args: [],
				expr: macro @:pos(pos) untyped $i{cls.name} = react.ReactRedux.connect(mapStateToProps, mapDispatchToProps)($e),
				ret: null,
			}),
			pos: pos,
		});
		return fields;
	}
}