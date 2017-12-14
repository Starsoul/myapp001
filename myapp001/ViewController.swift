//
//  ViewController.swift
//  myapp001
//
//  Created by 江宗益 on 2017/12/11.
//  Copyright © 2017年 江宗益. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var h: UILabel!
    
    @IBOutlet weak var m: UILabel!
    
    @IBOutlet weak var s: UILabel!
    
    @IBOutlet weak var labeHs: UILabel!
    
    @IBOutlet weak var tableViwe: UITableView!
    
    @IBOutlet weak var upButton: UIButton!
    
    @IBOutlet weak var downButton: UIButton!
    
    private var isRuning = false //按鈕切換預設
    private var timer:Timer?
    private var laps:[String] = []
    
    private var hh = 0, mm = 0, ss = 0, hs = 0
    
    
    @IBAction func stat(_ sender: UIButton) {
        isRuning = !isRuning
        changeMode()
        //按鈕的切換
    }
    
    @IBAction func save(_ sender: UIButton) {
        //記錄與重置
        if isRuning{
            doLab()
        }else{
            doReset()
        }
    }
    
    private func changeMode(){
        //按鈕的設置
        if isRuning {
            upButton.setTitle("Stop", for: .normal)
            downButton.setTitle("Lab", for: .normal)
            doStar()
        }else{
            upButton.setTitle("Start", for: .normal)
            downButton.setTitle("Reset", for: .normal)
            doStop()
        }
    }
    
    private func doStar(){
        //開始與循環
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){
            _ in
            self.countJob()
        }
    }
    
    private func doStop(){
//        停止
        if let _ = timer {
            timer?.invalidate()
        }
    }
    
    private func countJob(){
        //循環計算
        hs += 1
        if hs == 100 {
            hs = 0
            ss += 1
            if ss == 60 {
                ss = 0
                mm += 1
                if mm == 60 {
                    mm = 0
                    hh += 1
                }
            }
        }
        showLabel()
    }
    
    private func doLab(){
//        紀錄在tableViwe
        laps.append("\(hh):\(mm):\(ss).\(hs)")  //格式
        tableViwe.reloadData()
        let iteam = IndexPath(item: laps.count-1, section: 0)  //紀錄的起始位置
        tableViwe.scrollToRow(at: iteam, at: .top, animated: true) //追蹤紀錄
    }
    
    private func doReset(){
//        重置的方法
        hh = 0; mm = 0; ss = 0; hs = 0
        showLabel()
        laps = []
        tableViwe.reloadData()
    }
    
    private func showLabel(){
//        顯示
        labeHs.text = String(hs)
        s.text = String(ss)
        m.text = String(mm)
        h.text = String(hh)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
//        tableviwe 實作
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViwe.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = laps[indexPath.row]
        return cell
        //        增加cell的存在陣列中
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        呼叫func
        changeMode()
        doReset()
    }
}

