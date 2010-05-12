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
          enabled: false,
          states: {
            hover: {
              enabled: true,
              radius: 4
            }
          }
        },
        lineWidth: 2
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
    
    tooltip: {
      formatter: function() {
        var date =  Highcharts.dateFormat("%B %e, %Y", this.x);
        var prefix = (this.y < 0 ? "-" : "") + "$";
        var money = prefix + Highcharts.numberFormat(Math.abs(this.y) / 100, 2, '.', ',');
        
        return "<p class=\"tooltip header\">" + date + "</p><p class=\"tooltip value\">" + money + "</p>";
      },
      borderColor: "#4572A7",
      borderWidth: 1,
      style: {
        padding: "10px"
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
        month: "%b '%y",
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
          var prefix = (this.value < 0 ? "-" : "") + "$";
          return prefix + Highcharts.numberFormat(Math.abs(this.value) / 100, 0, '.', ',');
        }
      },
      max: (account.type == 'worth' && account.direction == 'negative' ? 0 : null),
      min: (account.name == 'Savings' ? 0 : null)
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