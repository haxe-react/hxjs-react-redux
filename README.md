** Deprecated: Please use https://github.com/elsassph/haxe-redux instead **

# React-Redux for Haxe

Helper to use react-redux in Haxe.

## Usage

```haxe
typedef Props = {
	text:String,
	onClick:Void->Void,
}

@:build(react.redux.Macro.connect(Presentation))
class Connected {
	public static function mapStateToProps(s:State):Props {
		return {
			text: s.someValue,
		}
	}
	
	public static function mapDispatchToProps(dispatch:Action->Void):Props {
		return {
			onClick: function() dispatch(SomeAction),
		}
	}
}

private class Presentation extends ReactComponentOfProps<Props> {
	override function render()
		return jsx('<div onClick={props.onClick}>{props.text}</div>');
}

// then, in main()
ReactDOM.render(jsx('<Provider store={store}><Connected /></Provider>'), js.Browser.document.getElementById('app'));
```
