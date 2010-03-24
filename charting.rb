require 'google_chart'

helpers do
  
  def chart_for(balances)
    oldest = balances.first
    newest = balances[balances.size-1]
    amounts = balances.map {|day| day.amount}
    
    min = amounts.min
    max = amounts.max
    disparity = max - min
    y = (disparity * 1.66).to_i
    buffer = (y - disparity) / 2
    
    y_min = round(min - buffer)
    y_max = round(max + buffer)
    y = y_max - y_min
    y_step = round(y / 10.0, 2)
    
    x_step = balances.size / 7
    x_step = 1 if x_step < 1
    x_balances = []
    balances.each_with_index {|b, i| x_balances << b if i % x_step == 0}
    x_balances[0] = balances[0]
    x_balances[-1] = balances[-1]
    
    y_labels = (0..10).map {|i| format_balance(y_min + (y_step * i))}
    x_labels = x_balances.map {|day| format_date day.date_of}
    
    label = newest.amount > 0 ? 'Money' : 'Debt'
    data = amounts.map {|amount| (amount - y_min).to_f}
    color = newest.amount > 0 ? '008800' : 'cc0000'
    
    chart = GoogleChart::LineChart.new '857x350'
    chart.data_encoding = :text
    chart.max_value y
    chart.data label, data, color
    chart.axis :x, :labels => x_labels
    chart.axis :y, :labels => y_labels
    chart.axis :right, :labels => y_labels
    
    chart.to_url :chdlp => 'b'
  end
  
  def round(n, level = 3)
    (n - (n % (10**level))).to_i
  end
  
  def double_encode(text)
    text.gsub("&", "&amp;")
  end
  
  def format_balance(balance)
    number = balance.to_f / 100
    parts = ("%01.2f" % number).split('.')
    answer = '$' + number_with_delimiter(parts[0]) + '.' + parts[1].to_s
    if number > 0
      answer = '+' + answer
    elsif number < 0
      answer = '-' + answer
    end
    answer
  end
  
  def number_with_delimiter(number)
    number = number.to_i.abs
    parts = number.to_s.split('.')
    parts[0].gsub! /(\d)(?=(\d\d\d)+(?!\d))/, "\\1,"
    parts.join '.'
  end
  
  def format_date(date)
    date.strftime("%B ") + date.strftime("%d").gsub(/^0/, "")
  end
  
end