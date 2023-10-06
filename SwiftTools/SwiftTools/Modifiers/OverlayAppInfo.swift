//
//  OverlayAppInfo.swift
//  Scapegoat
//
//  2023-10-03 Created by Blake Davis.
//

import Foundation
import SwiftUI


// 
//
//
// Example usage:
//
//     ContentView()
//         .overlayAppInfo(include: AnyView(
//                                      VStack {
//                                          Image(systemName: "checkmark.circle")
//                                          Text("Additional stuff")
//                                      }
//                                  ))
//
//


// MARK: OverlayAppInfo ViewModifier
struct OverlayAppInfo: ViewModifier {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @ScaledMetric private var padding: CGFloat = 5
    
    private let additionalInfo: AnyView?
    
    
    public init(include additionalInfo: AnyView? = nil) {
        self.additionalInfo = additionalInfo
    }
    
    
    
    func body(content: Content) -> some View {
        
        let cornerRadius = UIScreen.main.value(forKey: ["Radius", "Corner", "display", "_"].reversed().joined()) as? CGFloat
        let deviceType = UIDevice.current.userInterfaceIdiom
    
        ZStack {
       
            content
            
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                
                    Group {
                                let appInfo = AppInfo()

                        Text("\(horizontalSizeClass == .compact ? "" : appInfo.appName) v\(appInfo.version) (\(appInfo.build))")
                            .foregroundColor(.gray)
                            .padding(.leading, cornerRadius!)
                            .font(.caption2)

                        additionalInfo
                    }
                    .foregroundColor(.gray)
                    .font(.caption2)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
// DEBUGGING *******************************************************************
//            .background(Color(red: 1, green: 0, blue: 1, opacity: 0.333))
// *****************************************************************************
            .cornerRadius(cornerRadius! - padding/2, corners: [.bottomLeft, .bottomRight])
            .padding([.bottom, .horizontal], padding)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}





// =============================================================================
// MARK: App Information
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

public struct AppInfo {

    public var appName:          String { return readFromInfoPlist(withKey: "CFBundleName")               ?? "(unknown app name)"          }
    public var build:            String { return readFromInfoPlist(withKey: "CFBundleVersion")            ?? "(unknown build number)"      }
    public var bundleIdentifier: String { return readFromInfoPlist(withKey: "CFBundleIdentifier")         ?? "(unknown bundle identifier)" }
    public var copyrightNotice:  String { return readFromInfoPlist(withKey: "NSHumanReadableCopyright")   ?? "(unknown copyright notice)"  }
    public var minimumOSVersion: String { return readFromInfoPlist(withKey: "MinimumOSVersion")           ?? "(unknown minimum OSVersion)" }
    public var version:          String { return readFromInfoPlist(withKey: "CFBundleShortVersionString") ?? "(unknown app version)"       }
   
    private let infoPlistDictionary = Bundle.main.infoDictionary
    
    
    
    public init() { }
    

    private func readFromInfoPlist(withKey key: String) -> String? {
        return infoPlistDictionary?[key] as? String
    }
}





// =============================================================================
// MARK: Extensions
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}




// MARK: overlayAppInfo View extension
extension View {
    
    public func overlayAppInfo(include: AnyView? = nil) -> some View {
        modifier(OverlayAppInfo(include: include))
    }
}

