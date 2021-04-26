//
//  ViewController.swift
//  TestSceneKit
//
//  Created by Genesis Creations on 9/6/20.
//  Copyright © 2020 Genesis Creations. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import FocusNode
import SmartHitTest
import SceneKit.ModelIO
import SwiftUI
import Combine
import Flutter
extension ARSCNView: ARSmartHitTest {}
class ViewController: UIViewController, ARCoachingOverlayViewDelegate, ARSCNViewDelegate {
    
    
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    
    
    @IBOutlet weak var undoButton: UIButton!
    
  
    let focusNode = FocusSquare()
    let config = ARWorldTrackingConfiguration()
   
    var size = 0
    var firstSphere = SCNNode()
    var coachingOverlay = ARCoachingOverlayView()
    var arrayOfPoint: [SCNVector3] = []
    var horiPressed = true
    var url: String = ""
    var customObjectsCount = 1;
    var customObjectsMaxCount = 5;
   // var tempURL: Product = Product(id: UUID(), product_id: "0", product_name_en: "", product_category_id: 0, product_category_name_en: "", product_category_name_ar: "", product_price: 0, product_images: [], product_details: "", is_wishlisted: "", is_available: "", specifications: [],tiles_in_unit: 0, offset: 0)
    var lastNode: SCNNode?
    var selectedNode: SCNNode?
    var currentAngleY: Float = 0.0
    var isRotating = false
  //  var stack = Stack<SCNNode>()
    //var cartItemsNumber = CartClass()
    var shapeNode = SCNNode()
    var dims = [Float]()
    var tilesInUnit: Float = 1.0
    var badgeCount: UILabel!
    var imageTemp: UIImage? = nil
    var productNameS: String = ""
    var productBrandS: String = ""
    var stack  = [SCNNode]()
    var bridge = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        badgeCount = UILabel(frame: CGRect(x: 25, y: 4, width: 15, height: 15))
//        badgeCount.layer.borderColor = UIColor.clear.cgColor
//        badgeCount.layer.borderWidth = 2
//        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
//        badgeCount.textAlignment = .center
//        badgeCount.layer.masksToBounds = true
//        badgeCount.textColor = .white
//        badgeCount.font = badgeCount.font.withSize(12)
//        badgeCount.backgroundColor = .red
//    //    badgeCount.text = "\(cartItemsNumber.items.count)"
//        cartButton.addSubview(badgeCount)
        undoButton.isHidden = true
        undoButton.isEnabled = false
        productName.text = productNameS
        productBrand.text = productBrandS
        DispatchQueue.global().async {
         let data = try? Data(contentsOf: URL(string: self.url)!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
             DispatchQueue.main.async {
                self.imageTemp = UIImage(data: data!)
                self.productImage.image = self.imageTemp
               
             }
         }
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
       setupCoachingOverlay()
        self.sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
        scene.lightingEnvironment.contents = UIColor.white
        scene.lightingEnvironment.intensity = 2.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           self.sceneView.addGestureRecognizer(tapGestureRecognizer)
          // tapGestureRecognizer.cancelsTouchesInView = false
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveNode(_:)))
         self.view.addGestureRecognizer(panGesture)

         let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateNode(_:)))
         self.view.addGestureRecognizer(rotateGesture)
        self.focusNode.viewDelegate = sceneView
        sceneView.scene.rootNode.addChildNode(self.focusNode)
        sceneView.delegate = self
      
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        resetTracking()
    }
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        restartExperience()
    }
    
    func resetTracking() {
      
        config.planeDetection = [.horizontal, .vertical]
        if #available(iOS 12.0, *) {
            config.environmentTexturing = .automatic
        }
        sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        
    }
    func restartExperience() {
        resetTracking()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.enableUI()
        }
    }
    func setupCoachingOverlay() {
        coachingOverlay.session = sceneView.session
        coachingOverlay.delegate = self
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        
        setActivatesAutomatically()
        setGoal()
    }
    

    func setActivatesAutomatically() {
        coachingOverlay.activatesAutomatically = true
    }

    func setGoal() {
        coachingOverlay.goal = .horizontalPlane
    }
    func disableUI(){
        plusButton.isHidden = true
        
        undoButton.isHidden = true
       
        focusNode.isHidden = true
    }
    func enableUI(){
        plusButton.isHidden = false
        
            undoButton.isHidden = false
      
        focusNode.isHidden = false
    }
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
     disableUI()
    }
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        enableUI()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(config)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        sceneView.session.pause()
    }
    
 
    
    func session(_ session: ARSession, didFailWithError error: Error) {
      
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
     
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
     
        
    }
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
           
        self.focusNode.updateFocusNode()
        if size >= 3 {
            let temp: Float = distance(focusNode.simdWorldPosition,firstSphere.simdWorldPosition)
            if (temp >= 0.00 && temp <= 0.1) {
                firstSphere.geometry?.firstMaterial?.diffuse.contents = UIColor.green
                self.focusNode.worldPosition = firstSphere.worldPosition
                self.focusNode.updateFocusIfNeeded()
            }else {
                firstSphere.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            }
        }
       }
   
   
    @IBAction func searchProducts(_ sender: Any) {
        var cancellable: AnyCancellable!
        let delegate = ProductsDelegate()
        let bridge = ViewModel()
                let vc = UIHostingController(rootView: AddressScreen(delegate: delegate, vm: bridge))
                bridge.closeAction = { [weak vc] in
                    vc?.dismiss(animated: true)
                 
                    cancellable = delegate.$ARProductID.sink { temp in
                      
                        
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: URL(string: appendingStringImage(text: temp.product_images?[0] ?? ""))!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                             DispatchQueue.main.async {
                                self.imageTemp = UIImage(data: data!)
                                self.shapeNode.geometry?.firstMaterial?.diffuse.contents = self.imageTemp
                                self.productImage.image = self.imageTemp
                                self.productName.text = temp.product_name_en
                                self.productBrand.text = temp.product_brand_name_en
                               
                             }
                         }
                    }
                }
                self.present(vc, animated: true, completion: nil)
    }
        
    @IBAction func backPressed(_ sender: Any) {
        self.bridge.closeAction()
        
    }
    @IBAction func cartPressed(_ sender: Any) {
//        var cancellable: AnyCancellable!
//        let delegate = ProductsDelegate()
//        let bridge = ViewModel()
//                let vc = UIHostingController(rootView: CartARScreen(delegate: delegate, vm: bridge))
//                bridge.closeAction = { [weak vc] in
//                    vc?.dismiss(animated: true)
//                    DispatchQueue.main.async {
//                        self.cartItemsNumber.items = SaveCart.getAllObjects
//                        self.badgeCount.text = "\(self.cartItemsNumber.items.count)"
//                        self.view.layoutIfNeeded()
//                    }
//                    cancellable = delegate.$ARProductID.sink { temp in
//
//                     //print("TEST1: \(temp)")
//                     }
//                }
//        self.present(vc, animated: true, completion: {
//            self.cartItemsNumber.items = SaveCart.getAllObjects
//            self.badgeCount.text = "\(self.cartItemsNumber.items.count)"
//
//        })
    }
    @IBAction func undoButtonPressed(_ sender: Any) {
       
        if(lastNode != nil && !stack.isEmpty){
        if (lastNode?.name == "sphere") {
            if(size >= 2){


                lastNode = stack.removeLast()
                
                lastNode?.removeFromParentNode()
            }
            size -= 1

            	arrayOfPoint.removeLast()

        }else if( customObjectsCount > 1) {
            customObjectsCount -= 1
        }

        lastNode = stack.removeLast()
            lastNode?.removeFromParentNode()

        }

    }
    @IBAction func addButtonPressed(_ sender: Any) {
        if(focusNode.onPlane){
        if(customObjectsCount == 1){
            tileMarking()
         
        }else if(customObjectsCount == 2){
                objectPlacement(objectName: "Bathtub")
        }else if (customObjectsCount == 3){
            objectPlacement(objectName: "Toilet")
        }
        else {
            objectPlacement(objectName: "tub")
           // tileMarking()
        }
        }
    }
    @objc func handleTap(sender:UITapGestureRecognizer) {
    
        guard let sceneView = sender.view as? ARSCNView else {return}
         let touchLcoation = sender.location(in: sceneView)
    
      guard  let hitTestResultNode = self.sceneView.hitTest(touchLcoation, options: nil).first?.node else {
        selectedNode?.position.y = (selectedNode?.position.y ?? 0.8) - 0.1
        selectedNode = nil
        return
    
      }
        if (selectedNode != nil){ selectedNode?.enumerateChildNodes { (node, stop) in
            selectedNode?.position.y = (selectedNode?.position.y ?? 0.1) - 0.1
            selectedNode = nil
            node.removeFromParentNode()
            
        }}
        if hitTestResultNode.name == "3D"{
        selectedNode = hitTestResultNode
            selectedNode?.position.y = selectedNode!.position.y + 0.1
        let tempNode = SCNNode(geometry: SCNPlane(width: 1, height: 1))
        let tempMaterial = SCNMaterial()
        tempMaterial.diffuse.contents = UIImage(named: "focus-circle")
        tempNode.geometry?.materials = [tempMaterial]
        selectedNode?.addChildNode(tempNode)
        tempNode.transform = SCNMatrix4MakeRotation(  -(.pi) / 2.0, 1.0, 0.0, 0.0)
            tempNode.position.y = tempNode.position.y - 0.8
        }
        
     }
    
    @objc func moveNode(_ gesture: UIPanGestureRecognizer) {

        if selectedNode != nil && !isRotating{

        let currentTouchPoint = gesture.location(in: self.sceneView)

        //2. Get The Next Feature Point Etc
        guard let hitTest = self.sceneView.hitTest(currentTouchPoint, types: .existingPlane).first else { return }
            
        
           
          
        let worldTransform = hitTest.worldTransform

        //4. Set The New Position
        let newPosition = SCNVector3(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)

        //5. Apply To The Node
            selectedNode?.simdPosition.x = newPosition.x
            selectedNode?.simdPosition.z = newPosition.z
         
            }
        
    }
    @objc func rotateNode(_ gesture: UIRotationGestureRecognizer){

        if selectedNode != nil{
        let rotation = Float(gesture.rotation)

        //2. If The Gesture State Has Changed Set The Nodes EulerAngles.y
        if gesture.state == .changed{
            isRotating = true
            selectedNode?.eulerAngles.y = currentAngleY + rotation
        }

        //3. If The Gesture Has Ended Store The Last Angle Of The Cube
        if(gesture.state == .ended) {
            currentAngleY =  lastNode?.eulerAngles.y ?? 0.0
            isRotating = false
        }
        }
    }
    func objectPlacement(objectName:String){
        let customObject = SCNScene(named: "Assets.scnassets/\(objectName).dae")
        let material = SCNMaterial()
        material.lightingModel = SCNMaterial.LightingModel.physicallyBased
        material.diffuse.contents = UIImage(named: "Assets.scnassets/\(objectName)_BaseColor.jpg")
        material.normal.contents = UIImage(named: "Assets.scnassets/\(objectName)_Normal.jpg")
        material.metalness.contents = UIImage(named: "Assets.scnassets/\(objectName)_Metallic.jpg")
        material.roughness.contents = UIImage(named: "Assets.scnassets/\(objectName)_Roughness.jpg")
        material.ambientOcclusion.contents = UIImage(named: "Assets.scnassets/\(objectName)_AO.jpg")
        let objectNode: SCNNode = customObject!.rootNode.childNode(withName: "\(objectName)", recursively: true)!// Get the
        objectNode.geometry?.materials = [material]
        objectNode.position = focusNode.worldPosition
        objectNode.position.y = objectNode.position.y + 0.03
        objectNode.name = "3D"
        lastNode = objectNode
        stack.append(lastNode!)

        sceneView.scene.rootNode.addChildNode(objectNode)
        if(customObjectsCount < customObjectsMaxCount){
        customObjectsCount += 1
        }
      
    }
   func tileMarking()
   {
    undoButton.isEnabled = true
    undoButton.isHidden = false
    let temp: Float = distance(focusNode.simdWorldPosition,firstSphere.simdWorldPosition)
    if size >= 3 && (temp >= 0.00 && temp <= 0.1) {
        createShape()
        return
    }
    let sphere = SCNNode(geometry: SCNSphere(radius: 0.008))
    sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.red
    sphere.position = focusNode.worldPosition
    if size == 0 {
    firstSphere = sphere
        print(firstSphere)
    }
    sphere.name = "sphere"
    sceneView.scene.rootNode.addChildNode(sphere)
    lastNode = sphere
    stack.append(lastNode!)
    arrayOfPoint.append(sphere.position)
    size += 1
   
    if(size != 1){
        addLineBetween(start: arrayOfPoint[size-2], end: arrayOfPoint[size-1])
    }
   }
    func createShape(){
        let path = UIBezierPath()
        var total: Float = 0.0
    
        total += arrayOfPoint[0].x * arrayOfPoint[(0 + 1) % arrayOfPoint.count].z - arrayOfPoint[0].z * arrayOfPoint[(0 + 1) % arrayOfPoint.count].x
        path.move(to: CGPoint(x: CGFloat(self.arrayOfPoint[0].x), y: CGFloat(self.arrayOfPoint[0].z)))
        for i in stride(from: 1, to: size, by: 1) {
            total += arrayOfPoint[i].x * arrayOfPoint[(i + 1) % arrayOfPoint.count].z - arrayOfPoint[i].z * arrayOfPoint[(i + 1) % arrayOfPoint.count].x
            path.addLine(to: CGPoint(x: CGFloat(self.arrayOfPoint[i].x), y: CGFloat(self.arrayOfPoint[i].z)))
        }
      path.addLine(to: CGPoint(x: CGFloat(self.arrayOfPoint[0].x), y: CGFloat(self.arrayOfPoint[0].z)))
        path.close()
        let totalArea = (abs(total) / 2.0)
        let tilesNeeded = ((totalArea * 100) / ( dims[0] * dims[1] )) * 100
        let numberOfBox = Int(ceil(tilesNeeded / tilesInUnit))
        let shape = SCNShape(path: path, extrusionDepth: 0.001)
        
      
        shape.chamferRadius = 0.1
        let shapeNode = SCNNode(geometry: shape)
     
      
        shapeNode.geometry?.firstMaterial?.diffuse.contents = self.imageTemp
            
        
      //  shapeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "FloorTile")
        shapeNode.geometry?.firstMaterial?.diffuse.wrapS = SCNWrapMode.repeat
    
        shapeNode.geometry?.firstMaterial?.diffuse.wrapT = SCNWrapMode.repeat
       
        shapeNode.geometry?.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(totalArea / 0.4,totalArea / 0.4 ,0)
        shapeNode.transform = SCNMatrix4MakeRotation(.pi / 2.0, 1.0, 0.0, 0.0);
       
        shapeNode.position.y = arrayOfPoint[0].y
        shapeNode.name = "sphere"
        sceneView.scene.rootNode.addChildNode(shapeNode)
   
        lastNode = shapeNode
        stack.append(lastNode!)
        if(customObjectsCount < customObjectsMaxCount){
        customObjectsCount += 1
        }
        showAlertController(areaDetails: totalArea, totalTiles: tilesNeeded, totalBoxes: numberOfBox)
    }
    func addLineBetween(start: SCNVector3, end: SCNVector3) {
        let lineGeometry = SCNGeometry.lineFrom(vector: start, toVector: end)
        let lineNode = SCNNode(geometry: lineGeometry)
        stack.append(lineNode)
        sceneView.scene.rootNode.addChildNode(lineNode)
    }
    func showAlertController(areaDetails: Float, totalTiles: Float, totalBoxes: Int)
        {
           let areaDetailsString = String(format: "%.2f", areaDetails)
        let totalTilesString = String(format: "%.2f", totalTiles)
        let alertController = UIAlertController(title: "Details", message: "Area Covered: \(areaDetailsString)m\nTiles Needed: \(totalTilesString) (\(dims[0])*\(dims[1]))\nBoxes to Buy: \(totalBoxes)", preferredStyle: UIAlertController.Style.alert);
           
        alertController.addAction(UIAlertAction(title: "Add to Cart", style: UIAlertAction.Style.cancel, handler: {(handler) in self.addTilesToCart(numberOfBox: totalBoxes)}));
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil));
           
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.20)
            let btnImage    = UIImage(systemName: "checkmark")!
        let imageButton : UIButton = UIButton(frame: CGRect(x: -10, y: -10, width: 20, height: 20))
        imageButton.setBackgroundImage(btnImage, for: UIControl.State())
            imageButton.addTarget(self, action: #selector(ViewController.checkBoxAction(_:)), for: .touchUpInside)
            alertController.view.addSubview(imageButton)
     
         alertController.view.addConstraint(height);
            self.present(alertController, animated: false, completion: { () -> Void in

                })
        }


    @objc func checkBoxAction(_ sender: UIButton)
    {
        if sender.isSelected
        {
            sender.isSelected = false
            let btnImage    = UIImage(systemName: "checkmark")!
            sender.setBackgroundImage(btnImage, for: UIControl.State())
        }else {
            sender.isSelected = true
            let btnImage    = UIImage(systemName: "square")!
            sender.setBackgroundImage(btnImage, for: UIControl.State())
        }
    }

    func addTilesToCart(numberOfBox: Int){
//    cartItemsNumber.items = SaveCart.getAllObjects
//        cartItemsNumber.append(item:CartClass.Cartitems.init(product_id: tempURL.product_id, name: tempURL.product_name_en ?? "", details: tempURL.product_details ?? "", image: tempURL.product_images?[0] ?? "", price: Float(tempURL.product_price ?? 0), quantity: numberOfBox, offset: 1, isSwiped: false))
//    SaveCart.saveAllObjects(allObjects: cartItemsNumber.items)
//        cartItemsNumber.items = SaveCart.getAllObjects
//        badgeCount.text = "\(cartItemsNumber.items.count)"
  }
}
extension SCNGeometry {
    class func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1]
        
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        
        return SCNGeometry(sources: [source], elements: [element])
    }
}
extension UIView {

    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

