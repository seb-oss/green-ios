import GdsKit
import SwiftUI

@available(iOS 16, *)
public struct SEBGreenButtonStyleDemo: View {
    @State var iconPosition: IconPosition = .leading
    @State var isDisabled = false
    @State var buttonDimensions = SEBGreenButtonStyle.Dimensions.large
    @State var buttonLayoutBehavior = SEBGreenButtonStyle.LayoutBehavior.fill
    
    @State var isOptionalExpanded = false
    @State var shouldShowWorkInProgress = false
    
    @Environment(\.level) private var level
    
    public init() {}
    
    public var body: some View {
        DemoContainer("Green Buttons") {
            configurationView
        } content: {
            VStack(spacing: 12) {
                // Primary with no icon
                Button("Primary") {
                    print("Hello")
                }
                .buttonStyle(.seb(.primary.dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                .level(.level1)
                
                Divider()
                
                HStack {
                    Button {
                        print("Leading")
                    } label: {
                        Label("Secondary", systemImage: "star")
                    }
                    .buttonStyle(.seb(.primary.dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                    .level(.level1)
                    
                    Button {
                        print("Hello")
                    } label: {
                        Label("Trailing", systemImage: "arrow.right")
                    }
                    .buttonStyle(.seb(.primary.dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior).iconPosition(.trailing)))
                    .level(.level1)
                }
                
                Divider()
                
                // Secondary with Label (icon position controlled by style)
                Button {
                    print("Hello")
                } label: {
                    Label("Secondary", systemImage: "info.circle")
                }
                .buttonStyle(.seb(.secondary.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))

                Divider()
                
                VStack {
                    Button {
                        print("Hello")
                    } label: {
                        Label("Secondary Level 2", systemImage: "info.circle")
                    }
                    .buttonStyle(.seb(.secondary.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Level.level2.colors.neutral02)
                )
                .level(.level2)
                
                Divider()
                
                // Tertiary with Label
                Button {
                    print("Hello")
                } label: {
                    Label("Tertiary", systemImage: "star.fill")
                }
                .buttonStyle(.seb(.tertiary.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                
                Divider()
                
                // Outline with Label
                Button {
                    print("Hello")
                } label: {
                    Label("Outline", systemImage: "arrow.right")
                }
                .buttonStyle(.seb(.outline.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))

                Divider()
                
                // Negative with multiline text and Label
                Button {
                    print("Hello")
                } label: {
                    Label {
                        Text("Negative Multiple Lines Negative Multiple Lines Negative")
                    } icon: {
                        Image(systemName: "exclamationmark.triangle.fill")
                    }
                }
                .buttonStyle(.seb(.negative.iconPosition(iconPosition).dimensions(buttonDimensions).layoutBehavior(buttonLayoutBehavior)))
                
                Divider()
            }
            .disabled(isDisabled)
            
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
                        VStack(spacing: 12) {
                            
                            // Icon-only button using custom Icon view
                            Button {
                                print("Hello")
                            } label: {
                                Icon(systemName: "info.circle")
                            }
                            .buttonStyle(.seb(.primary.dimensions(buttonDimensions).layoutBehavior( .hug)))
                            .accessibilityLabel("Information")
                            
                            Divider()
                            
                            // Custom composition (not using Label)
                            Button {
                                print("Hello")
                            } label: {
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
                            .buttonStyle(.seb(.primary.dimensions(buttonDimensions).layoutBehavior( buttonLayoutBehavior)))
                            
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
    
    private var configurationView: some View {
        VStack {
            HStack {
                Text("Icon position")
                Spacer()
                
                Menu {
                    Button("Leading") { iconPosition = .leading }
                    Button("Trailing") { iconPosition = .trailing }
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
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(level.above.colors.neutral02)
        )
        .dynamicTypeSize(.large)
    }
}


@available(iOS 16, *)
#Preview {
    NavigationStack {
        SEBGreenButtonStyleDemo()
    }
}
