import SwiftUI

/// A button that dismisses or closes the current view, placed in a navigation toolbar.
///
/// `NavigationCloseButton` must be used inside a `NavigationStack` to be visible,
/// since it renders as a toolbar item.
///
/// On iOS 26 and later, the system-native close button role is used. On earlier
/// versions, an `xmark.circle.fill` symbol is shown instead.
///
/// Prefer the ``navigationCloseButton(placement:action:)`` modifier for convenient placement.
///
/// ```swift
/// NavigationStack {
///     MyView()
///         .toolbar {
///             ToolbarItem(placement: .topBarTrailing) {
///                 NavigationCloseButton { dismiss() }
///             }
///         }
/// }
/// ```
public struct NavigationCloseButton: View {
    private let action: () -> Void

    public init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    @available(iOS, deprecated: 17, message: "Call `.surfaceAware directly`")
    private var backgroundStyle: some ShapeStyle {
        if #available(iOS 17, *) {
            return .surfaceAware
        } else {
            return .clear
        }
    }

    public var body: some View {
        if #available(iOS 26, *) {
            Button(role: .close, action: action)
                .tint(.gds(.contentNeutral02))
        } else {
            Button(systemName: "xmark.circle.fill", action: action)
                .foregroundStyle(
                    .gds(.contentNeutral02),
                    backgroundStyle
                )
                .font(.system(size: 24))
                .accessibilityLabel(
                    String(localized: "GreeniOS.Accessibility.Close", bundle: .module)
                )
        }
    }
}

extension View {
    /// Adds a close button to the view's navigation toolbar.
    ///
    /// The view must be inside a `NavigationStack` for the button to be visible.
    ///
    /// ```swift
    /// NavigationStack {
    ///     MyView()
    ///         .navigationCloseButton { dismiss() }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - placement: The toolbar placement for the button. Defaults to `.topBarTrailing`.
    ///   - action: The closure to execute when the button is tapped.
    public func navigationCloseButton(
        placement: ToolbarItemPlacement = .topBarTrailing,
        action: @escaping () -> Void
    ) -> some View {
        toolbar {
            ToolbarItem(placement: placement) {
                NavigationCloseButton(action)
            }
        }
    }
}

@available(iOS 16)
#Preview {
    NavigationStack {
        Text("Hello World")
            .navigationCloseButton {}
            .navigationTitle("Title")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .surface(.neutral02)
    }
}
