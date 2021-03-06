var chart;

// color of the graph's line
var color;
var colors = {positive: "#3fb021", negative: "#b61515"};
if (account.type == 'worth')
  color = colors[account.direction];
else if (account.type == 'assets')
  color = colors.positive;
else // if (account.type == 'debts')
  color = colors.negative;
  

// y axis options for different types of accounts
var min, max;
var reversed = false;
if (account.type == 'worth' && account.direction == 'negative')
  max = 0;
else if (account.type == 'debts') {
  reversed = true;
  max = 0;
} else if (account.name == 'Savings')
  min = 0;


$(document).ready(function() {
  chart = new Highcharts.Chart({
    chart: {
      renderTo: "graph",
      defaultSeriesType: "line",
      margin: [20, 50, 50, 80], 
      zoomType: "x",
      backgroundColor: {
        linearGradient: [0, 0, 0, 400],
        stops: [
          [0, "rgb(255, 255, 255)"],
          [1, "rgb(240, 240, 240)"]
        ]
      },
      borderColor: "#98C2D5",
      borderWidth: 1
    },
    
    plotOptions: {
      line: {
        color: color,
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
        fontWeight: "bold",
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
          color: "#444",
          fontSize: "10pt"
        },
        formatter: function() {
          var prefix = (this.value < 0 ? "-" : "") + "$";
          return prefix + Highcharts.numberFormat(Math.abs(this.value) / 100, 0, '.', ',');
        }
      },
      max: max,
      min: min,
      reversed: reversed
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