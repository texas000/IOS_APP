//
//  Explore_view.swift
//  test
//
//  Created by JIN KIM on 12/7/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation
import SDWebImageSwiftUI

struct Explore_view: View {
    
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var name = ""
    @State var show = false
    @ObservedObject var RoomData=letMeSee()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            //YOU CAN CLICK THE MAP
            VStack {
                NavigationLink(destination: MapView(manager: $manager, alert: $alert)){
                MapView(manager: $manager, alert: $alert)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 250)
                }
            }
            Text("Find More").fontWeight(.heavy).font(.largeTitle).padding(.top,15)
            
            //HEADER1
            ForEach(RoomData.data) {i in
                VStack(alignment: .leading){
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Image(i.pic).resizable().aspectRatio(contentMode: .fit)
                        .overlay(
                            Text("$"+i.price)
                            .foregroundColor(.white)
                                .font(.caption)
                                .background(Color.black)
                                .opacity(0.3)
                            ,alignment: .bottomTrailing)
                    }.buttonStyle(PlainButtonStyle())
                    
                    HStack(spacing: 5){
                        VStack(alignment: .leading){
                            Text(i.type).fontWeight(.heavy)
                            HStack{
                                Image(systemName: "location.circle")
                                Text(i.location)
                            }
                        }
                        
                        Spacer()
                    
                        Image(i.prof)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            .aspectRatio(contentMode: .fit)
                        Text(i.id)
                            .fontWeight(.heavy)
                    }.padding()
                }
            }
        }.sheet(isPresented: $show) {
            Detail()
        }
    }
}

struct Explore_view_Previews: PreviewProvider {
    static var previews: some View {
        Explore_view()
    }
}

struct Detail : View {
    
    @ObservedObject var RoomData=letMeSee()
    
    var body: some View{
        VStack{
            Image("rm1").resizable().frame(width: UIScreen.main.bounds.width, height: 500).aspectRatio(1.35, contentMode: .fill).offset(y: -200).padding(.bottom, -200)
            GeometryReader{geo in
                VStack{
                    Detail_top()
                }
            }.background(Color.white) //CANNOT DELETE BC THE SHAPE
            .clipShape(Rounded())
            .padding(.top, -70)
        }
    }
}

struct Detail_top : View{
    var body: some View{
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("ROOM1").fontWeight(.heavy).font(.largeTitle)
                    Text("로스엔젤레스").fontWeight(.heavy).font(.largeTitle)
                }
                Spacer()
                Text("$299").foregroundColor(Color.gray).font(.largeTitle)
            }
            HStack {
                Image(systemName: "heart")
                Text("HELLO WORLD").foregroundColor(.blue)
                Spacer()
                Image(systemName: "location.circle")
                Text("LA, CA").foregroundColor(.blue)
            }
            
            Text("Description").fontWeight(.heavy)
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.").foregroundColor(.gray)

            HStack (spacing: 8) {
                Button(action: {
                    
                }) {
                    HStack (spacing: 6){
                        Text("Book your room")
                        Image(systemName: "heart")
                    }.foregroundColor(.white)
                    .padding()
                }.background(Color.red)
                .cornerRadius(8)
            }.padding(.top, 15)
        }.padding()
        
    }
}

struct Rounded : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width:40, height: 40))
        return Path(path.cgPath)
    }
}
    
struct MapView : UIViewRepresentable {
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    let map = MKMapView()
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        map.showsUserLocation = true

        // Ask for Authorisation from the User.
        self.manager.requestAlwaysAuthorization()

        // For use in foreground
        self.manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
             self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
             self.manager.startUpdatingLocation()

            //Temporary fix: App crashes as it may execute before getting users current location

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1, execute: {
                let locValue:CLLocationCoordinate2D = self.manager.location!.coordinate
                //print("CURRENT LOCATION = \(locValue.latitude) \(locValue.longitude)")
                
                //let coordinate = CLLocationCoordinate2D(latitude: self.map.centerCoordinate.latitude, longitude: self.map.centerCoordinate.longitude)
                let coordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                uiView.setRegion(region, animated: true)
            })
        }
    }
    
    func makeCoordinator() -> MapView.Coordinator{
        return MapView.Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        
        //map.centerCoordinate = CLLocationCoordinate2D(latitude: map.centerCoordinate.latitude, longitude: map.centerCoordinate.longitude)
        map.centerCoordinate = CLLocationCoordinate2D(latitude: map.centerCoordinate.latitude, longitude: map.centerCoordinate.longitude)
        map.setRegion(MKCoordinateRegion(center: map.centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        return map
    }
    
    
    
    class Coordinator : NSObject, CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied {
                print("denied")
            }
            if status == .authorizedWhenInUse{
                print("location success")
            }
        }
        //func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //    let last = locations.last
            //print(last!)
        //}
    }
}


struct roomDataype: Identifiable{
    var id: String
    var msg: String
}


