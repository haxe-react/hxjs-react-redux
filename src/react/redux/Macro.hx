package react.redux;

import haxe.macro.Context;
import haxe.macro.Expr;

class Macro {
	public static function connect(e:Expr) {
		var pos = Context.currentPos();
		var cls = Context.getLocalClass().get();
		var fields = Context.getBuildFields();
		var name = cls.module.split('.');
		if(name[name.length - 1] != cls.name) name.push(cls.name);
		
		var mapStateToProps = macro null;
		var mapDispatchToProps = macro null;
		var mergeProps = macro null;
		
		for(field in fields) {
			if(field.access.indexOf(AStatic) == -1) {
				Context.warning('Non-static member found. Maybe forgotten to add `static` keyword?', field.pos);
				continue;
			}
			switch field.name {
				case 'mapStateToProps': mapStateToProps = macro mapStateToProps;
				case 'mapDispatchToProps': mapDispatchToProps = macro mapDispatchToProps;
				case 'mergeProps': mergeProps = macro mergeProps;
			}
		}
		
		fields.push({
			access: [AStatic],
			name: '__init__',
			kind: FFun({
				args: [],
				expr: macro @:pos(pos) untyped __js__('{0} = {1}', $p{name}, react.ReactRedux.connect($mapStateToProps, $mapDispatchToProps, $mergeProps)($e)),
				ret: null,
			}),
			pos: pos,
		});
		return fields;
	}
}