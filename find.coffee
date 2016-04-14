### 檢測發現機會較多的品種
  思路:
    1. 根據成交金額排序,初篩出各類前20名的品種
    2. 以此法檢測谷底攀升頻率和幅度,主要是達到5%或4%漲幅的頻率
    3. 動態維護居於前10的品種,作為階段的目標品種
###

{hists} = require 'sedata'
module.exports = (symbols, Pool, PeakTrough, levels, func)->
  檢測 = (symbol, 回執)->
    hists {symbol:symbol, type:'day', len:0}, (err,arr)->
      if err?
        throw err
      pool = new Pool({回幅:{陰:0.18,陽:0.015}})
      pool.計峰篩選 = func #(燭)->燭.入選計峰 = 燭.low > 燭.動地均

      pt = new PeakTrough('動低幅')
      pt.計峰基數 = 0
      pt.計峰目標 = levels

      pool.序列(arr)
      pt.序列(pool.燭線)

      指標 = {"#{symbol}": pt.峰值分佈}
      回執 null, 指標

  for symbol in symbols
    檢測 symbol, (err, obj)->
      console.log obj


  #symbols = ['159915','150153']
