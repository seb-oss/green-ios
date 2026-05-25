import GdsKit
import SwiftUI

public struct SEBGreenButtonStyleDemo: View {
    @State private var iconPosition: IconPosition = .leading
    @State private var shouldShowIcon = true
    @State private var isDisabled = false
    @State private var buttonDimensions = GreenButtonStyle.Dimensions.large
    @State private var buttonLayoutBehavior = GreenButtonStyle.LayoutBehavior.fill
    
    @State private var isOptionalExpanded = false
    @State private var shouldShowWorkInProgress = false
    
    public init() {}
    
    public var body: some View {
        DemoContainer("Green Buttons") {
            configurationView
        } content: {
            VStack(spacing: .gds(.spaceXl)) {
                // Primary with no icon
                Button("Primary") { }
                .buttonStyle(.gds(.primary.dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                
                Divider()
                
                HStack {
                    Button { } label: {
                        if shouldShowIcon {
                            Label("Leading", systemImage: "star")
                        } else {
                            Text("Leading")
                        }
                    }
                    .buttonStyle(.gds(.primary.dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                    
                    Button { } label: {
                        if shouldShowIcon {
                            Label("Trailing", systemImage: "arrow.right")
                        } else {
                            Text("Trailing")
                        }
                    }
                    .buttonStyle(.gds(.primary.dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior).iconPosition(.trailing)))
                }
                
                Divider()
                
                // Secondary with Label (icon position controlled by style)
                Button { } label: {
                    if shouldShowIcon {
                        Label("Secondary", systemImage: "info.circle")
                    } else {
                        Text("Secondary")
                    }
                }
                .buttonStyle(.gds(.secondary.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))

                Divider()
                
                VStack {
                    Button { } label: {
                        if shouldShowIcon {
                            Label("Secondary on White", systemImage: "info.circle")
                        } else {
                            Text("Secondary on White")
                        }
                    }
                    .buttonStyle(.gds(.secondary.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                    .padding()
                }
                .surface(.neutral01)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Divider()
                
                // Tertiary with Label
                Button { } label: {
                    if shouldShowIcon {
                        Label("Tertiary", systemImage: "star.fill")
                    } else {
                        Text("Tertiary")
                    }
                }
                .buttonStyle(.gds(.tertiary.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                
                Divider()
                
                // Outline with Label
                Button { } label: {
                    if shouldShowIcon {
                        Label("Outline", systemImage: "arrow.right")
                    } else {
                        Text("Outline")
                    }
                }
                .buttonStyle(.gds(.outline.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))

                Divider()
                
                // Negative with multiline text and Label
                Button { } label: {
                    Label {
                        Text("Negative Multiple Lines Negative Multiple Lines Negative")
                    } icon: {
                        if shouldShowIcon {
                            Image(systemName: "exclamationmark.triangle.fill")
                        }
                    }
                }
                .buttonStyle(.gds(.negative.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                
                Divider()
                
                // Notice with Label and icon
                Button { } label: {
                    Label {
                        Text("Notice button")
                    } icon: {
                        if shouldShowIcon {
                            Image(systemName: "info.circle")
                        }
                    }
                }
                .buttonStyle(.gds(.notice.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))

                Divider()

                // Tonal with Label and icon
                Button { } label: {
                    Label {
                        Text("Tonal button")
                    } icon: {
                        if shouldShowIcon {
                            Image(systemName: "circle.hexagongrid")
                        }
                    }
                }
                .buttonStyle(.gds(.tonal.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))

                Divider()
            }
            .disabled(isDisabled)
            
            VStack(spacing: .gds(.spaceXl)) {
                let workInProgress = "Work in Progress"
                
                Button(action: {
                    shouldShowWorkInProgress.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "wrench.and.screwdriver")
                        Text(workInProgress)
                        Spacer()
                    }
                })
                .sheet(isPresented: $shouldShowWorkInProgress) {
                    NavigationStack {
                        ScrollView {
                            VStack(spacing: .gds(.spaceS)) {
                                
                                // Icon-only button using custom Icon view
                                Button { } label: {
                                    Icon(systemName: "ellipsis")
                                }
                                .buttonStyle(.gds(.primary(shape: .circle).dimensions(buttonDimensions)))
                                .accessibilityLabel("Information")
                                
                                Divider()
                                
                                // Custom composition (not using Label)
                                Button { } label: {
                                    HStack(spacing: 8) {
                                        Icon(systemName: "heart.fill")
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Custom")
                                                .font(.headline)
                                            Text("Complex layout")
                                                .font(.caption)
                                        }
                                    }
                                }
                                .buttonStyle(.gds(.primary.dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                        .navigationTitle(workInProgress)
                    }
                }
            }
        }
    }
    
    private var configurationView: some View {
        VStack(spacing: .gds(.spaceL)) {
            DemoSection("Configuration") {
                HStack {
                    Text("Icon position")
                    Spacer()
                    
                    Menu {
                        Button("Leading") { shouldShowIcon = true; iconPosition = .leading }
                        Button("Trailing") { shouldShowIcon = true; iconPosition = .trailing }
                        Button("No icon") { shouldShowIcon = false }
                    } label: {
                        Text(iconPosition == .leading ? "Leading" : "Trailing")
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                }

                Divider()
                
                HStack {
                    Text("Button size")
                    Spacer()
                    
                    Menu {
                        Button("Small") { buttonDimensions = .small }
                        Button("Medium") { buttonDimensions = .medium }
                        Button("Large") { buttonDimensions = .large }
                        Button("XLarge") { buttonDimensions = .xlarge }
                    } label: {
                        Text("\(buttonDimensions.description)")
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                }
                
                Divider()
                
                HStack {
                    Text("Layout behavior")
                    Spacer()
                    
                    Menu {
                        Button("Fill") { buttonLayoutBehavior = .fill }
                        Button("Hug") { buttonLayoutBehavior = .hug }
                        Button("Fixed (200)") { buttonLayoutBehavior = .fixed(200) }
                        Button("Flexible (120-300)") { buttonLayoutBehavior = .flexible(min: 120, max: 300) }
                    } label: {
                        Text(buttonLayoutBehavior.description)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                }
                
                Divider()
                
                DisclosureGroup("Optional", isExpanded: $isOptionalExpanded) {
                    Toggle("Disabled state", isOn: $isDisabled)
                        .padding(.trailing)
                }
                .font(.body)
                .foregroundStyle(Color.primary)
            }
        }
        .padding(.gds(.spaceM))
        .dynamicTypeSize(.large)
    }
}

#Preview {
    NavigationStack {
        SEBGreenButtonStyleDemo()
    }
}
