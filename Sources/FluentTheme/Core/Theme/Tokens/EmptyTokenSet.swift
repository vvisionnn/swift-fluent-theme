/// The set of tokens associated with this `EmptyTokenSet`.
public enum EmptyToken: Int, TokenSetKey {
	/// A default token, which only exists because Swift requires at least one value in this enum.
	case none
}

/// An empty `ControlTokenSet` for components that want to use some of the perks
/// of being tokenized, but are not fully at that stage yet.
public class EmptyTokenSet: ControlTokenSet<EmptyToken> {
	init() {
		super.init { _, _ in
			preconditionFailure("Should not fetch values")
		}
	}
}
