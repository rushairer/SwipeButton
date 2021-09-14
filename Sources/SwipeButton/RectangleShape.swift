import SwiftUI

struct RectangleShape: Shape {
    var offsetX: CGFloat
    var animatableData: CGFloat {
        get { offsetX }
        set { offsetX = newValue }
    }
    var position: Position = .right
    
    enum Position {
        case left
        case right
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let height = rect.height
        let width = rect.width
        let paddingValue: CGFloat = 10

        if position == .left {
            path.move(to: CGPoint(x: 0, y: 0))
            if offsetX > paddingValue {
                let toPoint1 = CGPoint(x: offsetX - paddingValue, y:0)
               
                let toPoint2 = CGPoint(x: offsetX - paddingValue, y: height)
                
                let toPoint3 = CGPoint(x: 0, y: height)
                path.addLine(to: toPoint1)
                path.addLine(to: toPoint2)
                path.addLine(to: toPoint3)
            }
            path.addLine(to: CGPoint(x: 0, y: 0))
        } else {
            path.move(to: CGPoint(x: width, y: 0))
            if offsetX < -paddingValue {
                let toPoint1 = CGPoint(x: width + offsetX + paddingValue, y:0)
               
                let toPoint2 = CGPoint(x: width + offsetX + paddingValue, y: height)
                
                let toPoint3 = CGPoint(x: width, y: height)
                path.addLine(to: toPoint1)
                path.addLine(to: toPoint2)
                path.addLine(to: toPoint3)
            }
            path.addLine(to: CGPoint(x: width, y: 0))
        }
        
        return path
    }
}


struct RectangleShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RectangleShape(offsetX: 40, position: .left)
                .fill(Color.red)
                .frame(height: 60)
                .previewLayout(.sizeThatFits)
            
            RectangleShape(offsetX: 120, position: .left)
                .fill(Color.red)
                .frame(height: 60)
                .previewLayout(.sizeThatFits)

            RectangleShape(offsetX: 120, position: .left)
                .fill(Color.red)
                .frame(height: 120)
                .previewLayout(.sizeThatFits)
            
            RectangleShape(offsetX: 120, position: .left)
                .fill(Color.red)
                .frame(height: 260)
                .previewLayout(.sizeThatFits)

            
            RectangleShape(offsetX: -120, position: .right)
                .fill(Color.blue)
                .frame(height: 160)
                .previewLayout(.sizeThatFits)

        }
    }
}
