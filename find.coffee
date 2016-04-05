### 檢測發現機會較多的品種
  思路:
    1. 根據成交金額排序,初篩出各類前20名的品種
    2. 以此法檢測谷底攀升頻率和幅度,主要是達到5%或4%漲幅的頻率
    3. 動態維護居於前10的品種,作為階段的目標品種
###

{Pool,PeakTrough} = require 'seyy'
{hists} = require 'sedata'

檢測 = (symbol, 回執)->
  hists {symbol:symbol, type:'day', len:0}, (err,arr)->
    if err?
      throw err
    pool = new Pool({回幅:0.015})
    pt = new PeakTrough('見底值')

    pool.序列(arr)
    narr = ({見底值: 燭.見底} for 燭 in pool.燭線)
    pt.序列(narr)
    ds0 = ds1 = 0
    for each in pt.峰燭線
      if each.見底值 > 0
        ds0 += 1
        if each.見底值 >=5
          ds1 += 1
    回執 "#{symbol}": ds1/ds0 * 100

symbols = ['159915','150153']
結果 = []
for symbol in symbols
  檢測 symbol, (obj)->
    結果.push obj
    console.log obj
console.log 結果


#動能估算(['150153', '159915'],->)

  #這是 見底值分佈情況,可以採用 jstat 庫計算95%取信區間,只是看了下函數,不懂參數怎麼設置.


  #console.log pool.求長度() #.燭線[pool.末位].low/pool.燭線[pool.首位].low#.陰魚群#.length #.求陰魚終結池(7)#求終結池()

###
  pool.高低序列 {高:hh,低:ll}
  pool2.高低序列 {高:hh,低:ll}

  console.log pool.求主魚()
  console.log pool.求從魚()
  console.log '長魚',pool.求最近長陽魚(4).求長度()#求端點() #is pool.陽魚
  console.log '單邊上漲週期數:',pool.求最近單邊上漲燭線數()
###
