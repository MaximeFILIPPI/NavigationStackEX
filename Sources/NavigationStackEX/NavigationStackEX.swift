//
//  NavigationStackEX.swift
//  Examples
//
//  Created by MaxBook Pro on 1/10/23.
//

import SwiftUI

public struct NavigationStackEX<Content: View>: View {
    
    private let TAG: String = "NavigationStackEX ::"
    
    @StateObject var navigator: Navigator = Navigator()
    
    @Binding var destinations: [String: AnyView]

    let content: () -> Content

    public var body: some View {
        NavigationStack(path: $navigator.path) {
            content()
                .navigationDestination(for: String.self) { destination in
                    if let view = destinations[destination] {
                        view
                    } else if let dynamicView = navigator.dynamicDestinations[destination] {
                        dynamicView
                    }
                }
                .sheet(item: $navigator.sheet) { destination in
                    if let view = destinations[destination] {
                        view
                    } else if let dynamicView = navigator.dynamicSheets[destination] {
                        dynamicView
                    }
                }
                .fullScreenCover(item: $navigator.cover) { destination in
                    if let view = destinations[destination] {
                        view
                    } else if let dynamicView = navigator.dynamicCovers[destination] {
                        dynamicView
                    }
                }
        }
        .environmentObject(navigator)
    }
}


@MainActor
public class Navigator: ObservableObject {
    
    private let TAG: String = "Navigator ::"
    
    public var urlHandler: ((URL) -> OpenURLAction.Result)?
    
    @Published public var path: [String] = []
    
    @Published public var sheet: String?
    
    @Published public var cover: String?
    
    @Published public var dataForDestinations: [String: Any] = [:] // Store data for destinations

    @Published public var dynamicDestinations: [String: AnyView] = [:] // Store dynamically created views
    
    @Published public var dynamicSheets: [String: AnyView] = [:] // Store dynamically created views for sheets
    
    @Published public var dynamicCovers: [String: AnyView] = [:] // Store dynamically created full screen covers

    public init() {}
    
    public func push(to destination: String, with data: Any? = nil) {
        if !ProcessInfo().isPreview {
            path.append(destination)
            dataForDestinations[destination] = data
        } else {
            print(TAG, "push() -> cannot be used in Preview")
        }
    }
    
    public func push<V: View>(to view: V, identifier: String? = nil) {
        if !ProcessInfo().isPreview {
            let viewIdentifier = "\(identifier ?? "dynamic_\(dynamicDestinations.count)")"
            dynamicDestinations[viewIdentifier] = view.any
            path.append(viewIdentifier)
        } else {
            print(TAG, "push() -> cannot be used in Preview")
        }
    }
    
    public func present(_ destination: String, with data: Any? = nil) {
        if !ProcessInfo().isPreview {
            sheet = destination
            dataForDestinations[destination] = data
        } else {
            print(TAG, "present() -> cannot be used in Preview")
        }
    }
    
    public func present<V: View>(_ view: V, identifier: String? = nil) {
        if !ProcessInfo().isPreview {
            let viewIdentifier = "\(identifier ?? "dynamicSheet_\(dynamicSheets.count)")"
            dynamicSheets[viewIdentifier] = view.any
            sheet = viewIdentifier
        } else {
            print(TAG, "present() -> cannot be used in Preview")
        }
    }
    
    public func presentFullScreen(_ destination: String, with data: Any? = nil) {
        if !ProcessInfo().isPreview {
            cover = destination
            dataForDestinations[destination] = data
        } else {
            print(TAG, "presentFullScreen() -> cannot be used in Preview")
        }
    }
    
    public func presentFullScreen<V: View>(_ view: V, identifier: String? = nil) {
        if !ProcessInfo().isPreview {
            let viewIdentifier = "\(identifier ?? "dynamicCover_\(dynamicCovers.count)")"
            dynamicCovers[viewIdentifier] = view.any
            cover = viewIdentifier
        } else {
            print(TAG, "presentFullScreen() -> cannot be used in Preview")
        }
    }

    public func data(for destination: String) -> Any? {
        return dataForDestinations[destination]
    }
    
    public func pop(to view: String? = nil) {
        if !ProcessInfo().isPreview {
            if let view = view, let index = path.lastIndex(of: view) {
                if (index + 1 < path.count) {
                    path.removeSubrange((index+1)...(path.count - 1))
                } else {
                    path.removeSubrange(index...(path.count - 1))
                }
            } else {
                path.removeLast()
            }
        } else {
            print(TAG, "pop() -> cannot be used in Preview")
        }
    }
    
    public func popToRoot() {
        if !ProcessInfo().isPreview {
            path.removeAll()
        } else {
            print(TAG, "popToRoot() -> cannot be used in Preview")
        }
    }
    
    public func dismiss() {
        if !ProcessInfo().isPreview {
            if sheet != nil {
                sheet = nil
            }
            if cover != nil {
                cover = nil
            }
        } else {
            print(TAG, "dismiss() -> cannot be used in Preview")
        }
    }
}

struct NavigationStackEx_Notif {
    static let DISMISS: String = "path.removeLast()"
}

struct CustomNavigationBackButtonModifier<CustomBackView: View>: ViewModifier {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    let backButtonView: CustomBackView
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button(role: .none) {

                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        
                        backButtonView
                        
                    }

                }
                
            }
        
    }
    
}



struct CustomNavigationLeftItemModifier<CustomLeftView: View>: ViewModifier {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    let leftCustomView: CustomLeftView
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    leftCustomView

                }
                
            }
    }
    
}



struct CustomNavigationRightItemModifier<CustomRightView: View>: ViewModifier {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    let rightCustomView: CustomRightView
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    rightCustomView

                }
                
            }
        
    }
}

extension ProcessInfo
{
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

extension View {
    
    var any: AnyView {
        return AnyView(self)
    }
    
    func navigationBackButtonItem<CustomBackView: View>(_ customView: CustomBackView) -> some View {
        self.modifier(CustomNavigationBackButtonModifier(backButtonView: customView))
    }
    
    func navigationLeftViewItem<CustomBackView: View>(_ customView: CustomBackView) -> some View {
        self.modifier(CustomNavigationLeftItemModifier(leftCustomView: customView))
    }
    
    func navigationRightViewItem<CustomRightView: View>(_ customView: CustomRightView) -> some View {
        self.modifier(CustomNavigationRightItemModifier(rightCustomView: customView))
    }
    
}



extension String: Identifiable {
    public var id: String {
        self
    }
}
