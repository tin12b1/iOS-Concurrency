//
//  ViewController.swift
//  ConcurrencyDemo
//
//  Created by Hossam Ghareeb on 11/15/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

import UIKit

let imageURLs = ["http://www.history.com/s3static/video-thumbnails/AETN-History_VMS/21/149/History_Deconstructed_Eiffel_Tower_reSF_HD.jpg", "https://rocsgrp.com/assets/galleries/5683/original/gondola-venice-1680x940.jpg", "https://brightcove04pmdo-a.akamaihd.net/5104226627001/5104226627001_5285601154001_5280174686001-vs.jpg?pubId=5104226627001&videoId=5280174686001", "https://www.cornerstone-group.com/wp-content/uploads/2013/06/EMEA-Stockholm.jpg"]

class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickOnStart(_ sender: AnyObject) {
        
        queue = OperationQueue()
        let operation1 = BlockOperation(block: {
            let img1 = Downloader.downloadImageWithURL(imageURLs[0])
            OperationQueue.main.addOperation({
                self.imageView1.image = img1
            })
        })
        
        operation1.completionBlock = {
            print("Operation 1 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            OperationQueue.main.addOperation({
                self.imageView2.image = img2
            })
        })
        
        operation2.completionBlock = {
            print("Operation 2 completed, cancelled:\(operation2.isCancelled) ")
        }
        queue.addOperation(operation2)
        operation2.addDependency(operation1)
        
        let operation3 = BlockOperation(block: {
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            OperationQueue.main.addOperation({
                self.imageView3.image = img3
            })
        })
        
        operation3.completionBlock = {
            print("Operation 3 completed, cancelled:\(operation3.isCancelled) ")
        }
        queue.addOperation(operation3)
        operation3.addDependency(operation2)
        
        let operation4 = BlockOperation(block: {
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            OperationQueue.main.addOperation({
                self.imageView4.image = img4
            })
        })
        
        operation4.completionBlock = {
            print("Operation 4 completed, cancelled:\(operation4.isCancelled) ")
        }
        queue.addOperation(operation4)
    }

    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }
    
    @IBAction func didClickOnCancel(sender: AnyObject) {
        
        self.queue.cancelAllOperations()
    }
    //commit
}

