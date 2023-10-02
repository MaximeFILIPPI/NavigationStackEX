//
//  NavigationStackEX.swift
//  Examples
//
//  Created by MaxBook Pro on 1/10/23.
//

import Foundation
import SwiftUI


public struct NavigationStackEX<Content: View, V: View>: View {
    
    @StateObject var navigator: Navigator = Navigator()
    
    @Binding var destinations: [String: V]
    //@Binding var destinationsLazy: [String: () -> V]

    let content: () -> Content

    public var body: some View {
        
        NavigationStack(path: $navigator.path) {
            content()
                .navigationDestination(for: String.self) { destination in
                    
                    //let _ = print("NavigationStackEX :: navigation destination view -> \(destination)")
                    
                    if let view = destinations[destination]
                    {
                        //view()
                        view
                    }
                    
                }
                .sheet(item: $navigator.sheet) { destination in
                    
                    //let _ = print("NavigationStackEX :: sheet destination view -> \(destination)")
                    
                    if let view = destinations[destination]
                    {
                        //view()
                        view
                    }
                    
                }
            
        }
        .environmentObject(navigator)
    }
    
}

@MainActor
public class Navigator: ObservableObject {
    
    public var urlHandler: ((URL) -> OpenURLAction.Result)?
    
    @Published public var path: [String] = []
    
    @Published public var sheet: String?
    
    @Published public var dataForDestinations: [String: Any] = [:] // Store data for destinations

    public init() {}

    public func push(to destination: String, with data: Any? = nil) {
        path.append(destination)
        dataForDestinations[destination] = data // Store data for the destination
    }
    
    public func present(_ destination: String, with data: Any? = nil) {
        sheet = destination
        dataForDestinations[destination] = data
    }

    public func data(for destination: String) -> Any {
        return dataForDestinations[destination] ?? EmptyView() // Return data or an empty view
    }
    
    public func pop(to view: String? = nil)
    {
        if view != nil
        {
            if let index = path.lastIndex(of: view!)
            {
                if (index + 1 < path.count)
                {
                    path.removeSubrange((index+1)...(path.count - 1))
                }
                else
                {
                    path.removeSubrange(index...(path.count - 1))
                }
            }
            else
            {
                path.removeLast()
            }
        }
        else
        {
            path.removeLast()
        }
        
    }
    
    public func popToRoot()
    {
        path.removeAll()
    }
    
}


extension View {
    var nav: AnyView {
        return AnyView(self)
    }
}

extension String: Identifiable {
    public var id: String {
        self
    }
}


