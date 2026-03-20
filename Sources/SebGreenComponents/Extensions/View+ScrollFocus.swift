import SwiftUI

extension View {
    /// Marks a view as a focusable scroll target, so it can be scrolled into view
    /// automatically when it receives focus.
    ///
    /// Apply this modifier to each focusable field inside a `ScrollViewReader`.
    /// Then attach a single `.onChange(of:)` to the container that calls
    /// `proxy.scrollTo(_:anchor:)` — this keeps the scroll logic in one place
    /// rather than duplicating it on every field.
    ///
    /// ## Setup
    ///
    /// **1. Define a `Hashable` enum for your fields:**
    /// ```swift
    /// enum Field: Hashable {
    ///     case username, password, email
    /// }
    /// ```
    ///
    /// **2. Declare a `@FocusState` in your view:**
    /// ```swift
    /// @FocusState private var focusedField: Field?
    /// ```
    ///
    /// **3. Wrap your content in a `ScrollViewReader` and apply the modifier per field:**
    /// ```swift
    /// ScrollViewReader { proxy in
    ///     VStack {
    ///         InputField("Username", text: $username)
    ///             .scrollFocusField(focusedField: $focusedField, equals: .username)
    ///
    ///         InputField("Password", text: $password)
    ///             .scrollFocusField(focusedField: $focusedField, equals: .password)
    ///     }
    ///     .onChange(of: focusedField) { _, field in
    ///         withAnimation {
    ///             proxy.scrollTo(field, anchor: .center)
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - focusedField: A binding to the `@FocusState` tracking the currently focused field.
    ///   - field: The value this view represents in the focus state enum.
    func scrollFocusField<Field: Hashable>(
        focusedField: FocusState<Field?>.Binding,
        equals field: Field
    ) -> some View {
        self
            .focused(focusedField, equals: field)
            .id(field)
    }

    /// Marks a view as a focusable scroll target using a `Bool` focus binding,
    /// so it can be scrolled into view when it receives focus.
    ///
    /// Use this overload when you have a single focusable field and don't need
    /// a focus enum. The `id` parameter is used by `ScrollViewReader` to locate
    /// and scroll to the view.
    ///
    /// ```swift
    /// @FocusState private var isFocused: Bool
    ///
    /// ScrollViewReader { proxy in
    ///     InputField("Email", text: $email)
    ///         .scrollFocusField(focusedField: $isFocused, id: "email")
    ///
    ///     .onChange(of: isFocused) { _, focused in
    ///         if focused {
    ///             withAnimation { proxy.scrollTo("email", anchor: .center) }
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - focusedField: A binding to the `Bool` `@FocusState` for this field.
    ///   - id: A hashable identifier used to scroll to this view via `ScrollViewReader`.
    func scrollFocusField(
        focusedField: FocusState<Bool>.Binding,
        id: some Hashable
    ) -> some View {
        self
            .focused(focusedField)
            .id(id)
    }
}
