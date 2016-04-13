### 檢測發現機會較多的品種
  思路:
    1. 根據成交金額排序,初篩出各類前20名的品種
    2. 以此法檢測谷底攀升頻率和幅度,主要是達到5%或4%漲幅的頻率
    3. 動態維護居於前10的品種,作為階段的目標品種
###

{hists} = require 'sedata'
find = (symbols, Pool, PeakTrough)->
  結果 = []
  檢測 = (symbol, 回執)->
    hists {symbol:symbol, type:'day', len:0}, (err,arr)->
      if err?
        throw err
      pool = new Pool({回幅:0.015})
      pool.計峰篩選 = (燭)->燭.入選計峰 = 燭.low > 燭.動地均
      pt = new PeakTrough('動低幅')

      pool.序列(arr)
      narr = ({見底: 燭.動低幅, match: 燭.low > 燭.動地均} for 燭 in pool.燭線)
      pt.序列(narr)
      ds0 = ds1 = 0
      for each in pt.峰燭線 when each.match
        #console.log each
        if each.見底 > 0
          ds0 += 1
          if each.見底 >= 4
            ds1 += 1


      指標 = {"#{symbol}": ds1/ds0 * 100}
      回執 null, 指標

  for symbol in symbols
    檢測 symbol, (err, obj)->
      結果.push obj unless err?
      console.log obj


  #symbols = ['159915','150153']

module.exports = find
