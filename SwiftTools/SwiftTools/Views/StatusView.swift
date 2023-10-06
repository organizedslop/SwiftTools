//
//  StatusView.swift
//  SwiftTools
//
//  2023-09-21 Created by Blake Davis.
//

import SwiftUI





public struct DynamicStack<Content: View>: View {
    
    var orientation:         Axis.Set
    
    var horizontalAlignment: HorizontalAlignment
    var verticalAlignment:   VerticalAlignment
    
    var horizontalSpacing:   CGFloat?
    var verticalSpacing:     CGFloat?
    
    var isShowingDividers:   Bool
    
    var content:             () -> Content
    
    
    
    
    
    public init(_ orientation:        Axis.Set,
                horizontalAlignment:  HorizontalAlignment = .center,
                verticalAlignment:    VerticalAlignment   = .center,
                spacing:              CGFloat?            = nil,
                isShowingDividers:    Bool                = false,
                @ViewBuilder content: @escaping () -> Content) {
         
        self.orientation         = orientation
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment   = verticalAlignment
        self.horizontalSpacing   = spacing
        self.verticalSpacing     = spacing
        self.isShowingDividers   = isShowingDividers
        self.content             = content
    }
    
    
    
    public init(_ orientation:        Axis.Set,
                horizontalAlignment:  HorizontalAlignment = .center,
                verticalAlignment:    VerticalAlignment   = .center,
                horizontalSpacing:    CGFloat?            = nil,
                verticalSpacing:      CGFloat?            = nil,
                isShowingDividers:    Bool                = false,
                @ViewBuilder content: @escaping () -> Content) {
        
        self.orientation         = orientation
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment   = verticalAlignment
        self.horizontalSpacing   = horizontalSpacing
        self.verticalSpacing     = verticalSpacing
        self.isShowingDividers   = isShowingDividers
        self.content             = content
    
    }
    
    
    
    
    
    public var body: some View {
    
        switch orientation {
        
            case .horizontal:
                HStack(alignment: verticalAlignment,
                       spacing:   horizontalSpacing,
                       content:   content)
                
                
            default:
                VStack(alignment: horizontalAlignment,
                       spacing:   verticalSpacing,
                       content:   content)
        }
    }
}





public struct StatusView: View {
    
    private let titleKey:    LocalizedStringKey
    private let titleColor:  Color
    private let status:      StatusIcon
    private let iconColor:   Color
    private let orientation: Axis.Set
    
    
    
    
    
    public init(_ titleKey:  LocalizedStringKey,
                titleColor:  Color?      = nil,
                status:      StatusIcon,
                iconColor:   Color?      = nil,
                orientation: Axis.Set    = .vertical) {
                
        self.titleKey    = titleKey
        self.titleColor  = titleColor ?? .gray
        self.status      = status
        self.iconColor   = iconColor ?? { switch status { case .failure: return Color.red
                                                          case .success: return Color.green
                                                          default:       return Color.gray  } }()
        self.orientation = orientation
    }
    
    
    
    
    
    public var body: some View {
    
        DynamicStack(orientation, horizontalSpacing: 10, verticalSpacing: 5) {
        
            switch status {
                case .inProgress:
                    ProgressView().frame(height: 14)
                default:
                    Image(systemName: status.rawValue).foregroundColor(iconColor).font(.title3).frame(height: 14)
            }
            
            Text(titleKey)
                .foregroundColor(titleColor)
                .lineLimit(1)
                .allowsTightening(true)
                .fixedSize(horizontal: true, vertical: false)
        }
    }
    
    
    
    
    
    public enum StatusIcon: String {
        case failure     = "xmark.circle",
             inProgress  = "timer.circle",
             none        = "questionmark.circle",
             off         = "circle.circle",
             on          = "power.circle",
             success     = "checkmark.circle"
    }
}





// =============================================================================
// MARK: Previews
// -----------------------------------------------------------------------------

struct StatusView_Previews: PreviewProvider {
   
    static var previews: some View {
        
        VStack(spacing: 20) {
        
            HStack {
                StatusView("Success", status: .success, orientation: .vertical).padding()
                StatusView("In progress", status: .inProgress, orientation: .vertical).padding()
                StatusView("Failure", status: .failure, orientation: .vertical).padding()
            }
            
            HStack {
                StatusView("On", status: .on, orientation: .vertical).padding()
                StatusView("Off", status: .off, orientation: .vertical).padding()
                StatusView("None", status: .none, orientation: .vertical).padding()
            }
            
            VStack(alignment: .leading) {
                StatusView("Success", status: .success, orientation: .horizontal)
                StatusView("In progress", status: .inProgress, orientation: .horizontal)
                StatusView("Failure", status: .failure, orientation: .horizontal)
                StatusView("On", status: .on, orientation: .horizontal)
                StatusView("Off", status: .off, orientation: .horizontal)
                StatusView("None", status: .none, orientation: .horizontal)

            }
        }
    }
}
