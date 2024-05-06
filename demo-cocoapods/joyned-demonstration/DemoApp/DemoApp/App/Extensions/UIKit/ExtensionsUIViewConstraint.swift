//
//  ExtensionsUIViewConstraint.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 14/12/2023.
//
import Foundation
import UIKit
///
/// Convenience tuple to handle constraint application
///
internal typealias Constraint = (_ child: UIView, _ parent: UIView) -> NSLayoutConstraint

// Convenience functions to enable simple code based constraints,
//      works with the view anchor keypaths
// ========================================================================== //

// These methods return an inactive constraint of the form thisAnchor = otherAnchor + constant.
internal func          equal<L, Axis>(
    _ to: KeyPath<UIView, L>, constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutAnchor<Axis> {
    return equal(to, to, constant: c)
}
internal func greaterOrEqual<L, Axis>(
    _ to: KeyPath<UIView, L>, constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutAnchor<Axis> {
    return greaterOrEqual(to, to, constant: c)
}
internal func    lessOrEqual<L, Axis>(
    _ to: KeyPath<UIView, L>, constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutAnchor<Axis> {
    return lessOrEqual(to, to, constant: c)
}

// These methods return an inactive constraint of the form thisAnchor = otherAnchor + constant.
internal func          equal<L, Axis>(
    _ from: KeyPath<UIView, L>,
    _ to: KeyPath<UIView, L>,
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: from].constraint(
            equalTo: parent[keyPath: to], constant: c
        )
    }
}
internal func greaterOrEqual<L, Axis>(
    _ from: KeyPath<UIView, L>,
    _ to: KeyPath<UIView, L>,
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: from].constraint(
            greaterThanOrEqualTo: parent[keyPath: to],
            constant: c
        )
    }
}
internal func    lessOrEqual<L, Axis>(
    _ from: KeyPath<UIView, L>,
    _ to: KeyPath<UIView, L>,
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: from].constraint(
            lessThanOrEqualTo: parent[keyPath: to],
            constant: c
        )
    }
}

// ========================================================================== //

// These methods return an inactive constraint of the form thisVariable = constant.
internal func          equalValue<L>(
    _ from: KeyPath<UIView, L>, to constant: CGFloat
) -> Constraint where L: NSLayoutDimension {
    return { view, parent in
        view[keyPath: from].constraint(             equalToConstant: constant)
    }
}
internal func greaterOrEqualValue<L>(
    _ from: KeyPath<UIView, L>, to constant: CGFloat
) -> Constraint where L: NSLayoutDimension {
    return { view, parent in
        view[keyPath: from].constraint(greaterThanOrEqualToConstant: constant)
    }
}
internal func    lessOrEqualValue<L>(
    _ from: KeyPath<UIView, L>, to constant: CGFloat
) -> Constraint where L: NSLayoutDimension {
    return { view, parent in
        view[keyPath: from].constraint(   lessThanOrEqualToConstant: constant)
    }
}

// These methods return an inactive constraint of the form:
//      thisAnchor = otherAnchor * multiplier + constant.
internal func          equalValue<L>(
    _ from: KeyPath<UIView, L>,
    _ to: KeyPath<UIView, L>,
    multiplier m: CGFloat = CGFloat(1.0),
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutDimension {
    return { view, parent in
        view[keyPath: from].constraint(
            equalTo: parent[keyPath: to],
            multiplier: m,
            constant: c
        )
    }
}
internal func greaterOrEqualValue<L>(
    _ from: KeyPath<UIView, L>,
    _ to: KeyPath<UIView, L>,
    multiplier m: CGFloat = CGFloat(1.0),
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutDimension {
    return { view, parent in
        view[keyPath: from].constraint(
            greaterThanOrEqualTo: parent[keyPath: to],
            multiplier: m,
            constant: c
        )
    }
}
internal func    lessOrEqualValue<L>(
    _ from: KeyPath<UIView, L>,
    _ to: KeyPath<UIView, L>,
    multiplier m: CGFloat = CGFloat(1.0),
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutDimension {
    return { view, parent in
        view[keyPath: from].constraint(
            lessThanOrEqualTo: parent[keyPath: to],
            multiplier: m,
            constant: c
        )
    }
}
// ========================================================================== //
// These methods return an inactive constraint of the form:
//      thisAnchor = otherAnchor * multiplier + constant.
internal func          equalValue<L>(
    to: KeyPath<UIView, L>,
    multiplier m: CGFloat = CGFloat(1.0),
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutDimension {
    return          equalValue(to, to, multiplier: m, constant: c)
}
internal func greaterOrEqualValue<L>(
    to: KeyPath<UIView, L>,
    multiplier m: CGFloat = CGFloat(1.0),
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutDimension {
    return greaterOrEqualValue(to, to, multiplier: m, constant: c)
}
internal func    lessOrEqualValue<L>(
    to: KeyPath<UIView, L>,
    multiplier m: CGFloat = CGFloat(1.0),
    constant c: CGFloat = .zero
) -> Constraint where L: NSLayoutDimension {
    return    lessOrEqualValue(to, to, multiplier: m, constant: c)
}
// ========================================================================== //
// MARK: - constraints handling
internal extension UIView
{
    @discardableResult
    func v_addSubview(
        _ other: UIView,
        with constraints: [Constraint] ,
        priority : UILayoutPriority = .required
    ) -> [NSLayoutConstraint] {
        addSubview(other)
        return v_anchor(view: other, with: constraints, priority: priority)
    }

    @discardableResult
    func v_anchor(
        view other: UIView,
        with constraints: [Constraint],
        priority : UILayoutPriority = .required
    ) -> [NSLayoutConstraint] {
        let c = v_constraints(view: other, with: constraints, priority: priority)
        NSLayoutConstraint.activate(c)
        return c
    }

    @discardableResult
    func v_constraints(
        view other: UIView,
        with constraints: [Constraint],
        priority : UILayoutPriority = .defaultHigh
    ) -> [NSLayoutConstraint] {

        return constraints.compactMap {
            v_constraint(view: other, with: $0, priority: priority)
        }
    }
    
    @discardableResult
    func v_constraint(
        view other: UIView,
        with constraint: Constraint,
        priority : UILayoutPriority = .defaultHigh
    ) -> NSLayoutConstraint {

        other.translatesAutoresizingMaskIntoConstraints = false

        let c = constraint(other, self)
        c.priority = priority
        return c
    }

    @discardableResult
    func v_anchor(
        view other: UIView,
        with constraint: Constraint,
        priority : UILayoutPriority = .defaultHigh
    ) -> NSLayoutConstraint {
        let c = v_constraint(view: other, with: constraint, priority: priority)
        NSLayoutConstraint.activate([c])
        return c
    }

    @discardableResult
    func v_constraintSelf(
        with constraint: Constraint,
        priority : UILayoutPriority = .defaultHigh
    ) -> NSLayoutConstraint {
        return v_constraint(view: self, with: constraint, priority: priority)
    }
    @discardableResult
    func v_anchorSelf(
        with constraint: Constraint,
        priority : UILayoutPriority = .defaultHigh
    ) -> NSLayoutConstraint {
        let c = v_constraintSelf(with: constraint, priority: priority)
        NSLayoutConstraint.activate([c])
        return c
    }
}
