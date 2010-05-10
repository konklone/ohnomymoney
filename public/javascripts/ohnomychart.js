var chart;
var colors = {positive: "#3fb021", negative: "#b61515"};

$(document).ready(function() {
  chart = new Highcharts.Chart({
    chart: {
      renderTo: "graph",
      defaultSeriesType: "line",
      margin: [20, 50, 50, 80],
      plotBackgroundColor: "#ffffff",
      zoomType: "x"
    },
    
    plotOptions: {
      line: {
        color: colors[account.direction],
        marker: {
          enabled: false
        },
        lineWidth: 3
      },
    },
    
    title: {
      text: ""
    },
    
    subtitle: {
      text: "Click and drag to zoom in",
      style: {
        color: "#366",
        fontSize: "10pt",
        marginTop: "27px",
        marginLeft: "100px",
        textAlign: "left"
      }
    },
    
    toolbar: {
      itemStyle: {
        marginTop: "48px",
        marginLeft: "100px",
        padding: "1px 7px",
        fontSize: "10pt",
        border: "1px solid #4572A7"
      }
    },
    
    xAxis: {
      type: "datetime",
      dateTimeLabelFormats: {
        day: "%b %e",
        week: "%b %e",
        month: "%b %y",
        year: "%Y"
      },
      labels: {
        style: {
          fontSize: "12pt",
          color: "#444"
        },
        y: 25
      }
    },
    
    yAxis: {
      title: {
        text: "",
      },
      labels: {
        style: {
          color: "#444"
        },
        formatter: function() {
          return formatCurrency(this.value / 100);
        }
      }
    },
    
    series: [{
      name: account.name,
      data: account.balances
    }],
    
    legend: {
      enabled: false
    }
    
  });
});


// adapted from http://javascript.internet.com/forms/currency-format.html
function formatCurrency(num) {
  num = num.toString().replace(/\$|\,/g,'');
  sign = (num == (num = Math.abs(num)));
  num = Math.floor(num * 100 + 0.50000000001);
  // cents = num % 100;
  num = Math.floor(num / 100).toString();
  // if (cents < 10) 
  //   cents = "0" + cents;
    
  for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
    num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
    
  return (sign ? '' : '-') + '$' + num; //  + '.' + cents;
}