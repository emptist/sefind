{Pool,PeakTrough} = require 'seyy'
find = require './find'
symbols = ['159915','150153']
find symbols, Pool, PeakTrough, (res)->
  console.log res
